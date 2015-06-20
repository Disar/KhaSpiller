package spiller.util.tmx;

import kha.Image;
import spiller.math.SpiRect;

class MapTileSet
{
	private var _tileProps:Array<MapProperties> = null;
	private var _image:Image = null;
	
	public var firstGID:Int = 0;
	public var map:TiledMap = null;
	public var name:String = null;
	public var tileWidth:Int = 0;
	public var tileHeight:Int = 0;
	public var spacing:Int = 0;
	public var margin:Int = 0;
	public var imageSource:String = null;
	
	// available only after immage has been assigned:
	public var numTiles:Int = 0xFFFFFF;
	public var numRows:Int = 1;
	public var numCols:Int = 1;

	public function new(source:Dynamic, parent:TiledMap)
	{
		this.firstGID = source.firstgid;
		
		this.imageSource = source.image;
		
		this.map = parent;
		this.name = source.name;
		this.tileWidth = source.tilewidth;
		this.tileHeight = source.tileheight;
		this.spacing = source.spacing;
		this.margin = source.margin;
		
		// read properties if needed
		if(source.properties != null) {
			var propertiesNode:Dynamic = source.properties;
			for (i in 0 ... propertiesNode.length) {
				var node:Dynamic = propertiesNode[i];
				this._tileProps.push(new MapProperties(node));
			}
		}
	}
	
	public function getImage():Image
	{
		return this._image;
	}
	
	public function setImage(region:Image):Void
	{
		this._image = region;
		// TODO: consider spacing & margin
		// this.numCols = Math.floor((float)(region.getRegionWidth() / this.tileWidth));
		// this.numRows = Math.floor((float)(region.getRegionHeight() / this.tileHeight));
		this.numTiles = this.numRows * this.numCols;
	}
	
	public function hasGid(gid:Int):Bool
	{
		return (gid >= this.firstGID) && (gid < this.firstGID + this.numTiles);
	}
	
	public function fromGid(gid:Int):Int
	{
		return gid - this.firstGID;
	}
	
	public function toGid(id:Int):Int
	{
		return this.firstGID + id;
	}
	
	public function getPropertiesByGid(gid:Int):MapProperties
	{
		return this._tileProps[gid - this.firstGID];
	}
	
	public function getProperties(id:Int):MapProperties
	{
		return this._tileProps[id];
	}
	
	public function getRect(id:Int):SpiRect
	{
		// TODO: consider spacing & margin
		return new SpiRect((id % this.numCols) * this.tileWidth, (id / this.numCols) * this.tileHeight);
	}
}
