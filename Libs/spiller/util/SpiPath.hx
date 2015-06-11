package spiller.util;

//import spiller.plugin.SpiDebugPathDisplay;
//import spiller.system.flash.Graphics;
import spiller.util.SpiDestroyUtil;
import spiller.math.SpiPoint;

/**
 * This is a simple path data container.  Basically a list of points that<br>
 * a <code>SpiObject</code> can follow.  Also has code for drawing debug visuals.<br>
 * <code>SpiTilemap.findPath()</code> returns a path object, but you can<br>
 * also just make your own, using the <code>add()</code> functions below<br>
 * or by creating your own array of points.<br>
 * <br>
 * v1.0 Initial version
 * 
 * @version 1.0 - 17/07/2013
 * @author ratalaika / ratalaikaGames
 * @author	Thomas Weston
 * @author	Ka Wing Chin
 */
class SpiPath
{
	/**
	 * The list of <code>SpiPoint</code>s that make up the path data.
	 */
	public var nodes:Array<SpiPoint>;
	/**
	 * Specify a debug display color for the path.  Default is white.
	 */
	public var debugColor:Int;
	/**
	 * Specify a debug display scroll factor for the path.  Default is (1,1).
	 * NOTE: does not affect world movement!  Object scroll factors take care of that.
	 */
	public var debugScrollFactor:SpiPoint;
	/**
	 * Setting this to true will prevent the object from appearing
	 * when the visual debug mode in the debugger overlay is toggled on.
	 * @default false
	 */
	public var ignoreDrawDebug:Bool;
	/**
	 * Internal helper for keeping new variable instantiations under control.
	 */
	private var _point:SpiPoint;

	/**
	 * Instantiate a new path object.
	 * 
	 * @param	Nodes	Optional, can specify all the points for the path up front if you want.
	 */
	public function new(Nodes:Array<SpiPoint> = null)
	{
		if(Nodes == null)
			nodes = new Array<SpiPoint>();
		else
			nodes = Nodes;
		_point = SpiPoint.get();
		debugScrollFactor = SpiPoint.get(1.0, 1.0);
		debugColor = 0xffffff;
		ignoreDrawDebug = false;
		
		//var debugPathDisplay:SpiDebugPathDisplay = getManager();
		//if(debugPathDisplay != null)
		//	debugPathDisplay.add(this);
	}
	
	/**
	 * Clean up memory.
	 */
	public function destroy():Void
	{
		// var debugPathDisplay:SpiDebugPathDisplay = getManager();
		// if(debugPathDisplay != null)
		// 	debugPathDisplay.remove(this);
	
		_point = SpiDestroyUtil.put(_point);
		nodes = SpiDestroyUtil.putArray(nodes);
		
		debugScrollFactor = null;
		_point = null;
		nodes = null;
	}

	/**
	 * Add a new node to the end of the path at the specified location.
	 * 
	 * @param	X	X position of the new path point in world coordinates.
	 * @param	Y	Y position of the new path point in world coordinates.
	 */
	public function add(X:Float, Y:Float):Void
	{
		nodes.push(SpiPoint.get(X, Y));
	}
	
	/**
	 * Add a new node to the path at the specified location and index within the path.
	 * 
	 * @param	X		X position of the new path point in world coordinates.
	 * @param	Y		Y position of the new path point in world coordinates.
	 * @param	Index	Where within the list of path nodes to insert this new point.
	 */
	public function addAt(X:Float, Y:Float, Index:Int):Void
	{
		if(Index > nodes.length)
			Index = nodes.length;
		nodes.insert(Index, SpiPoint.get(X, Y));
	}
	
	/**
	 * Sometimes its easier or faster to just pass a point object instead of separate X and Y coordinates.
	 * This also gives you the option of not creating a new node but actually adding that specific
	 * <code>SpiPoint</code> object to the path.  This allows you to do neat things, like dynamic paths.
	 * 
	 * @param	Node			The point in world coordinates you want to add to the path.
	 * @param	AsReference		Whether to add the point as a reference, or to create a new point with the specified values.
	 */
	public function addPoint(Node:SpiPoint, AsReference:Bool = false):Void
	{
		if(AsReference)
			nodes.push(Node);
		else
			nodes.push(SpiPoint.get(Node.x, Node.y));
	}
	
	/**
	 * Sometimes its easier or faster to just pass a point object instead of separate X and Y coordinates.
	 * This also gives you the option of not creating a new node but actually adding that specific
	 * <code>SpiPoint</code> object to the path.  This allows you to do neat things, like dynamic paths.
	 * 
	 * @param	Node			The point in world coordinates you want to add to the path.
	 * @param	Index			Where within the list of path nodes to insert this new point.
	 * @param	AsReference		Whether to add the point as a reference, or to create a new point with the specified values.
	 */
	public function addPointAt(Node:SpiPoint, Index:Int, AsReference:Bool = false):Void
	{
		if(Index > nodes.length)
			Index = nodes.length;
		if(AsReference)
			nodes.insert(Index, Node);
		else
			nodes.insert(Index, SpiPoint.get(Node.x, Node.y));
	}

	/**
	 * Remove a node from the path.
	 * NOTE: only works with points added by reference or with references from <code>nodes</code> itself!
	 * 
	 * @param	Node	The point object you want to remove from the path.
	 * 
	 * @return	The node that was excised.  Returns null if the node was not found.
	 */
	public function remove(Node:SpiPoint):SpiPoint
	{
		var index:Int = nodes.indexOf(Node);
		if(index >= 0)
			return nodes.splice(index, 1)[0];
		else
			return null;
	}
	
	/**
	 * Remove a node from the path using the specified position in the list of path nodes.
	 * 
	 * @param	Index	Where within the list of path nodes you want to remove a node.
	 * 
	 * @return	The node that was excised.  Returns null if there were no nodes in the path.
	 */
	public function removeAt(Index:Int):SpiPoint
	{
		if(nodes.length <= 0)
			return null;
		if(Index >= nodes.length)
			Index = nodes.length - 1;
		return nodes.splice(Index, 1)[0];
	}
	
	/**
	 * Get the first node in the list.
	 * 
	 * @return	The first node in the path.
	 */
	public function head():SpiPoint
	{
		if(nodes.length > 0)
			return nodes[0];
		return null;
	}
	
	/**
	 * Get the last node in the list.
	 * 
	 * @return	The last node in the path.
	 */
	public function tail():SpiPoint
	{
		if(nodes.length > 0)
			return nodes[nodes.length - 1];
		return null;
	}
	
	/**
	 * While this doesn't override <code>SpiBasic.drawDebug()</code>, the behavior is very similar.
	 * Based on this path data, it draws a simple lines-and-boxes representation of the path
	 * if the visual debug mode was toggled in the debugger overlay.  You can use <code>debugColor</code>
	 * and <code>debugScrollFactor</code> to control the path's appearance.
	 * 
	 * @param	Camera		The camera object the path will draw to.
	 */
	public function drawDebug(Camera:SpiCamera = null):Void
	{
		if(nodes.length <= 0)
			return;
		if(Camera == null)
			Camera = SpiG.camera;
						
		// // Set up our global flash graphics object to draw out the path
		// Graphics gfx = SpiG.flashGfx;
		// gfx.clear();

		// //Then fill up the object with node and path graphics
		// SpiPoint node;
		// SpiPoint nextNode;
		// int i = 0;
		// int l = nodes.size;
		// while(i < l)
		// {
		// 	//get a reference to the current node
		// 	node = nodes.get(i);

		// 	//find the screen position of the node on this camera
		// 	_point.x = node.x - (int)(Camera.scroll.x*debugScrollFactor.x); //copied from getScreenXY()
		// 	_point.y = node.y - (int)(Camera.scroll.y*debugScrollFactor.y);
		// 	_point.x = (int)(_point.x + ((_point.x > 0)?0.0000001f:-0.0000001f));
		// 	_point.y = (int)(_point.y + ((_point.y > 0)?0.0000001f:-0.0000001f));

		// 	//decide what color this node should be
		// 	int nodeSize = 2;
		// 	if((i == 0) || (i == l-1))
		// 		nodeSize *= 2;
		// 	int nodeColor = debugColor;
		// 	if(l > 1)
		// 	{
		// 		if(i == 0)
		// 			nodeColor = SpiG.GREEN;
		// 		else if(i == l-1)
		// 			nodeColor = SpiG.RED;
		// 	}

		// 	//draw a box for the node
		// 	//gfx.beginFill(nodeColor,0.5);
		// 	gfx.lineStyle(1f, nodeColor, 0.5f);
		// 	gfx.drawRect(_point.x-nodeSize*0.5f,_point.y-nodeSize*0.5f,nodeSize,nodeSize);
		// 	//gfx.endFill();

		// 	//then find the next node in the path
		// 	float linealpha = 0.3f;
		// 	if(i < l-1)
		// 		nextNode = nodes.get(i+1);
		// 	else
		// 	{
		// 		nextNode = nodes.get(0);
		// 		linealpha = 0.15f;
		// 	}

		// 	//then draw a line to the next node
		// 	gfx.moveTo(_point.x,_point.y);
		// 	gfx.lineStyle(1,debugColor,linealpha);
		// 	_point.x = nextNode.x - (int)(Camera.scroll.x*debugScrollFactor.x); //copied from getScreenXY()
		// 	_point.y = nextNode.y - (int)(Camera.scroll.y*debugScrollFactor.y);
		// 	_point.x = (int)(_point.x + ((_point.x > 0)?0.0000001f:-0.0000001f));
		// 	_point.y = (int)(_point.y + ((_point.y > 0)?0.0000001f:-0.0000001f));
		// 	gfx.lineTo(_point.x,_point.y);

		// 	i++;
		// }		
	}

	/**
	 * Returns the SpiDebugPathDisplay plugin.
	 * @return
	 */
	//public static function getManager():SpiDebugPathDisplay
	//{
		//return cast(SpiG.getPlugin(SpiDebugPathDisplay), SpiDebugPathDisplay);
	//}
}