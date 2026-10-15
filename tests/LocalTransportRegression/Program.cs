using System.Collections.Concurrent;
using System.Diagnostics;
using System.Text;
using OpenRA;
using OpenRA.Network;
using OpenRA.Server;

static class Tests
{
    static void Assert(bool ok, string message) { if (!ok) throw new Exception(message); }
    static byte[] Read(Stream stream, int count)
    {
        var result = new byte[count];
        for (int pos = 0; pos < count;)
        {
            int n = stream.Read(result, pos, Math.Min(17, count-pos));
            Assert(n != 0, "Unexpected EOF"); pos += n;
        }
        return result;
    }
    static void Wait(Func<bool> condition, string message)
    {
        Assert(SpinWait.SpinUntil(condition, 5000), message);
    }
    static void RoundTrip(int session)
    {
        using var wire = new LocalTransport();
        var server = new Server();
        using var connection = new Connection(server, wire, "test");
        var stream = wire.ClientStream;
        // Same production Connection loop sends handshake, lobby payload and ping.
        byte[] header = new byte[8];
        BitConverter.GetBytes(12345).CopyTo(header,0);
        BitConverter.GetBytes(connection.PlayerIndex).CopyTo(header,4);
        Assert(connection.TrySendData(header), "Queue handshake");
        Assert(Read(stream,8).SequenceEqual(header), "Handshake changed");
        var payload = Enumerable.Range(0,170000).Select(i => (byte)(i+session)).ToArray();
        var clientFrame = new MemoryStream();
        clientFrame.Write(BitConverter.GetBytes(payload.Length+4));
        clientFrame.Write(BitConverter.GetBytes(42));
        clientFrame.Write(payload);
        byte[] bytes=clientFrame.ToArray();
        // Fragment header across separate writes; server must also split >1024-byte chunks.
        foreach (var (start,count) in new[]{(0,1),(1,2),(3,5),(8,bytes.Length-8)})
            stream.Write(bytes,start,count);
        Wait(() => server.Packets.Count == 1, "Server failed to parse fragmented orders");
        Assert(server.Packets.TryDequeue(out var packet) && packet.Frame==42 && packet.Data.SequenceEqual(payload), "Order bytes changed");
        var reply=Encoding.UTF8.GetBytes("lobby/start/"+session);
        Assert(connection.TrySendData(reply), "Queue reply");
        Assert(Read(stream,reply.Length).SequenceEqual(reply), "Reply changed");
        wire.Dispose();
        Wait(() => server.Disconnected, "Server did not notice client close");
        Assert(stream.Read(new byte[1],0,1)==0,"Expected EOF after close");
        Assert(!wire.SendToClient(new byte[]{1}),"Send after close succeeded");
    }
    static void Main()
    {
        // A bounded watchdog prevents blocked-reader bugs from hanging CI indefinitely.
        var run=Task.Run(() => {
            for(int i=0;i<10;i++) RoundTrip(i);
            using(var wire=new LocalTransport())
            {
                var read=Task.Run(()=>wire.ClientStream.Read(new byte[4],0,4));
                wire.Dispose();
                Assert(read.Wait(5000)&&read.Result==0,"Closing must release blocked client read");
            }
            using(var wire=new LocalTransport())
            {
                Assert(wire.Receive(new byte[32],1)==-1,"Timeout must differ from EOF");
                wire.ClientStream.Write(new byte[]{1,2,3},0,3);
                wire.Dispose();
                var b=new byte[32];
                Assert(wire.Receive(b,1)==3&&b[2]==3,"Close lost queued bytes");
                Assert(wire.Receive(b,1)==0,"Server must see EOF after drain");
                Assert(wire.ClientStream.Read(b,0,0)==0,"Zero-length read must not block");
            }
            Console.WriteLine("PASS: 10 independent sessions; handshake; fragmented 170 KB orders; replies; close/EOF; blocked-reader cancellation; timeout.");
        });
        Assert(run.Wait(30000),"Regression test timed out");
        run.GetAwaiter().GetResult();
    }
}

// Minimal collaborators for the real production Server.Connection code.
// No replacement socket or Connection implementation is used by these tests.
namespace OpenRA
{
    static class Game { public static long RunTime => Environment.TickCount64; }
    enum OrderType : byte { Ping = 0x20 }
    static class Log { public static void Write(string channel,string message) => Console.WriteLine(channel+": "+message); }
    static class TestWrites
    {
        public static void Write(this Stream stream,int value) => stream.Write(BitConverter.GetBytes(value));
        public static void Write(this Stream stream,long value) => stream.Write(BitConverter.GetBytes(value));
    }
}
namespace OpenRA.Server
{
    public sealed class Server
    {
        public bool IsMultiplayer => false;
        public readonly ConcurrentQueue<(int Frame,byte[] Data)> Packets=new();
        public volatile bool Disconnected;
        public int ChooseFreePlayerIndex()=>0;
        public void OnConnectionPacket(Connection connection,int frame,byte[] data)=>Packets.Enqueue((frame,data));
        public void OnConnectionPing(Connection connection,int[] pings,byte queueLength){}
        public void OnConnectionDisconnect(Connection connection)=>Disconnected=true;
    }
}
