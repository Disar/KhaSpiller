package spiller.util.tmx;

/**
 * The representation of a map object group.<br>
 * <br>
 * v1.0 Initial version
 * 
 * @version 1.0 - 17/09/2014
 * @author	ratalaika / Ratalaika Games
 */
class MapObjects extends MapLayer
{
	/**
	 * All The group objects.
	 */
	private var objects:Array<MapObject> = null;

	/**
	 * Class constructor.
	 * 
	 * @param source
	 *            The XML representation of this group.
	 * @param parent
	 *            The parent map.
	 */
	public function new(source:Dynamic, parent:TiledMap)
	{
		super(source, parent);
		this.objects = new Array<MapObject>();

		// Load the group objects
		if (source.objects != null) {
			var objects:Array<Dynamic> = cast(source.objects, Array<Dynamic>);
			for (i in 0 ... objects.length) {
				var obj:Dynamic = objects[i];
				this.objects.push(new MapObject(obj, this));
			}
		}
	}

	/**
	 * Return the number of objects.
	 */
	public function getCount():Int
	{
		return objects.length;
	}
	
	/**
	 * Return an object form this map.
	 */
	public function get(index:Int):MapObject
	{
		return this.objects[index];
	}
}
