package spiller.animation;

/**
 * Just a helper structure for the SpiSprite animation system.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 06/08/2013
 * @author ratalaika / Ratalaika Games
 * @author Ka Wing Chin
 */
class SpiAnim
{
	/**
	 * The id generator.
	 */
	private static var _objectId:Int;
	/**
	 * The animation id.
	 */
	public var ID:Int;
	/**
	 * String name of the animation (e.g. "walk")
	 */
	public var name:String;
	/**
	 * Seconds between frames (basically the framerate)
	 */
	public var delay:Float;
	/**
	 * A list of frames stored as <code>uint</code> objects
	 */
	public var frames:Array<Int>;
	/**
	 * The frame rates for variable frame value.
	 */
	public var frameDelays:Array<Float>;
	/**
	 * Whether or not the animation is looped
	 */
	public var looped:Bool;
	
	/**
	 * Initializes a new animation.
	 * 
	 * @param name				What this animation should be called (e.g. "run")
	 * @param frames			An array of numbers indicating what frames to play in what order (e.g. 1, 2, 3)
	 * @param frameRate			The speed in frames per second that the animation should play at (e.g. 40)
	 * @param frameRateArray	The time each frame should last, in seconds.
	 * @param looped			Whether or not the animation is looped or just plays once
	 * @param id				The animation id.
	 */
	public function new(name:String, frames:Array<Int>, ?frameRate:Float = 0, ?frameRateArray:Array<Int> = null, looped:Bool = true, id:Int = -1)
	{
		if(frameRate == 0 && frameRateArray == null)
			throw "Select at least one type of frame rateing!";


		ID = (id == -1) ? _objectId++ : id;
		this.name = name;
		delay = 0;
		if(frameRate > 0)
			delay = 1.0/frameRate;

		this.frames = new Array<Int>();
		this.frames.concat(frames);
		this.looped = looped;
		

		// Set up the frame delays
		if(frameRateArray != null) {
			delay = -1;
			frameDelays = new Array<Float>();
			for(i in 0 ... frameRateArray.length) {
				frameDelays.push(1.0 / frameRateArray[i]);
			}
		}
	}
	
	/**
	 * Clean up memory.
	 */
	public function destroy():Void
	{
		frames = null;
	}
}