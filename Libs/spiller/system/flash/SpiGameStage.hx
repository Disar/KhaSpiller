package spiller.system.flash;

import spiller.system.flash.events.EventDispatcher;

/**
 * This class replicates some of the Stage functionality from Flash.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 25/04/2013
 * @author ratalaika / Ratalaika Games
 * @author Thomas Weston
 */
class SpiGameStage extends EventDispatcher
{
	/**
	 * The current height, in pixels, of the Stage.
	 */
	public var stageHeight:Int;
	
	/**
	 * The current width, in pixels, of the Stage.
	 */
	public var stageWidth:Int;	
	/**
	 * Creates a new stage with the specified width and height.
	 * 
	 * @param	width	The width of the stage in pixels.
	 * @param	height	The height of the stage in pixels.
	 */
	public function new(width:Int, height:Int)
	{
		super();
		stageWidth = width;
		stageHeight = height;
	}
}