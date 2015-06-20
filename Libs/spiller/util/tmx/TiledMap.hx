package spiller.util.tmx;

import haxe.Json;

/**
 * Represents a tiled map, adds the concept of tiles and tilesets.<br>
 * <br>
 * v1.0 Initial version
 * 
 * @version 1.0 - 17/09/2014
 * @author	ratalaika / Ratalaika Games
 */
class TiledMap
{
	/**
	 * The map version.
	 */
	public var version:String = null;
	/**
	 * The map orientation.<br>
	 * Normally orthogonal or isometric.
	 */
	public var orientation:String = null;
	/**
	 * The width of the map in tiles.
	 */
	public var width:Int = 0;
	/**
	 * The height of the map in tiles.
	 */
	public var height:Int = 0;
	/**
	 * The width of the map tiles, in pixels.
	 */
	public var tileWidth:Int = 0;
	/**
	 * The height of the map tiles, in pixels.
	 */
	public var tileHeight:Int = 0;
	/**
	 * The map properties.
	 */
	public var properties:MapProperties = null;
	/**
	 * All the map tiled layers.
	 */
	public var tileLayers:Map<String, MapLayer> = null;
	/**
	 * All the map tile sets.
	 */
	public var tileSets:Map<String, MapTileSet> = null;
	/**
	 * All the map object groups.
	 */
	public var objectGroups:Map<String, MapObjects> = null;
	/**
	 * All the map layers.
	 */
	public var layers:Array<MapLayer> = null;

	/**
	 * Class constructor.
	 * 
	 * @param source
	 *            The JSON of the map file.
	 */
	public function new(jsonText:String)
	{
		var source:Dynamic = Json.parse(jsonText);

		// Read the map header
		version = (source.version != null) ? cast(source.version) : "unknown";
		orientation = (source.orientation != null) ? cast(source.orientation) : "orthogonal";
		width = source.width;
		height = source.height;
		tileWidth = source.tilewidth;
		tileHeight = source.tileheight;

		// Set up arrays
		tileSets = new Map<String, MapTileSet>();
		tileLayers = new Map<String, MapLayer>();
		layers = new Array<MapLayer>();
		objectGroups = new Map<String, MapObjects>();
		
		// Read properties
		if(source.properties != null) {
			var propertiesNode:Dynamic = source.properties;
			properties = (properties != null) ? properties.readProperties(propertiesNode) : new MapProperties(propertiesNode);
		}

		// Load tilesets
		if(source.tilesets != null) {
			var tilesets:Dynamic = source.tilesets;
			for (i in 0 ... tilesets.length) {
				var node:Dynamic = tilesets[i];
				tileSets.set(node.name, new MapTileSet(node, this));
			}
		}
		
		// Load the map layers
		if(source.layers != null) {
			var layers:Dynamic = source.layers;
			for (i in 0 ... layers.length) {
				var node:Dynamic = layers[i];
				
				// Check if it is data or object layer
				if(node.data != null) {
					tileLayers.set(node.name, new MapLayer(node, this));
					this.layers.push(tileLayers.get(node.name));
				} else if(node.objects != null) {
					objectGroups.set(node.name, new MapObjects(node, this));
					this.layers.push(objectGroups.get(node.name));
				}
			}
		}
	}
	
	/**
	 * Return a map tileset.
	 * 
	 * @param name
	 *            The tileset name.
	 */
	public function getTileSet(name:String):MapTileSet
	{
		return tileSets.get(name);
	}
	
	/**
	 * Return a map layer.
	 * 
	 * @param name
	 *            The name layer.
	 */
	public function getLayer(name:String):MapLayer
	{
		return tileLayers.get(name);
	}
	
	/**
	 * Return a map object group.
	 * 
	 * @param name
	 *            The object group name.
	 */
	public function getObjectGroup(name:String):MapObjects
	{
		return objectGroups.get(name);
	}
	
	/**
	 * Return all the map layers. This includes object group layers aswell.
	 */
	public function getLayers():Array<MapLayer>
	{
		return layers;
	}
	
	/**
	 * Return a Tileset.
	 * 
	 * Works only after TmxTileSet has been initialized with an image.
	 */
	public function getGidOwner(gid:Int):MapTileSet
	{
		var it:Iterator<MapTileSet> = tileSets.iterator();
		while(it.hasNext()) {
			var tileSet:MapTileSet = cast(it.next(), MapTileSet);
			if (tileSet.hasGid(gid))
				return tileSet;
		}
		return null;
	}
}
