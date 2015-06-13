package spiller.system.flash.events;

/**
 * A simple listener for mouse events.
 * 
 * v1.1 Class commented
 * v1.0 Initial version
 * 
 * @version 1.1 - 13/02/2013
 * @author ratalaika / Ratalaika Games
 */
class MouseEvent extends Event
{
	public static inline var MOUSE_UP:String = "onMouseUp";
	public static inline var MOUSE_DOWN:String = "onMouseDown";
	public var stageX:Int;
	public var stageY:Int;

	/**
	 * Creates an Event object that contains specific information about keyboard events.
	 * Event objects are passed as parameters to event listeners.
	 * 
	 * @param type			The event type.
	 * @param stageX		The X position of the mouse.
	 * @param stageY		The Y position of the mouse.
	 */
	public function new(type:String, stageX:Int, stageY:Int)
	{
		super(type);
		this.stageX = stageX;
		this.stageY = stageY;
	}
}