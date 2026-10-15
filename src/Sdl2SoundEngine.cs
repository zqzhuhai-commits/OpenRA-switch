#region Copyright & License Information
/*
 * Copyright (c) The OpenRA Developers and Contributors
 * This file is part of OpenRA, which is free software. It is made
 * available to you under the terms of the GNU General Public License
 * as published by the Free Software Foundation, either version 3 of
 * the License, or (at your option) any later version. For more
 * information, see COPYING.
 */
#endregion

using System;
using System.Collections.Generic;
using System.IO;
using SDL2;

namespace OpenRA.Platforms.Default
{
	// SDL2-backed sound engine used on platforms (Switch/mono-nx) where OpenAL is unavailable.
	// Uses a single SDL audio device with a callback that mixes all active sources into
	// 16-bit stereo PCM. Positional audio is ignored (no-op) as in the Dummy engine.
	sealed class Sdl2SoundEngine : ISoundEngine
	{
		public bool Dummy => false;

		readonly uint device;
		readonly List<Sdl2Sound> activeSounds = new();
		readonly object syncRoot = new();
		float volume = 1f;

		sealed class Sdl2SoundSource : ISoundSource
		{
			public short[] Frames;
			public int SampleRate;
			public void Dispose() { Frames = null; }
		}

		sealed class Sdl2Sound : ISound
		{
			public Sdl2SoundSource Source;
			public int Position;
			public bool Loop;
			public bool Stopped;
			public bool Paused;
			float soundVolume = 1f;

			public float Volume
			{
				get => soundVolume;
				set => soundVolume = value;
			}

			public float SeekPosition => Position / (float)(Source?.SampleRate ?? 44100);
			public bool Complete => Source == null || (Source.Frames == null || Position >= Source.Frames.Length) && !Loop;

			public void SetPosition(WPos pos) { }
		}

		public Sdl2SoundEngine(string deviceName)
		{
			var want = new SDL.SDL_AudioSpec
			{
				freq = 44100,
				format = SDL.AUDIO_S16SYS,
				channels = 2,
				samples = 2048,
				callback = AudioCallback
			};

			device = SDL.SDL_OpenAudioDevice(deviceName, 0, ref want, out _, 0);
			if (device == 0)
				throw new InvalidOperationException($"SDL_OpenAudioDevice failed: {SDL.SDL_GetError()}");

			SDL.SDL_PauseAudioDevice(device, 0);
		}

		static short[] ConvertToStereo16(byte[] data, int channels, int sampleBits)
		{
			if (channels != 1 && channels != 2)
				channels = 2;

			if (sampleBits == 8)
			{
				var frameCount = data.Length / channels;
				var frames = new short[frameCount * 2];
				for (var i = 0; i < frameCount; i++)
				{
					short sample = (short)((data[i * channels] - 128) << 8);
					if (channels == 1)
					{
						frames[i * 2] = sample;
						frames[i * 2 + 1] = sample;
					}
					else
					{
						frames[i * 2] = sample;
						frames[i * 2 + 1] = (short)((data[i * channels + 1] - 128) << 8);
					}
				}

				return frames;
			}

			// 16-bit little-endian
			var count = data.Length / 2 / channels;
			var stereo = new short[count * 2];
			for (var i = 0; i < count; i++)
			{
				var offset = i * channels;
				short left = (short)(data[offset * 2] | (data[offset * 2 + 1] << 8));
				if (channels == 1)
				{
					stereo[i * 2] = left;
					stereo[i * 2 + 1] = left;
				}
				else
				{
					stereo[i * 2] = left;
					stereo[i * 2 + 1] = (short)(data[(offset + 1) * 2] | (data[(offset + 1) * 2 + 1] << 8));
				}
			}

			return stereo;
		}

		public SoundDevice[] AvailableDevices()
		{
			var devices = new List<SoundDevice>();
			var count = SDL.SDL_GetNumAudioDevices(0);
			for (var i = 0; i < count; i++)
				devices.Add(new SoundDevice(i.ToString(), SDL.SDL_GetAudioDeviceName(i, 0) ?? $"Device {i}"));

			return devices.ToArray();
		}

		public ISoundSource AddSoundSourceFromMemory(byte[] data, int channels, int sampleBits, int sampleRate)
		{
			return new Sdl2SoundSource
			{
				Frames = ConvertToStereo16(data, channels, sampleBits),
				SampleRate = sampleRate
			};
		}

		public ISound Play2D(ISoundSource soundSource, bool loop, bool relative, WPos pos, float soundVolume, bool attenuateVolume)
		{
			var source = (Sdl2SoundSource)soundSource;
			var sound = new Sdl2Sound
			{
				Source = source,
				Loop = loop,
				Volume = soundVolume
			};

			lock (syncRoot)
				activeSounds.Add(sound);

			return sound;
		}

		public ISound Play2DStream(Stream stream, int channels, int sampleBits, int sampleRate, bool loop, bool relative, WPos pos, float soundVolume)
		{
			// Read the (already decoded PCM) stream fully, then play it as a regular source.
			using var ms = new MemoryStream();
			stream.CopyTo(ms);
			var source = new Sdl2SoundSource
			{
				Frames = ConvertToStereo16(ms.ToArray(), channels, sampleBits),
				SampleRate = sampleRate
			};

			return Play2D(source, loop, relative, pos, soundVolume, false);
		}

		public float Volume
		{
			get => volume;
			set => volume = value;
		}

		public void PauseSound(ISound sound, bool paused)
		{
			if (sound is Sdl2Sound s)
				lock (syncRoot)
					s.Paused = paused;
		}

		public void SetAllSoundsPaused(bool paused)
		{
			lock (syncRoot)
				foreach (var s in activeSounds)
					s.Paused = paused;
		}

		public void SetSoundVolume(float soundVolume, ISound music, ISound video)
		{
			if (music is Sdl2Sound m)
				lock (syncRoot)
					m.Volume = soundVolume;
			if (video is Sdl2Sound v)
				lock (syncRoot)
					v.Volume = soundVolume;
		}

		public void StopSound(ISound sound)
		{
			if (sound is Sdl2Sound s)
				lock (syncRoot)
					s.Stopped = true;
		}

		public void StopAllSounds()
		{
			lock (syncRoot)
				foreach (var s in activeSounds)
					s.Stopped = true;
		}

		public void SetListenerPosition(WPos position) { }

		public void SetSoundLooping(bool looping, ISound sound)
		{
			if (sound is Sdl2Sound s)
				lock (syncRoot)
					s.Loop = looping;
		}

		public void SetSoundPosition(ISound sound, WPos position) { }

		void AudioCallback(IntPtr userdata, IntPtr stream, int len)
		{
			var frameCount = len / 4; // 16-bit stereo
			unsafe
			{
				var outFrames = (short*)stream;
				for (var i = 0; i < frameCount * 2; i++)
					outFrames[i] = 0;

				lock (syncRoot)
				{
					var master = volume;
					for (var i = activeSounds.Count - 1; i >= 0; i--)
					{
						var s = activeSounds[i];
						if (s.Stopped || s.Source == null || s.Source.Frames == null)
						{
							activeSounds.RemoveAt(i);
							continue;
						}

						if (s.Paused)
							continue;

						var frames = s.Source.Frames;
						var pos = s.Position;
						for (var f = 0; f < frameCount; f++)
						{
							if (pos >= frames.Length)
							{
								if (s.Loop)
									pos = 0;
								else
									break;
							}

							if (pos < frames.Length)
							{
								var gain = master * s.Volume;
								outFrames[f * 2] = (short)Math.Max(short.MinValue, Math.Min(short.MaxValue, outFrames[f * 2] + (int)(frames[pos * 2] * gain)));
								outFrames[f * 2 + 1] = (short)Math.Max(short.MinValue, Math.Min(short.MaxValue, outFrames[f * 2 + 1] + (int)(frames[pos * 2 + 1] * gain)));
							}

							pos++;
						}

						s.Position = pos;
						if (pos >= frames.Length && !s.Loop)
							activeSounds.RemoveAt(i);
					}
				}
			}
		}

		public void Dispose()
		{
			lock (syncRoot)
			{
				activeSounds.Clear();
				SDL.SDL_CloseAudioDevice(device);
			}
		}
	}
}
