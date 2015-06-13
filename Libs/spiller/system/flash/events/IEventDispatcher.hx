package spiller.system.flash.events;

/**
 * This interface replicates some of the IEventDispatcher functionality from Flash.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 25/04/2013
 * @author ratalaika / Ratalaika Games
 * @author Ka Wing Chin
 */
interface IEventDispatcher
{
	/**
     * Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event.
     *
     * @param type              The type of event.
     * @param listener          The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing.
     * @param useCapture        Determines whether the listener works in the capture phase or the target and bubbling phases.
     * @param priority          The priority level of the event listener.
     * @param useWeakReference	Determines whether the reference to the listener is strong or weak.
     */
     public function addEventListener (type:String, listener:Dynamic->Void, useCapture:Bool = false, priority:Int = 0, useWeakReference:Bool = false):Void;

	/**
     * Dispatches an event into the event flow.
     *
     * @param event	The Event object that is dispatched into the event flow.
     * @return      A value of true if the event was successfully dispatched.
     */
     public function dispatchEvent (event:Event):Bool;


	/**
	 * Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
	 * @param type	The type of event.
	 */
	public function hasEventListener (type:String):Bool;

	/**
     * Removes a listener from the EventDispatcher object. If there is no matching listener registered with the EventDispatcher object, a call to this method has no effect.
     *
     * @param type         	The type of event.
     * @param listener     	The listener object to remove.
     * @param useCapture	Specifies whether the listener was registered for the capture phase or the target and bubbling phases.
     */
	public function removeEventListener (type:String, listener:Dynamic->Void, useCapture:Bool = false):Void;
}

