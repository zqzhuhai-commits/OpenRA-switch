#region Copyright & License Information
/* Copyright (c) The OpenRA Developers and Contributors.
 * GPL-3.0-or-later; see COPYING. */
#endregion

using System;
using System.Collections.Concurrent;
using System.IO;
using System.Threading;

namespace OpenRA.Network
{
	// Carries the normal wire protocol between a local server and its sole client.
	// No sockets, DNS, ports, polling or platform-specific native APIs are needed.
	internal sealed class LocalTransport : IDisposable
	{
		readonly BlockingCollection<byte[]> toServer = new();
		readonly BlockingCollection<byte[]> toClient = new();
		byte[] serverPending;
		int serverOffset;
		int closed;

		internal Stream ClientStream { get; }

		internal LocalTransport()
		{
			ClientStream = new ClientSideStream(this);
		}

		static bool Send(BlockingCollection<byte[]> queue, byte[] data, int offset, int count)
		{
			if (count == 0)
				return true;
			var copy = new byte[count];
			Buffer.BlockCopy(data, offset, copy, 0, count);
			try { queue.Add(copy); return true; }
			catch (InvalidOperationException) { return false; }
		}

		// -1 means timeout, 0 means EOF. A positive read may be shorter than a packet.
		internal int Receive(byte[] buffer, int timeout)
		{
			if (serverPending == null)
			{
				if (!toServer.TryTake(out serverPending, timeout))
					return toServer.IsCompleted ? 0 : -1;
				serverOffset = 0;
			}

			var count = Math.Min(buffer.Length, serverPending.Length - serverOffset);
			Buffer.BlockCopy(serverPending, serverOffset, buffer, 0, count);
			serverOffset += count;
			if (serverOffset == serverPending.Length)
				serverPending = null;
			return count;
		}

		internal bool SendToClient(byte[] data) => Send(toClient, data, 0, data.Length);

		public void Dispose()
		{
			if (Interlocked.Exchange(ref closed, 1) != 0)
				return;
			// Do not dispose collections while the other thread may be reading.
			// Completing both queues wakes blocked readers and preserves queued bytes.
			toServer.CompleteAdding();
			toClient.CompleteAdding();
		}

		sealed class ClientSideStream : Stream
		{
			readonly LocalTransport owner;
			byte[] pending;
			int position;
			internal ClientSideStream(LocalTransport owner) { this.owner = owner; }
			public override bool CanRead => true;
			public override bool CanWrite => true;
			public override bool CanSeek => false;
			public override long Length => throw new NotSupportedException();
			public override long Position { get => throw new NotSupportedException(); set => throw new NotSupportedException(); }
			public override void Flush() { }
			public override long Seek(long offset, SeekOrigin origin) => throw new NotSupportedException();
			public override void SetLength(long value) => throw new NotSupportedException();

			public override int Read(byte[] buffer, int offset, int count)
			{
				ArgumentNullException.ThrowIfNull(buffer);
				if (offset < 0 || count < 0 || offset > buffer.Length - count)
					throw new ArgumentOutOfRangeException(nameof(count));
				if (count == 0)
					return 0;
				if (pending == null)
				{
					if (!owner.toClient.TryTake(out pending, Timeout.Infinite))
						return 0;
					position = 0;
				}

				var read = Math.Min(count, pending.Length - position);
				Buffer.BlockCopy(pending, position, buffer, offset, read);
				position += read;
				if (position == pending.Length)
					pending = null;
				return read;
			}

			public override void Write(byte[] buffer, int offset, int count)
			{
				ArgumentNullException.ThrowIfNull(buffer);
				if (offset < 0 || count < 0 || offset > buffer.Length - count)
					throw new ArgumentOutOfRangeException(nameof(count));
				if (!Send(owner.toServer, buffer, offset, count))
					throw new IOException("The local server connection is closed.");
			}

			protected override void Dispose(bool disposing)
			{
				if (disposing)
					owner.Dispose();
				base.Dispose(disposing);
			}
		}
	}
}
