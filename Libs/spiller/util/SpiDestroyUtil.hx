package spiller.util;

import spiller.util.interfaces.ISpiDestroyable;
import spiller.util.interfaces.ISpiPoolable;

/**
 * Handy manager for pooling and destroying objects.
 * 
 * v1.0 Initial version<br>
 * <br>
 * @version 1.0 - 18/04/2015
 * @author ratalaika / ratalaikaGames
 */
class SpiDestroyUtil
{
	/**
	 * Checks if an object is not null before calling destroy(), always returns null.
	 * 
	 * @param	object	An ISpiDestroyable object that will be destroyed if it's not null.
	 */
	public static function destroy<T:ISpiDestroyable>(object:T):T
	{
		if (object != null) {
			object.destroy(); 
		}
		
		return null;
	}
	
	/**
	 * Destroy every element of an array of ISpiDestroyables
	 *
	 * @param	array	An Array of ISpiDestroyable objects
	 */
	public static function destroyArray<T:ISpiDestroyable>(array:Array<T>):Array<T>
	{
		if (array != null) {
			for (elem in array)
				destroy(elem);
			array.splice(0, array.length);
		}
		
		return null;
	}
	
	/**
	 * Checks if an object is not null before putting it back into the pool, always returns null.
	 * 
	 * @param	object	An ISpiPoolable object that will be put back into the pool if it's not null
	 */
	public static function put<T:ISpiPoolable>(object:T):T
	{
		if (object != null) {
			object.put();
		}
		
		return null;
	}
	
	/**
	 * Puts all objects in an Array of ISpiPoolable objects back into 
	 * the pool by calling SpiDestroyUtil.put() on them
	 *
	 * @param	array	An Array of ISpiPoolable objects
	 * @return	null
	 */
	public static function putArray<T:ISpiPoolable>(array:Array<T>):Array<T>
	{	
		if (array != null) {
			for (elem in array)
				put(elem);
			array.splice(0, array.length);
		}
		
		return null;
	}
}