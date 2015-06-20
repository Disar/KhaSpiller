package spiller.system.input;

import spiller.SpiG;
import spiller.system.input.SpiInput.KeyState;
import spiller.system.kha.Keys;

/**
 * Keeps track of what keys are pressed and how with handy booleans or strings.
 * 
 * v1.1 Added new comments
 * v1.0 Initial version
 * 
 * @version 1.1 - January 30th 2013
 * @author Ka Wing Chin
 * @author ratalaika / Ratalaika Games
 */
class SpiKeyboard extends SpiInput
{	
	public var ESCAPE:Bool;
	public var F1:Bool;
	public var F2:Bool;
	public var F3:Bool;
	public var F4:Bool;
	public var F5:Bool;
	public var F6:Bool;
	public var F7:Bool;
	public var F8:Bool;
	public var F9:Bool;
	public var F10:Bool;
	public var F11:Bool;
	public var F12:Bool;
	public var ONE:Bool;
	public var TWO:Bool;
	public var THREE:Bool;
	public var FOUR:Bool;
	public var FIVE:Bool;
	public var SIX:Bool;
	public var SEVEN:Bool;
	public var EIGHT:Bool;
	public var NINE:Bool;
	public var ZERO:Bool;
	public var NUMPADONE:Bool;
	public var NUMPADTWO:Bool;
	public var NUMPADTHREE:Bool;
	public var NUMPADFOUR:Bool;
	public var NUMPADFIVE:Bool;
	public var NUMPADSIX:Bool;
	public var NUMPADSEVEN:Bool;
	public var NUMPADEIGHT:Bool;
	public var NUMPADNINE:Bool;
	public var NUMPADZERO:Bool;
	public var PAGEUP:Bool;
	public var PAGEDOWN:Bool;
	public var HOME:Bool;
	public var END:Bool;
	public var INSERT:Bool;
	public var MINUS:Bool;
	public var NUMPADMINUS:Bool;
	public var PLUS:Bool;
	public var NUMPADPLUS:Bool;
	public var DELETE:Bool;
	public var BACKSPACE:Bool;
	public var TAB:Bool;
	public var Q:Bool;
	public var W:Bool;
	public var E:Bool;
	public var R:Bool;
	public var T:Bool;
	public var Y:Bool;
	public var U:Bool;
	public var I:Bool;
	public var O:Bool;
	public var P:Bool;
	public var LBRACKET:Bool;
	public var RBRACKET:Bool;
	public var BACKSLASH:Bool;
	public var CAPSLOCK:Bool;
	public var A:Bool;
	public var S:Bool;
	public var D:Bool;
	public var F:Bool;
	public var G:Bool;
	public var H:Bool;
	public var J:Bool;
	public var K:Bool;
	public var L:Bool;
	public var SEMICOLON:Bool;
	public var QUOTE:Bool;
	public var ENTER:Bool;
	public var SHIFT_LEFT:Bool;
	public var SHIFT_RIGHT:Bool;
	public var Z:Bool;
	public var X:Bool;
	public var C:Bool;
	public var V:Bool;
	public var B:Bool;
	public var N:Bool;
	public var M:Bool;
	public var COMMA:Bool;
	public var PERIOD:Bool;
	public var NUMPADPERIOD:Bool;
	public var SLASH:Bool;
	public var NUMPADSLASH:Bool;
	public var CONTROL:Bool;
	public var ALT_LEFT:Bool;
	public var ALT_RIGHT:Bool;
	public var SPACE:Bool;
	public var UP:Bool;
	public var DOWN:Bool;
	public var LEFT:Bool;
	public var RIGHT:Bool;
	
	public var MOUSE_LEFT:Bool;
	public var MOUSE_RIGHT:Bool;
	public var MOUSE_MIDDLE:Bool;
	
	// Android
	public var APP_SWITCH:Bool;
	public var BACK:Bool;
	public var MENU:Bool;
	public var POWER:Bool;
	public var SEARCH:Bool;
	public var VOLUME_DOWN:Bool;
	public var VOLUME_UP:Bool;

	public function new()
	{
		super();
		// LETTERS (A-Z)
		addKey("A", Keys.A);
		addKey("B", Keys.B);
		addKey("C", Keys.C);
		addKey("D", Keys.D);
		addKey("E", Keys.E);
		addKey("F", Keys.F);
		addKey("G", Keys.G);
		addKey("H", Keys.H);
		addKey("I", Keys.I);
		addKey("J", Keys.J);
		addKey("K", Keys.K);
		addKey("L", Keys.L);
		addKey("M", Keys.M);
		addKey("N", Keys.N);
		addKey("O", Keys.O);
		addKey("P", Keys.P);
		addKey("Q", Keys.Q);
		addKey("R", Keys.R);
		addKey("S", Keys.S);
		addKey("T", Keys.T);
		addKey("U", Keys.U);
		addKey("V", Keys.V);
		addKey("W", Keys.W);
		addKey("X", Keys.X);
		addKey("Y", Keys.Y);
		addKey("Z", Keys.Z);
		
		//NUMBERS (0-9)
		addKey("ZERO", Keys.NUM_0);
		addKey("ONE", Keys.NUM_1);
		addKey("TWO", Keys.NUM_2);
		addKey("THREE", Keys.NUM_3);
		addKey("FOUR", Keys.NUM_4);
		addKey("FIVE", Keys.NUM_5);
		addKey("SIX", Keys.NUM_6);
		addKey("SEVEN", Keys.NUM_7);
		addKey("EIGHT", Keys.NUM_8);
		addKey("NINE", Keys.NUM_9);
		
		addKey("NUMPADZERO", Keys.NUMPAD_0);
		addKey("NUMPADONE", Keys.NUMPAD_1);
		addKey("NUMPADTWO", Keys.NUMPAD_2);
		addKey("NUMPADTHREE", Keys.NUMPAD_3);
		addKey("NUMPADFOUR", Keys.NUMPAD_4);
		addKey("NUMPADFIVE", Keys.NUMPAD_5);
		addKey("NUMPADSIX", Keys.NUMPAD_6);
		addKey("NUMPADSEVEN", Keys.NUMPAD_7);
		addKey("NUMPADEIGHT", Keys.NUMPAD_8);
		addKey("NUMPADNINE", Keys.NUMPAD_9);
		
		addKey("PAGEUP", Keys.PAGE_UP);
		addKey("PAGEDOWN", Keys.PAGE_DOWN);
		addKey("HOME", Keys.HOME);
		addKey("END", Keys.END);
		addKey("INSERT", Keys.INSERT);
		
		//FUNCTION KEYS (F1-F12)
		addKey("F1", Keys.F1);
		addKey("F2", Keys.F2);
		addKey("F3", Keys.F3);
		addKey("F4", Keys.F4);
		addKey("F5", Keys.F5);
		addKey("F6", Keys.F6);
		addKey("F7", Keys.F7);
		addKey("F8", Keys.F8);
		addKey("F9", Keys.F9);
		addKey("F10", Keys.F10);
		addKey("F11", Keys.F11);
		addKey("F12", Keys.F12);
		
		//SPECIAL KEYS + PUNCTUATION
		addKey("ESCAPE", Keys.ESCAPE);
		//* addKey("MINUS", Keys.MINUS);
		// addKey("NUMPADMINUS", Keys.MINUS);
		//* addKey("PLUS", Keys.PLUS);
		// addKey("NUMPADPLUS",Keys.PLUS);
		//* addKey("DELETE", Keys.DEL);
		addKey("BACKSPACE", Keys.BACKSPACE);
		//* addKey("LBRACKET", Keys.LEFT_BRACKET);
		//* addKey("RBRACKET", Keys.RIGHT_BRACKET);
		//* addKey("BACKSLASH", Keys.BACKSLASH);
		// addKey("CAPSLOCK",Keys.CAPS_LOCK);
		//* addKey("SEMICOLON", Keys.SEMICOLON);
		//* addKey("QUOTE", Keys.APOSTROPHE);
		addKey("ENTER", Keys.ENTER);
		//* addKey("SHIFT_LEFT", Keys.SHIFT_LEFT);
		//* addKey("SHIFT_RIGHT", Keys.SHIFT_RIGHT);
		//* addKey("COMMA", Keys.COMMA);
		//* addKey("PERIOD", Keys.PERIOD);
		// addKey("NUMPADPERIOD",Keys.PERIOD);
		//* addKey("SLASH", Keys.SLASH);
		// addKey("NUMPADSLASH",Keys.SLASH);
		//* addKey("CONTROL", Keys.CONTROL_LEFT);
		//* addKey("ALT_LEFT", Keys.ALT_LEFT);
		//* addKey("ALT_RIGHT", Keys.ALT_RIGHT);
		addKey("SPACE", Keys.SPACE);
		addKey("UP", Keys.UP);
		addKey("DOWN", Keys.DOWN);
		addKey("LEFT", Keys.LEFT);
		addKey("RIGHT", Keys.RIGHT);
		addKey("TAB", Keys.TAB);
		
		addKey("MOUSE_RIGHT", Keys.MOUSE_RIGHT);
		addKey("MOUSE_LEFT", Keys.MOUSE_LEFT);
		addKey("MOUSE_MIDDLE", Keys.MOUSE_MIDDLE);

		// MOBILE KEYS (Android keys)
		//* addKey("APP_SWITCH", 187); // Only in android 4.x
		//* addKey("BACK", Keys.BACK);
		//* addKey("MENU", Keys.MENU);
		//* addKey("POWER", Keys.POWER);
		//* addKey("SEARCH", Keys.SEARCH);
		//* addKey("VOLUME_DOWN", Keys.VOLUME_DOWN);
		//* addKey("VOLUME_UP", Keys.VOLUME_UP);
	}
		
	/**
	 * Event handler so SpiGame can toggle keys.
	 * 
	 * @param	KeyCode	The key code of the pressed key.
	 */
	public function handleKeyDown(KeyCode:Int):Void
	{
		if(KeyCode > _map.length)
			return;
		
		var o:KeyState = _map[KeyCode];
		if(o.name.length == 0)
			return;
		
		if(o.current > 0)
			o.current = 1;
		else
			o.current = 2;

		// Change value
		//	ClassReflection.getField(SpiKeyboard.class, o.name).set(this, true);
	}
	
	/**
	 * Event handler so SpiGame can toggle keys.
	 * 
	 * @param	KeyCode	The key code of the pressed key.
	 */
	public function handleKeyUp(KeyCode:Int):Void
	{		
		if(KeyCode > _map.length)
			return;

		var o:KeyState = _map[KeyCode];
		if(o.name.length == 0)
			return;
		
		if(o.current > 0)
			o.current = -1;
		else
			o.current = 0;
		
		// Change value
		// ClassReflection.getField(SpiKeyboard.class, o.name).set(this, false); 
	}
}
