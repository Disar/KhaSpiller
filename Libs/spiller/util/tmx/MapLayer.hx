package spiller.util.tmx;

/**
 * The representation of a map layer.<br>
 * <br>
 * v1.0 Initial version
 * 
 * @version 1.0 - 17/09/2014
 * @author	ratalaika / Ratalaika Games
 */
class MapLayer
{
	/**
	 * The map where this layer is placed.
	 */
	public var map:TiledMap = null;
	/**
	 * The layer name.
	 */
	public var name:String = null;
	/**
	 * The X coordinate of this layer.
	 */
	public var x:Int = 0;
	/**
	 * The Y coordinate of this layer.
	 */
	public var y:Int = 0;
	/**
	 * The layer width.
	 */
	public var width:Int = 0;
	/**
	 * The layer height.
	 */
	public var height:Int = 0;
	/**
	 * The layer opacity (alpha value).
	 */
	public var opacity:Float = 0;
	/**
	 * If the layer is visible or not.
	 */
	public var visible:Bool = false;
	/**
	 * The tile gid.
	 */
	private var _tileGIDs:Array<Array<Int>> = null;
	/**
	 * The layer properties.
	 */
	public var properties:MapProperties = null;

	/**
	 * Class constructor.
	 * 
	 * @param source
	 *            The XML representation of this layer.
	 * @param parent
	 *            The parent map.
	 */
	public function new(source:Dynamic, parent:TiledMap)
	{
		// Store the paren map
		this.map = parent;
		
		// Store the layer own stuff
		this.name = source.name;
		this.x = source.x;
		this.y = source.y;
		this.width = source.width;
		this.height = source.height;
		this.visible = !(source.visible == null) || (source.visible != 0);
		
		this.opacity = 1;

		// Load the layer properties
		if(source.properties != null) {
			this.properties = new MapProperties(source.properties);
		}
		
		// Load tile GIDs
		this._tileGIDs = new Array<Array<Int>>();
		if (source.data != null) {
			var data:Dynamic = source.data;

			// Create a 2dimensional array
			var x:Int = 0;
			var y:Int = 0;
			for (i in 0 ... data.length) {
				var node:Int = data[i];

				if(this._tileGIDs[x] == null)
					this._tileGIDs[x] = new Array<Int>();
	
				// Store the node
				this._tileGIDs[x][y] = node;

				// New line?
				if (++x >= this.width) {
					y++;
					x = 0;
				}
			}
		}
	}

	/**
	 * Convert this layer to a String usable for FlxTilemap.
	 * 
	 * @param tileSet
	 *            The map tileset.
	 */
	public function toCsv(simple:Bool = false, tileSet:MapTileSet = null):String
	{
		var max:Int = 0xFFFFFF;
		var offset:Int = 0;
		if (tileSet != null) {
			offset = tileSet.firstGID;
			max = tileSet.numTiles - 1;
		}
		var result:StringBuf = new  StringBuf();
		for ( y in 0 ... this.height) {
			var chunk:String = "";
			var id:Int = 0;
			for ( x in 0 ... this.width) {
				id = _tileGIDs[x][y];
				id -= offset;
				
				if (id < 0 || id > max)
					id = 0;
				if(simple && id > 0)
					id = 1;
				else if(simple && id <= 0)
					id = 0;

				result.add(chunk);
				chunk = id + ",";
			}
			result.add(id + "\n");
		}

		return result.toString();
	}
	
	/**
	 * Convert a String into array.
	 * 
	 * @param input
	 *            The String to convert.
	 * @param lineWidth
	 *            The line width.
	 */
	public function csvToArray(input:String, lineWidth:Int):Array<Array<Int>>
	{
		var result:Array<Array<Int>> = new Array<Array<Int>>();
		var rows:Array<String> = input.split("\n");
		for ( i in 0 ... rows.length) {
			var row:String = rows[i];
			var resultRow:Array<Int> = new Array<Int>();
			var entries:Array<String> = row.split(",");
			for ( j in 0 ... entries.length) {
				var entry:String = entries[j];
				resultRow[j] = Std.parseInt(entry); // Convert to uint
			}
			result.push(resultRow);
		}
		return result;
	}
}
