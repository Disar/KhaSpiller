package spiller.util.tmx;

/**
 * The representation of a map object.<br>
 * <br>
 * v1.0 Initial version
 * 
 * @version 1.0 - 17/09/2014
 * @author	ratalaika / Ratalaika Games
 */
class MapObject
{
	/**
	 * The group in which this object is stored.
	 */
	public var group:MapObjects = null;
	/**
	 * The object name.
	 */
	public var name:String = null;
	/**
	 * The object type.
	 */
	public var type:String = null;
	/**
	 * The X coordinate of this object.
	 */
	public var x:Int = 0;
	/**
	 * The Y coordinate of this object.
	 */
	public var y:Int = 0;
	/**
	 * The object width.
	 */
	public var width:Int = 0;
	/**
	 * The object height.
	 */
	public var height:Int = 0;
	/**
	 * An reference to a tile.
	 */
	public var gid:Int = 0;
	/**
	 * The object custom properties.
	 */
	public var custom:MapProperties = null;
	/**
	 * The object shared properties.
	 */
	public var shared:MapProperties = null;

	/**
	 * Class constructor.
	 * 
	 * @param source
	 *            The XML representation of this object.
	 * @param parent
	 *            The parent group.
	 */
	public function new(source:Dynamic, parent:MapObjects)
	{
		// Store the paren group
		this.group = parent;
		
		// Store the object own stuff
		this.name = source.name;
		this.type = source.type;
		
		this.x = Std.int(source.x);
		this.y = Std.int(source.y);

		this.width = Std.int(source.width);
		this.height = Std.int(source.height);

		
		// Resolve inheritance
		this.shared = null;
		this.gid = -1;
		if (source.gid != null) // Object with tile association?
		{
			this.gid = source.gid;
			var tileSet:MapTileSet = this.group.map.getGidOwner(this.gid);
			if(tileSet != null)
				this.shared = tileSet.getPropertiesByGid(this.gid);
		}
		
		// Load the object properties
		if(source.properties != null) {
			this.custom = new MapProperties(source.properties);
		}
		
		// Initialize if needed
		if (this.custom == null)
			this.custom = new MapProperties(null);
		
		// Save the coordinates as properties
		this.custom.set("x", this.x);
		this.custom.set("y", this.y);
	}

	
	/**
	 * Return the object properties.
	 */
	public function getProperties():MapProperties
	{
		return custom;
	}
	
	/**
	 * Return the object name.
	 */
	public function getName():String
	{
		return name;
	}
}