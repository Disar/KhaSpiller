package spiller.system.flash.events;

/**
 * A listener for all the dispatched events in the game.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 13/03/2013
 * @author ratalaika / Ratalaika Games
 */
class Listener
{
	/**
	 * The type of event.
	 */
	public var type:String;

	/**
	 * The method called when dispatched event.
	 * 
	 * @param e			The type of event.
	 */
	public var onEvent:Dynamic->Void;

	/**
	 * Instantiate a new lisntener.
	 */
	 public function new(type:String, callback:Dynamic->Void)
	 {
	 	this.type = type;
	 	this.onEvent = callback;
	 }
}
