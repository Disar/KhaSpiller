package spiller.util.interfaces;

/**
 * Generic interface for poolable objects.
 * 
 * v1.0 Initial version<br>
 * <br>
 * @version 1.0 - 18/04/2015
 * @author ratalaika / ratalaikaGames
 */
interface ISpiPoolable extends ISpiDestroyable
{
	/**
	 * Put the object on a pool.
	 */
	function put():Void;
}