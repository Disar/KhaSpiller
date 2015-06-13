package spiller.system.flash.events;

/**
 * A generic kind of event.<br>
 * <br>
 * v1.1 Commented all the code.<br>
 * v1.0 Initial version.<br>
 * 
 * @version 1.1 - 27/02/2013
 * @author ratalaika / Ratalaika Games
 */
class Event 
{
	/**
	 * The <code>ACTIVATE</code> constant defines the value of the type property
	 * of an activate event object.
	 */
	public static inline var ACTIVATE:String = "activate";
	/**
	 * The <code>Event.ADDED_TO_STAGE</code> constant defines the value of the
	 * type property of an addedToStage event object.
	 */
	public static inline var ADDED_TO_STAGE:String = "addedToStage";
	/**
	 * The <code>Event.DEACTIVATE</code> constant defines the value of the type
	 * property of a deactivate event object.
	 */
	public static inline var DEACTIVATE:String = "deactivate";
	/**
	 * The <code>Event.ENTER_FRAME</code> constant defines the value of the type
	 * property of an enterFrame event object.
	 */
	public static inline var ENTER_FRAME:String = "enterFrame";
	/**
	 * The <code>Event.REMOVED_FROM_STAGE</code> constant defines the value of
	 * the type property of a removedFromStage event object.
	 */
	public static inline var REMOVED_FROM_STAGE:String = "removedFromStage";
	/**
	 * The <code>Event.RESIZE</code> constant defines the value of the type
	 * property of a resize event object.
	 */
	public static inline var RESIZE:String = "resize";
	/**
	 * The <code>Event.SOUND_COMPLETE</code> constant defines the value of the
	 * type property of a soundComplete event object.
	 */
	public static inline var SOUND_COMPLETE:String = "soundComplete";

	/**
	 * The event type.
	 */
	public var type:String;
	
	/**
	 * Class constructor.
	 * 
	 * @param type		The event type.
	 */
	public function new(type:String)
	{
		this.type = type;
	}
}
