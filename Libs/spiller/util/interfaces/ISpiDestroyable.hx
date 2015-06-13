package spiller.util.interfaces;

/**
 * Generic inferface for a destroyable object.
 * 
 * v1.0 Initial version<br>
 * <br>
 * @version 1.0 - 18/04/2015
 * @author ratalaika / Ratalaika Games
 */
interface ISpiDestroyable
{
	/**
	 * Call this method to destroy the object and all it's content.
	 */
	function destroy():Void;
}