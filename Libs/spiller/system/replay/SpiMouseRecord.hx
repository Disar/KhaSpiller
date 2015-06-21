package spiller.system.replay;

/**
 * A helper class for the frame records, part of the replay/demo/recording system.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 08/05/2014
 * @author ratalaika / Ratalaika Games
 * @author Thomas Weston
 */
class SpiMouseRecord
{
	#if SPI_RECORD_REPLAY
	/**
	 * The main X value of the mouse in world space.
	 */
	public var x:Int;
	/**
	 * The main Y value of the mouse in world space.
	 */
	public var y:Int;
	/**
	 * The state of the left mouse button.
	 */
	public var button:Int;
	/**
	 * The state of the mouse wheel.
	 */
	public var wheel:Int;
	
	/**
	 * Instantiate a new mouse input record.
	 *  
	 * @param X			The main X value of the mouse in world space.
	 * @param Y			The main Y value of the mouse in world space.
	 * @param Button	The state of the left mouse button.
	 * @param Wheel		The state of the mouse wheel.
	 */
	public function new(X:Int, Y:Int, Button:Int, Wheel:Int)
	{
		x = X;
		y = Y;
		button = Button;
		wheel = Wheel;
	}
	#end
}
