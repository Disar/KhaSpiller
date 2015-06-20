package spiller.system.flash.events;

/**
 * The event that the text inputs receive.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 12/03/2013
 * @author ratalaika / Ratalaika Games
 */
class EnterFrameEvent extends Event
{
	public static inline var ENTER_FRAME:String = "onEnterFrame";
	
	public function new(type:String)
	{
		super(type);
	}	
}