package spiller.system.input;

import spiller.SpiG;

/**
 * Keeps track of what keys are pressed and how with handy booleans or strings.
 * 
 * v1.3 Updated reflection stuff
 * v1.2 Added performance improvements for Android.
 * v1.1 Added new comments
 * v1.0 Initial version
 * 
 * @version 1.3 - 03/07/2013
 * @author Ka Wing Chin
 * @author ratalaika / Ratalaika Games
 */
class SpiInput
{
	/**
	 * A map with the key name and key id.
	 */
	private var _lookup:Map<String, Int>;
	/**
	 * The total of keys.
	 */
	private var _total(default,null):Int = 256;
	/**
	 * An array with all the key states.
	 */
	private var _map:Array<KeyState>;
	/**
	 * Helper variable for tracking whether a key was just pressed or just
	 * released.
	 */
	private var _last:Int;

	/**
	 * Constructor
	 */
	public function new()
	{
		_lookup = new Map<String, Int>();
		_map = new Array<KeyState>();
		for (i in 0 ... _total)
			_map.push(new KeyState("", 0, 0));
	}
	
	/**
	 * Updates the key states (for tracking just pressed, just released, etc).
	 */
	public function update():Void
	{
		for(o in _map) {
			o.update();
		}
	}
	
	/**
	 * Resets all the keys.
	 */
	public function reset():Void
	{
		for(o in _map)
		{
			if (o.name.length == 0)
				continue;
			
			// Change value
			// ClassReflection.getField(SpiKeyboard.class, o.name).set(this, false); 
			o.current = 0;
			o.last = 0;
		}
	}
	
	/**
	 * Check to see if this key is pressed.
	 * 
	 * @param Key One of the key constants listed above (e.g. "LEFT" or "A").
	 * 
	 * @return Whether the key is pressed
	 */
	public function pressedKeyId(Key:Int):Bool
	{
		if(Key >= 0)
			return _map[Key].current == 1;
		return false;
	}
	
	/**
	 * Check to see if this key is pressed.
	 * 
	 * @param Key One of the key constants listed above (e.g. "LEFT" or "A").
	 * 
	 * @return Whether the key is pressed
	 */
	public function pressed(Key:String):Bool
	{
		if(_lookup.exists(Key))
			return pressedKeyId(_lookup.get(Key));
		else
			return pressedKeyId(0);
	}
	
	/**
	 * Check to see if this key was just pressed.
	 * 
	 * @param Key One of the key constants listed above (e.g. "LEFT" or "A").
	 * 
	 * @return Whether the key was just pressed
	 */
	public function justPressedKeyId(Key:Int):Bool
	{		
		if(Key >= 0)
			return _map[Key].current == 2;
		return false;
	}

	/**
	 * Check to see if this key was just pressed.
	 * 
	 * @param Key One of the key constants listed above (e.g. "LEFT" or "A").
	 * 
	 * @return Whether the key was just pressed
	 */
	public function justPressed(Key:String):Bool
	{		
		if(_lookup.exists(Key))
			return justPressedKeyId(_lookup.get(Key));
		else
			return justPressedKeyId(-1);
	}

	/**
	 * Check to see if this key is just released.
	 * 
	 * @param Key One of the key constants listed above (e.g. "LEFT" or "A").
	 * 
	 * @return Whether the key is just released.
	 */
	public function justReleasedKeyId(Key:Int):Bool
	{
		if(Key >= 0)
			return _map[Key].current == -1;
		return false;
	}

	/**
	 * Check to see if this key is just released.
	 * 
	 * @param Key One of the key constants listed above (e.g. "LEFT" or "A").
	 * 
	 * @return Whether the key is just released.
	 */
 	public function justReleased(Key:String):Bool
	{
		if(_lookup.exists(Key))
			return justReleasedKeyId(_lookup.get(Key));
		else
			return justReleasedKeyId(-1);
	}

	#if SPI_RECORD_REPLAY
	/**
	 * If any keys are not "released" (0),
	 * this function will return an array indicating
	 * which keys are pressed and what state they are in.
	 * 
	 * @return	An array of key state data.  Null if there is no data.
	 */
	public function record():Array<KeyData>
	{
		var data:Array<KeyData> = new Array<KeyData>();
		var i:Int = 0;
		while(i < _total)
		{
			var o:KeyState = _map[i++];
			if((o == null) || (o.current == 0))
				continue;
			data.push(new KeyData(i-1, o.current));
		}
		return data.length > 0 ? data: null;
	}

	/**
	 * Part of the keystroke recording system.
	 * Takes data about key presses and sets it into array.
	 * 
	 * @param	Record	Array of data about key states.
	 */
	public function playback(Record:Array<KeyData>):Void
	{
		var i:Int = 0;
		var l:Int = Record.length;
		var o:KeyData;
		var o2:KeyState;
		while(i < l)
		{
			o = Record[i++];
			o2 = _map[o.code];
			o2.current = o.value;
			if(o.value > 0) {
//					ClassReflection.getField(SpiKeyboard.class, o2.name).set(this, true); 
			}
		}
	}
	#end
	
	/**
	 * Look up the key code for any given string name of the key or button.
	 * 
	 * @param	KeyName		The <code>String</code> name of the key.
	 * 
	 * @return	The key code for that key.
	 */
	public function getKeyCode(KeyName:String):Int
	{
		if(_lookup.exists(KeyName))
			return 0;
		else
			return _lookup.get(KeyName);
	}
	
	/**
	 * Look up the key name for any given key code of the key or button.
	 * 
	 * @param	KeyCode		The <code>Integer</code> code of the key.
	 * 
	 * @return	The key name for that key.
	 */
	public function getKeyName(KeyCode:Int):String
	{
		var keys:Iterator<String> = _lookup.keys();
		var values:Iterator<Int> = _lookup.iterator();
		while(keys.hasNext()) {
			var key:String = keys.next();
			var value:Int = values.next();
			
			if(KeyCode == value)
				return key;
		}
		
		return null;
	}
	
	/**
	 * Check to see if any keys are pressed right now.
	 * 
	 * @return	Whether any keys are currently pressed.
	 */
	public function any():Bool
	{
		for (o in _map) {
			if(o.current > 0)
				return true;
		}
		return false;
	}
	
	/**
	 * An internal helper function used to build the key array.
	 * 
	 * @param KeyName String name of the key (e.g. "LEFT" or "A")
	 * @param KeyCode The numeric Flash code for this key.
	 */
	private function addKey(KeyName:String, KeyCode:Int):Void
	{
		_lookup.set(KeyName, KeyCode);
		_map[KeyCode] = new KeyState(KeyName, 0, 0);
	}
	
	/**
	 * Clean up memory.
	 */
	public function destroy():Void
	{
		_lookup = null;
		_map = null;
	}
}

/**
 * This represents the key state.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 27/06/2014
 * @author ratalaika / Ratalaika Games
 */
class KeyState
{
	/**
	 * 
	 */
	public var name:String;
	/**
	 * 
	 */
	public var current:Int;
	/**
	 * 
	 */
	public var last:Int;

	/**
	 * Class constructor.
	 * 
	 * @param name
	 * @param current
	 * @param last
	 */
	public function new(name:String, current:Int, last:Int)
	{
		this.name = name;
		this.current = current;
		this.last = last;
	}

	/**
	 * Update the key.
	 */
	public function update():Void
	{
		if((last == -1) && (current == -1))
			current = 0;
		else if((last == 2) && (current == 2))
			current = 1;
		last = current;
	}
}

/**
 * This class represent a Key.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 06/03/2013
 * @author ratalaika / Ratalaika Games
 */
class KeyData
{
	/**
	 * The Key code.
	 */
	public var code:Int;
	/**
	 * The current value.
	 */
	public var value:Int;

	/**
	 * Class constructor.
	 * 
	 * @param code		Key Code.
	 * @param value		Key Value.
	 */
	public function new(code:Int, value:Int)
	{
		this.code = code;
		this.value = value;
	}
}
