package spiller.util;


/**
 * A very basic object pool. Used by <code>SpiQuadTree</code> and<br>
 * <code>SpiList</code> to avoid costly instantiations every frame.<br>
 * <br>
 * @param <T>	The type of object to store in this pool.<br>
 * <br>
 * v1.0 Initial version<br>
 * 
 * @version 1.0 - 25/04/2013
 * @author ratalaika / ratalaikaGames
 * @author Thomas Weston
 */
class SpiPool<T> 
{
	/**
	 * Internal, stores the pooled objects.
	 */
	private var _pool:Array<T>;
	
	/**
	 * Constructor.
	 * 
	 * @param StartSize		How many objects to initially create. Optional.
	 */
	public function new(StartSize:Int = 0)
	{
		_pool = new Array<T>();
		
		var i:Int = 0;
		while (i < StartSize) {
			_pool.push(create());
		}
	}
	
	/**
	 * Put an object back in the pool.
	 * 
	 * @param Object	The object to pool.
	 */
	public function dispose(obj:T):Void
	{
		_pool.push(obj);
	}
	
	/**
	 * Remove an object from the pool.
	 * 
	 * @param Object	The object to remove.
	 */
	public function remove(obj:T):Void
	{
		_pool.remove(obj);
	}
	
	/**
	 * Gets an object from the pool. If the pool is empty, returns
	 * a new object.
	 * 
	 * @return	A new object.
	 */
	public function getNew():T
	{
		var obj:T = null;
		if (_pool.length > 0)
			obj = _pool.pop();
		else
			obj = create();
		return obj;
	}
	
	/**
	 * Instantiates a new object.
	 * 
	 * @return A new object.
	 */
	private function create():T
	{
		throw "Implement this method!";
		return null;
	}
	
	/**
	 * Get a specific element from the pool array.<br>
	 * Use this only in really specific situations.
	 */
	public function get(index:Int):T
	{
		return _pool[index];
	}

	/**
	 * Returns the total amount of elements in the pool.
	 */
	public function size():Int
	{
		return _pool.length;
	}
}