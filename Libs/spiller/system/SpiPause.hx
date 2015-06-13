package spiller.system;

import spiller.SpiGroup;
import spiller.system.flash.events.Event;

/**
 * This is the Pause window, it has the main menu<br>
 * designed to close or finish the pause in the game.<br>
 * You can also add your own menus to the Pause window.<br>
 * <br>
 * v1.0 Initial version<br>
 * 
 * @version 1.0 - 07/03/2013
 * @author ratalaika / Ratalaika Games
 */
class SpiPause extends SpiGroup
{
	
}

/**
 * An event for the pause system.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 12/03/2013
 * @author ratalaika / Ratalaika Games
 */
class PauseEvent extends Event
{
	/**
	 * The pause in event name.
	 */
	public static inline var PAUSE_IN:String = "pauseIn";
	/**
	 * The pause out event name.
	 */
	public static inline var PAUSE_OUT:String = "pauseOut";
	/**
	 * A pre-allocated instance, used to prevent to much initialization.
	 */
	private static var _event:PauseEvent = new PauseEvent(null);
	

	/**
	 * Class constructor.
	 * 
	 * @param type			The event type.
	 */
	public function new(type:String)
	{
		super(type);
	}

	/**
	 * Get a new instance.
	 */
	public static function getEvent(type:String):PauseEvent
	{
		_event.type = type;
		return _event;
	}
}