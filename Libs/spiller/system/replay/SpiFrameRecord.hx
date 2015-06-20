package spiller.system.replay;

import spiller.system.input.SpiInput.KeyData;
	
/**
 * Helper class for the new replay system.  Represents all the game inputs for one "frame" or "step" of the game loop.
 * 
 * @author Thomas Weston
 */
class SpiFrameRecord
{
	/**
	 * Which frame of the game loop this record is from or for.
	 */
	public var frame:Int;
	/**
	 * An array of simple integer pairs referring to what key is pressed, and what state its in.
	 */
	public var keys:Array<KeyData>;
	/**
	 * A container for the 4 mouse state integers.
	 */
	public var mouse:SpiMouseRecord;
	
	/**
	 * Instantiate array new frame record.
	 */
	public function new()
	{
		frame = 0;
		keys = null;
		mouse = null;
	}
		
	/**
	 * Load this frame record with input data from the input managers.
	 * 
	 * @param Frame		What frame it is.
	 * @param Keys		Keyboard data from the keyboard manager.
	 * @param Mouse		Mouse data from the mouse manager.
	 * 
	 * @return A reference to this <code>FrameRecord</code> object.
	 * 
	 */
	public function create(Frame:Int, Keys:Array<KeyData> = null, Mouse:SpiMouseRecord = null):SpiFrameRecord
	{
		frame = Frame;
		keys = Keys;
		mouse = Mouse;
		return this;
	}
	
	/**
	 * Clean up memory.
	 */
	public function destroy():Void
	{
		keys = null;
		mouse = null;
	}
		
	/**
	 * Save the frame record data to array simple ASCII string.
	 * 
	 * @return	A <code>String</code> object containing the relevant frame record data.
	 */
	public function save():String
	{
		var output:String = frame+"k";
		
		if(keys != null)
		{
			var object:KeyData;
			var i:Int = 0;
			var l:Int = keys.length;
			while(i < l)
			{
				if(i > 0)
					output += ",";
				object = keys[i++];
				output += object.code+":"+object.value;
			}
		}
		
		output += "m";
		if(mouse != null)
			output += mouse.x + "," + mouse.y + "," + mouse.button + "," + mouse.wheel;
		
		return output;
	}
		
	/**
	 * Load the frame record data from array simple ASCII string.
	 * 
	 * @param	Data	A <code>String</code> object containing the relevant frame record data.
	 */
	public function load(Data:String):SpiFrameRecord
	{
		var i:Int;
		var l:Int;

		// Get frame number
		var array:Array<String> = Data.split("k");
		frame = Std.parseInt(array[0]);
		
		// Split up keyboard and mouse data
		array = array[1].split("m");
		
		var keyData:String = array[0];
		var mouseData:String = "";
		if (array.length > 1)
			mouseData = array[1];
		
		// Parse keyboard data
		if(keyData.length > 0) {
			// Get keystroke data pairs
			array = keyData.split(",");
			
			//go through each data pair and enter it into this frame's key state
			var  keyPair:Array<String>;
			i = 0;
			l = array.length;

			while(i < l) {
				keyPair = array[i++].split(":");

				if(keyPair.length == 2) {
					if(keys == null)
						keys = new Array<KeyData>();
					keys.push(new KeyData(Std.parseInt(keyPair[0]), Std.parseInt(keyPair[1])));
				}
			}
		}
		
		// Mouse data is just 4 integers, easy peezy
		if(mouseData.length > 0) {
			array = mouseData.split(",");
			if(array.length >= 4)
				mouse = new SpiMouseRecord(Std.parseInt(array[0]), Std.parseInt(array[1]), 
										   Std.parseInt(array[2]), Std.parseInt(array[3]));
		}
			
		return this;
	}
}