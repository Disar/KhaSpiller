package spiller.system.flash.events;

import spiller.system.flash.events.Listener;


/**
 * This class replicates some of the EventDispatcher functionality from Flash.
 * 
 * v1.1 Fixed event dispatching problems
 * v1.0 Initial version
 * 
 * @version 1.0 - 25/04/2013
 * @author ratalaika / Ratalaika Games
 * @author Ka Wing Chin
 */
class EventDispatcher implements IEventDispatcher
{
	/**
	 * A collection of Event Listeners.
	 */
	private var _listeners:Array<Listener>;

	/**
	 * Constructor
	 */
	public function new()
	{
		_listeners = new Array<Listener>();
	}

	/**
	 * {@inheritDoc}
	 */
	public function addEventListener (type:String, listener:Dynamic->Void, useCapture:Bool = false, priority:Int = 0, useWeakReference:Bool = false):Void
	{
		_listeners.push(new Listener(type, listener));
	}

	/**
	 * {@inheritDoc}
	 */
	public function dispatchEvent (event:Event):Bool
	{
		for (i in 0 ... _listeners.length) {
			var listener:Listener = _listeners[i];
			
			// Prevent null
			if(listener == null)
				continue;
			
			// Check the type
			if (event.type == listener.type) {
				listener.onEvent(event);
			}
		}
		return true;
	}

	/**
	 * {@inheritDoc}
	 */
	public function hasEventListener (type:String):Bool
	{
		for (i in 0 ... _listeners.length) {
			var listener:Listener = _listeners[i];
			
			// Prevent null
			if(listener == null)
				continue;
			
			// Check the type
			if (type == listener.type)
				return true;
		}
		return false;
	}

	/**
	 * {@inheritDoc}
	 */
	public function removeEventListener (type:String, listenerToRemove:Dynamic->Void, useCapture:Bool = false):Void
	{
		for (i in 0 ... _listeners.length) {
			var listener:Listener = _listeners[i];
			
			// Prevent null
			if(listener == null)
				continue;
			
			// Check the type
			if (type == listener.type && listener.onEvent == listenerToRemove) {
				_listeners.splice(_listeners.indexOf(listener), 1);
				break;
			}
		}
	}
}
