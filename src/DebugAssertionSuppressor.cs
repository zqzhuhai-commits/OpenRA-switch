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
using System.Diagnostics;

namespace OpenRA.Support
{
	// The Switch runtime (mono-nx) ships a Debug build of the .NET class
	// libraries. BCL Debug.Assert calls are therefore live, and a few of them
	// trip on ordinary OpenRA code paths (e.g. FrozenDictionary key-type checks:
	// default(enum) is not IComparable<TEnum>), aborting startup with a
	// DebugAssertException. This routes assertion failures to a no-op handler,
	// matching the behaviour of a Release build.
	public static class DebugAssertionSuppressor
	{
		public static void Suppress()
		{
#if SWITCH
			try
			{
				var provider = typeof(Debug).Assembly.GetType("System.Diagnostics.DebugProvider");
				if (provider == null)
					return;

				// Prefer the FailCore hook: DebugProvider.Fail invokes it first
				// and skips the throw-on-no-listener path entirely.
				var failCore = provider.GetField("s_FailCore", System.Reflection.BindingFlags.Static | System.Reflection.BindingFlags.NonPublic);
				if (failCore != null)
				{
					Action<string, string, string, bool> noop = (_, _, _, _) => { };
					failCore.SetValue(null, noop);
					return;
				}
			}
			catch { }

			// Fallback: install a no-op trace listener so DebugProvider.Fail has
			// somewhere to write instead of throwing.
			try
			{
				Trace.Listeners.Clear();
				Trace.Listeners.Add(new NoopTraceListener());
			}
			catch { }
#endif
		}

		sealed class NoopTraceListener : TraceListener
		{
			public override void Write(string message) { }
			public override void WriteLine(string message) { }
		}
	}
}
