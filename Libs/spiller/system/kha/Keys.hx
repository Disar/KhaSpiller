package spiller.system.kha;

class Keys
{
	public inline static var ANY:Int = -1;

	public inline static var LEFT:Int = 37;
	public inline static var UP:Int = 38;
	public inline static var RIGHT:Int = 39;
	public inline static var DOWN:Int = 40;

	public inline static var ENTER:Int = 13;
	public inline static var COMMAND:Int = 15;
	public inline static var CONTROL:Int = 17;
	public inline static var SPACE:Int = 32;
	public inline static var SHIFT:Int = 16;
	public inline static var BACKSPACE:Int = 8;
	public inline static var CAPS_LOCK:Int = 20;
	public inline static var DELETE:Int = 46;
	public inline static var END:Int = 35;
	public inline static var ESCAPE:Int = 27;
	public inline static var HOME:Int = 36;
	public inline static var INSERT:Int = 45;
	public inline static var TAB:Int = 9;
	public inline static var PAGE_DOWN:Int = 34;
	public inline static var PAGE_UP:Int = 33;
	public inline static var LEFT_SQUARE_BRACKET:Int = 219;
	public inline static var RIGHT_SQUARE_BRACKET:Int = 221;
	public inline static var TILDE:Int = 192;


	/*public inline static var a:Int = 97;
	public inline static var b:Int = 98;
	public inline static var c:Int = 99;
	public inline static var d:Int = 100;
	public inline static var e:Int = 101;
	public inline static var f:Int = 102;
	public inline static var g:Int = 103;
	public inline static var h:Int = 104;
	public inline static var i:Int = 105;
	public inline static var j:Int = 106;
	public inline static var k:Int = 107;
	public inline static var l:Int = 108;
	public inline static var m:Int = 109;
	public inline static var n:Int = 110;
	public inline static var o:Int = 111;
	public inline static var p:Int = 112;
	public inline static var q:Int = 113;
	public inline static var r:Int = 114;
	public inline static var s:Int = 115;
	public inline static var t:Int = 116;
	public inline static var u:Int = 117;
	public inline static var v:Int = 118;
	public inline static var w:Int = 119;
	public inline static var x:Int = 120;
	public inline static var y:Int = 121;
	public inline static var z:Int = 122;*/
	
	public inline static var A:Int = 65;
	public inline static var B:Int = 66;
	public inline static var C:Int = 67;
	public inline static var D:Int = 68;
	public inline static var E:Int = 69;
	public inline static var F:Int = 70;
	public inline static var G:Int = 71;
	public inline static var H:Int = 72;
	public inline static var I:Int = 73;
	public inline static var J:Int = 74;
	public inline static var K:Int = 75;
	public inline static var L:Int = 76;
	public inline static var M:Int = 77;
	public inline static var N:Int = 78;
	public inline static var O:Int = 79;
	public inline static var P:Int = 80;
	public inline static var Q:Int = 81;
	public inline static var R:Int = 82;
	public inline static var S:Int = 83;
	public inline static var T:Int = 84;
	public inline static var U:Int = 85;
	public inline static var V:Int = 86;
	public inline static var W:Int = 87;
	public inline static var X:Int = 88;
	public inline static var Y:Int = 89;
	public inline static var Z:Int = 90;

	public inline static var F1:Int = 112;
	public inline static var F2:Int = 113;
	public inline static var F3:Int = 114;
	public inline static var F4:Int = 115;
	public inline static var F5:Int = 116;
	public inline static var F6:Int = 117;
	public inline static var F7:Int = 118;
	public inline static var F8:Int = 119;
	public inline static var F9:Int = 120;
	public inline static var F10:Int = 121;
	public inline static var F11:Int = 122;
	public inline static var F12:Int = 123;
	public inline static var F13:Int = 124;
	public inline static var F14:Int = 125;
	public inline static var F15:Int = 126;

	public inline static var NUM_0:Int = 48;
	public inline static var NUM_1:Int = 49;
	public inline static var NUM_2:Int = 50;
	public inline static var NUM_3:Int = 51;
	public inline static var NUM_4:Int = 52;
	public inline static var NUM_5:Int = 53;
	public inline static var NUM_6:Int = 54;
	public inline static var NUM_7:Int = 55;
	public inline static var NUM_8:Int = 56;
	public inline static var NUM_9:Int = 57;

	public inline static var NUMPAD_0:Int = 96;
	public inline static var NUMPAD_1:Int = 97;
	public inline static var NUMPAD_2:Int = 98;
	public inline static var NUMPAD_3:Int = 99;
	public inline static var NUMPAD_4:Int = 100;
	public inline static var NUMPAD_5:Int = 101;
	public inline static var NUMPAD_6:Int = 102;
	public inline static var NUMPAD_7:Int = 103;
	public inline static var NUMPAD_8:Int = 104;
	public inline static var NUMPAD_9:Int = 105;
	public inline static var NUMPAD_ADD:Int = 107;
	public inline static var NUMPAD_DECIMAL:Int = 110;
	public inline static var NUMPAD_DIVIDE:Int = 111;
	public inline static var NUMPAD_ENTER:Int = 108;
	public inline static var NUMPAD_MULTIPLY:Int = 106;
	public inline static var NUMPAD_SUBTRACT:Int = 109;


	public inline static var MOUSE_LEFT:Int = 0;
	public inline static var MOUSE_RIGHT:Int = 1;
	public inline static var MOUSE_MIDDLE:Int = 2;

	/**
	 * Returns the name of the key.
	 * @param	char		The key to name.
	 * @return	The name.
	 */
	public static function nameOfKey(char:Int):String
	{
		if (char == -1) return "";
		
		if (char >= A && char <= Z) return String.fromCharCode(char);
		if (char >= F1 && char <= F15) return "F" + Std.string(char - 111);
		if (char >= 96 && char <= 105) return "NUMPAD " + Std.string(char - 96);
		switch (char)
		{
			case LEFT:  return "LEFT";
			case UP:    return "UP";
			case RIGHT: return "RIGHT";
			case DOWN:  return "DOWN";
			
			case LEFT_SQUARE_BRACKET: return "{";
			case RIGHT_SQUARE_BRACKET: return "}";
			case TILDE: return "~";

			case ENTER:     return "ENTER";
			case CONTROL:   return "CONTROL";
			case SPACE:     return "SPACE";
			case SHIFT:     return "SHIFT";
			case BACKSPACE: return "BACKSPACE";
			case CAPS_LOCK: return "CAPS LOCK";
			case DELETE:    return "DELETE";
			case END:       return "END";
			case ESCAPE:    return "ESCAPE";
			case HOME:      return "HOME";
			case INSERT:    return "INSERT";
			case TAB:       return "TAB";
			case PAGE_DOWN: return "PAGE DOWN";
			case PAGE_UP:   return "PAGE UP";

			case NUMPAD_ADD:      return "NUMPAD ADD";
			case NUMPAD_DECIMAL:  return "NUMPAD DECIMAL";
			case NUMPAD_DIVIDE:   return "NUMPAD DIVIDE";
			case NUMPAD_ENTER:    return "NUMPAD ENTER";
			case NUMPAD_MULTIPLY: return "NUMPAD MULTIPLY";
			case NUMPAD_SUBTRACT: return "NUMPAD SUBTRACT";
		}
		return String.fromCharCode(char);
	}
}