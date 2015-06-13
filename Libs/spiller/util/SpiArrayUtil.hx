package spiller.util;

/**
 * A set of functions for array manipulation.
 */
class SpiArrayUtil
{	
	/**
	 * Sets the length of an array.
	 * 
	 * @param	array		The array.
	 * @param	newLength	The length you want the array to have.
	 */
	@:generic
	public static function setLength<T>(array:Array<T>, newLength:Int):Void
	{
		if (newLength < 0) return;
		var oldLength:Int = array.length;
		var diff:Int = newLength - oldLength;
		if (diff < 0)
		{
			#if flash
			untyped array.length = newLength;
			#else
			diff = -diff;
			for (i in 0...diff)
			{
				array.pop();
			}
			#end
		}
	}
	
	/**
	 * Safely removes an element from an array by swapping it with the last element and calling pop()
	 * (won't do anything if the element is not in the array). This is a lot faster than regular splice(), 
	 * but it can only be used on arrays where order doesn't matter.
	 * 
	 * @param	array	The array to remove the element from
	 * @param 	element	The element to remove from the array
	 * @return	The array
	 */
	@:generic
	public static inline function fastSplice<T>(array:Array<T>, element:T):Array<T>
	{
		var index = array.indexOf(element);
		if (index != -1)
		{
			return swapAndPop(array, index);
		}
		return array;
	}
	
	/**
	 * Removes an element from an array by swapping it with the last element and calling pop().
	 * This is a lot faster than regular splice(), but it can only be used on arrays where order doesn't matter.
	 * 
	 * IMPORTANT: always count down from length to zero if removing elements from whithin a loop
	 * 
	 * var i = array.length;
	 * while (i-- > 0)
	 * {
	 *      if (array[i].shouldRemove)
	 *      {
	 *           SpiArrayUtil.swapAndPop(array, i);
	 *      }
	 * }
	 * 
	 * @param	array	The array to remove the element from
	 * @param 	index	The index of the element to be removed from the array
	 * @return	The array
	 */
	@:generic
	public static inline function swapAndPop<T>(array:Array<T>, index:Int):Array<T>
	{
		array[index] = array[array.length - 1]; // swap element to remove and last element
		array.pop();
		return array;
	}
	
	/**
	 * Clears an array structure, but leaves the object data untouched
	 * Useful for cleaning up temporary references to data you want to preserve
	 * WARNING: Can lead to memory leaks. Use destroyArray() instead for data you truly want GONE.
	 *
	 * @param	array		The array to clear out
	 * @param	Recursive	Whether to search for arrays inside of arr and clear them out, too (false by default)
	 */
	public static function clearArray<T>(array:Array<T>, recursive:Bool = false):Void
	{
		if (array != null)
		{
			if (!recursive)
			{
				while (array.length > 0)
				{
					array.pop();
				}
			}
			else
			{
				while (array.length > 0)
				{
					var thing:T = array.pop();
					if (Std.is(thing, Array))
					{
						clearArray(array, recursive);
					}
				}
			}
		}
	}
	
	/**
	 * Flattens 2D arrays into 1D arrays.
	 * Example: [[1, 2], [3, 2], [1, 1]] -> [1, 2, 3, 2, 1, 1]
	 */
	@:generic
	public static function flatten2DArray<T>(array:Array<Array<T>>):Array<T>
	{
		var result = [];
		
		for (innerArray in array)
		{
			result = result.concat(innerArray);
		}
		
		return result;
	}
	
	/**
	 * Compares the contents with == to see if the two arrays are the same.
	 * Also takes null arrays and the length of the arrays into account.
	 */
	public static function equals<T>(array1:Array<T>, array2:Array<T>):Bool
	{
		if (array1 == null && array2 == null)
			return true;
		if (array1 == null && array2 != null)
			return false;
		if (array1 != null && array2 == null)
			return false;
		if (array1.length != array2.length)
			return false;
		
		for (i in 0...array1.length)
		{
			if (array1[i] != array2[i])
			{
				return false;
			}
		}
		return true;
	}
	
	/**
	 * Returns the last element of an array or null if the array is null / empty.
	 */
	public static function last<T>(array:Array<T>):Null<T>
	{
		if (array == null || array.length == 0)
			return null;
		return array[array.length - 1];
	}
}
