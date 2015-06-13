package spiller.util;

import spiller.SpiObject;
import spiller.util.SpiPool;

/**
 * A miniature linked list class.<br>
 * Useful for optimizing time-critical or highly repetitive tasks!<br>
 * See <code>SpiQuadTree</code> for how to use it, IF YOU DARE.<br>
 * <br>
 * v1.0 Initial version<br>
 * 
 * @version 1.0 - 25/04/2013
 * @author ratalaika / Ratalaika Games
 * @author Ka Wing Chin
 */
 @:allow(spiller.util.SpiListPool)
class SpiList
{
	/**
	 * Stores a reference to a <code>SpiObject</code>.
	 */
	public var object:SpiObject;
	/**
	 * Stores a reference to the next link in the list.
	 */
	public var next:SpiList;
	
	/**
	 * Internal, a pool of <code>SpiQuadTree</code>s to prevent constant <code>new</code> calls.
	 */
	static private var _pool:SpiListPool = new SpiListPool();
	
	/**
	 * Gets a new <code>SpiList</code> from the pool.
	 * @return
	 */
	public static function getNew():SpiList
	{
		return _pool.getNew();
	}
	
	/**
	 * Creates a new link, and sets <code>object</code> and <code>next</code> to <code>null</code>.
	 */
	private function new()
	{
		object = null;
		next = null;
	}
	
	/**
	 * Clean up memory.
	 */
	public function destroy():Void
	{
		object = null;
		if(next != null)
			next.destroy();
		next = null;
		
		_pool.dispose(this);
	}
}

class SpiListPool extends SpiPool<SpiList>
{
	override
	public function create():SpiList
	{
		return new SpiList();
	}
}