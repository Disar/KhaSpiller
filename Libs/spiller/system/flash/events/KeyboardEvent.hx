package spiller.system.flash.events;

/**
 * Keyboard event.<br>
 * <br>
 * v1.0 Initial version<br>
 * 
 * @version 1.0 - 06/08/2013
 * @author ratalaika / Ratalaika Games
 */
class KeyboardEvent extends Event
{
	public static inline var KEY_DOWN:String = "keyDown";
	public static inline var KEY_UP:String = "keyUp";
	public static inline var PAD_DOWN:String = "padDown";
	public static inline var PAD_UP:String = "padUp";
	public static inline var KEY_TYPED:String = "keyTyped";
	public var charCode:Int;
	public var keyCode:Int;

	/**
	 * Creates an Event object that contains specific information about keyboard events.
	 * Event objects are passed as parameters to event listeners.
	 * 
	 * @param type			The event type.
	 */
	public function new(type:String, keyCode:Int = 0, charCode:Int = 0)
	{
		super(type);
		this.charCode = charCode;
		this.keyCode = keyCode;
	}
}