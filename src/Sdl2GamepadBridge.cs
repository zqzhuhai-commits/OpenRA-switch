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

#if SWITCH
using System;
using OpenRA.Primitives;
using SDL2;

namespace OpenRA.Platforms.Default
{
	// Gamepad-to-mouse/keyboard bridge for the Nintendo Switch port.
	// Reads the first SDL game controller each frame and synthesizes
	// SDL mouse/keyboard events via SDL_PushEvent, which flow through
	// the normal SDL_PollEvent pipeline in Sdl2Input.
	sealed class Sdl2GamepadBridge
	{
		const int AxisDeadzone = 8000;
		const int AxisStickThreshold = 16000;

		const uint SdlInitJoystick = 0x00000010;
		const uint SdlInitGameController = 0x00002000;

		// Cursor speed in surface pixels per frame at full stick deflection
		const float CursorSpeed = 28f;

		static IntPtr controller = IntPtr.Zero;
		static int2 cursor;
		static bool hasCursor;
		static bool leftDown;
		static bool rightDown;
		static bool xDown;
		static bool yDown;
		static bool startDown;
		static bool backDown;
		static bool dpadUp, dpadDown, dpadLeft, dpadRight;
		static bool stickUp, stickDown, stickLeft, stickRight;
		static bool l3Down, r3Down;

		public static void Update(Sdl2PlatformWindow device)
		{
			// Make sure the joystick / game controller subsystems are active
			SDL.SDL_InitSubSystem(SdlInitJoystick | SdlInitGameController);

			if (controller == IntPtr.Zero)
			{
				if (SDL.SDL_NumJoysticks() > 0)
					controller = SDL.SDL_GameControllerOpen(0);
				else
					return;
			}

			if (controller == IntPtr.Zero || SDL.SDL_GameControllerGetAttached(controller) == 0)
				return;

			SDL.SDL_GameControllerUpdate();

			var surfaceSize = device.SurfaceSize;
			if (!hasCursor)
			{
				cursor = new int2(surfaceSize.Width / 2, surfaceSize.Height / 2);
				hasCursor = true;
			}

			var leftX = SDL.SDL_GameControllerGetAxis(controller, SDL.SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_LEFTX);
			var leftY = SDL.SDL_GameControllerGetAxis(controller, SDL.SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_LEFTY);
			var rightX = SDL.SDL_GameControllerGetAxis(controller, SDL.SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_RIGHTX);
			var rightY = SDL.SDL_GameControllerGetAxis(controller, SDL.SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_RIGHTY);
			var triggerLeft = SDL.SDL_GameControllerGetAxis(controller, SDL.SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_TRIGGERLEFT);
			var triggerRight = SDL.SDL_GameControllerGetAxis(controller, SDL.SDL_GameControllerAxis.SDL_CONTROLLER_AXIS_TRIGGERRIGHT);

			// Left stick -> virtual mouse cursor
			var len = (float)Math.Sqrt(leftX * leftX + leftY * leftY);
			if (len > AxisDeadzone)
			{
				var norm = Math.Min(1f, len / 32767f);
				var speed = CursorSpeed * norm * norm;
				var dx = (int)(leftX / len * speed);
				var dy = (int)(leftY / len * speed);
				var newX = Math.Clamp(cursor.X + dx, 0, surfaceSize.Width - 1);
				var newY = Math.Clamp(cursor.Y + dy, 0, surfaceSize.Height - 1);

				PushMouseMotion(newX, newY, dx, dy);
				cursor = new int2(newX, newY);
			}

			// Right stick -> arrow keys
			UpdateAxisKey(rightX, AxisStickThreshold, ref stickLeft, SDL.SDL_Scancode.SDL_SCANCODE_LEFT, SDL.SDL_Keycode.SDLK_LEFT);
			UpdateAxisKey(rightY, AxisStickThreshold, ref stickUp, SDL.SDL_Scancode.SDL_SCANCODE_UP, SDL.SDL_Keycode.SDLK_UP);
			UpdateAxisKey((short)-rightX, AxisStickThreshold, ref stickRight, SDL.SDL_Scancode.SDL_SCANCODE_RIGHT, SDL.SDL_Keycode.SDLK_RIGHT);
			UpdateAxisKey((short)-rightY, AxisStickThreshold, ref stickDown, SDL.SDL_Scancode.SDL_SCANCODE_DOWN, SDL.SDL_Keycode.SDLK_DOWN);

			// D-pad -> arrow keys
			UpdateButtonKey(IsDown(SDL.SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_DPAD_UP), ref dpadUp, SDL.SDL_Scancode.SDL_SCANCODE_UP, SDL.SDL_Keycode.SDLK_UP);
			UpdateButtonKey(IsDown(SDL.SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_DPAD_DOWN), ref dpadDown, SDL.SDL_Scancode.SDL_SCANCODE_DOWN, SDL.SDL_Keycode.SDLK_DOWN);
			UpdateButtonKey(IsDown(SDL.SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_DPAD_LEFT), ref dpadLeft, SDL.SDL_Scancode.SDL_SCANCODE_LEFT, SDL.SDL_Keycode.SDLK_LEFT);
			UpdateButtonKey(IsDown(SDL.SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_DPAD_RIGHT), ref dpadRight, SDL.SDL_Scancode.SDL_SCANCODE_RIGHT, SDL.SDL_Keycode.SDLK_RIGHT);

			// A -> left click
			UpdateMouseButton(IsDown(SDL.SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_A), ref leftDown, SDL.SDL_BUTTON_LEFT);

			// B -> right click
			UpdateMouseButton(IsDown(SDL.SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_B), ref rightDown, SDL.SDL_BUTTON_RIGHT);

			// X -> Enter
			UpdateButtonKey(IsDown(SDL.SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_X), ref xDown, SDL.SDL_Scancode.SDL_SCANCODE_RETURN, SDL.SDL_Keycode.SDLK_RETURN);

			// Y / Start -> Escape (open/close menu)
			UpdateButtonKey(IsDown(SDL.SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_Y), ref yDown, SDL.SDL_Scancode.SDL_SCANCODE_ESCAPE, SDL.SDL_Keycode.SDLK_ESCAPE);
			UpdateButtonKey(IsDown(SDL.SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_START), ref startDown, SDL.SDL_Scancode.SDL_SCANCODE_ESCAPE, SDL.SDL_Keycode.SDLK_ESCAPE);

			// Back / Select -> nothing for now (reserved)
			UpdateButtonKey(IsDown(SDL.SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_BACK), ref backDown, SDL.SDL_Scancode.SDL_SCANCODE_ESCAPE, SDL.SDL_Keycode.SDLK_ESCAPE);

			// Shoulder buttons -> mouse wheel (zoom)
			if (IsDown(SDL.SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_LEFTSHOULDER))
				PushMouseWheel(1);
			else if (IsDown(SDL.SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_RIGHTSHOULDER))
				PushMouseWheel(-1);

			// Triggers -> larger scroll steps
			if (triggerLeft > AxisStickThreshold)
				PushMouseWheel(3);
			else if (triggerRight > AxisStickThreshold)
				PushMouseWheel(-3);

			// Stick clicks -> hotkeys (S = stop, H = home)
			UpdateButtonKey(IsDown(SDL.SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_LEFTSTICK), ref l3Down, SDL.SDL_Scancode.SDL_SCANCODE_S, SDL.SDL_Keycode.SDLK_s);
			UpdateButtonKey(IsDown(SDL.SDL_GameControllerButton.SDL_CONTROLLER_BUTTON_RIGHTSTICK), ref r3Down, SDL.SDL_Scancode.SDL_SCANCODE_H, SDL.SDL_Keycode.SDLK_h);
		}

		static bool IsDown(SDL.SDL_GameControllerButton button)
		{
			return SDL.SDL_GameControllerGetButton(controller, button) != 0;
		}

		static void UpdateAxisKey(short axis, int threshold, ref bool state, SDL.SDL_Scancode scancode, SDL.SDL_Keycode keycode)
		{
			var pressed = axis > threshold || axis < -threshold;
			if (pressed != state)
			{
				state = pressed;
				PushKey(pressed, scancode, keycode);
			}
		}

		static void UpdateButtonKey(bool pressed, ref bool state, SDL.SDL_Scancode scancode, SDL.SDL_Keycode keycode)
		{
			if (pressed != state)
			{
				state = pressed;
				PushKey(pressed, scancode, keycode);
			}
		}

		static void UpdateMouseButton(bool pressed, ref bool state, uint button)
		{
			if (pressed != state)
			{
				state = pressed;
				var ev = default(SDL.SDL_Event);
				ev.button.timestamp = 0;
				ev.button.windowID = 0;
				ev.button.which = 0;
				ev.button.button = (byte)button;
				ev.button.state = (byte)(pressed ? SDL.SDL_PRESSED : SDL.SDL_RELEASED);
				ev.button.x = cursor.X;
				ev.button.y = cursor.Y;
				ev.type = pressed ? SDL.SDL_EventType.SDL_MOUSEBUTTONDOWN : SDL.SDL_EventType.SDL_MOUSEBUTTONUP;
				SDL.SDL_PushEvent(ref ev);
			}
		}

		static void PushKey(bool pressed, SDL.SDL_Scancode scancode, SDL.SDL_Keycode keycode)
		{
			var ev = default(SDL.SDL_Event);
			ev.key.timestamp = 0;
			ev.key.windowID = 0;
			ev.key.state = (byte)(pressed ? SDL.SDL_PRESSED : SDL.SDL_RELEASED);
			ev.key.repeat = 0;
			ev.key.keysym.scancode = scancode;
			ev.key.keysym.sym = keycode;
			ev.key.keysym.mod = SDL.SDL_Keymod.KMOD_NONE;
			ev.type = pressed ? SDL.SDL_EventType.SDL_KEYDOWN : SDL.SDL_EventType.SDL_KEYUP;
			SDL.SDL_PushEvent(ref ev);
		}

		static void PushMouseMotion(int x, int y, int xrel, int yrel)
		{
			var ev = default(SDL.SDL_Event);
			ev.motion.timestamp = 0;
			ev.motion.windowID = 0;
			ev.motion.which = 0;
			ev.motion.x = x;
			ev.motion.y = y;
			ev.motion.xrel = xrel;
			ev.motion.yrel = yrel;
			ev.type = SDL.SDL_EventType.SDL_MOUSEMOTION;
			SDL.SDL_PushEvent(ref ev);
		}

		static void PushMouseWheel(int y)
		{
			// Update SDL's internal mouse position so SDL_GetMouseState
			// (used by OpenRA's wheel handler) matches the virtual cursor.
			var motion = default(SDL.SDL_Event);
			motion.motion.timestamp = 0;
			motion.motion.windowID = 0;
			motion.motion.which = 0;
			motion.motion.x = cursor.X;
			motion.motion.y = cursor.Y;
			motion.motion.xrel = 0;
			motion.motion.yrel = 0;
			motion.type = SDL.SDL_EventType.SDL_MOUSEMOTION;
			SDL.SDL_PushEvent(ref motion);

			var ev = default(SDL.SDL_Event);
			ev.wheel.timestamp = 0;
			ev.wheel.windowID = 0;
			ev.wheel.which = 0;
			ev.wheel.x = 0;
			ev.wheel.y = y;
			ev.wheel.direction = (uint)SDL.SDL_MouseWheelDirection.SDL_MOUSEWHEEL_NORMAL;
			ev.type = SDL.SDL_EventType.SDL_MOUSEWHEEL;
			SDL.SDL_PushEvent(ref ev);
		}
	}
}
#endif
