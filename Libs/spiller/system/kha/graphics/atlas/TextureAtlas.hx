package spiller.system.kha.graphics.atlas;
 
import haxe.Json;
import kha.Blob;
import kha.Image;
import kha.Loader;

import spiller.system.kha.graphics.atlas.AtlasRegion;
import spiller.SpiG;

using StringTools;

/**
 * This class represents an texture atlas.
 * A texture atlas is a link between a text (holding all the sprite positions and sizes)
 * and an image with the real representation of the sprites.
 * 
 * @version 1.0 - 02/07/2013
 * @author ratalaika / Ratalaika Games
 */
class TextureAtlas
{
	/**
	 * The atlas texture.
	 */
	private var _texture:Image;
	/**
	 * The regions this atlas has.
	 */
	private var _regions:Map<String,AtlasRegion>;

	/**
	 * Class constructor.
	 */
	public function new()
	{
		_regions = new	Map<String,AtlasRegion>();
	}
	
	/**
	 * Returns a single region.
	 * @param name The name of the region.
	 */
	public function findRegion(name: String): AtlasRegion
	{
		return _regions.get(name);
	}

	/**
	 * Load the atlas information.
	 */
	public function loadAtlas(fileText:String, graphicImage:String):Void
	{
		_texture = SpiG._cache.getImage(graphicImage);
		var packText:Blob = SpiG._cache.getBlob(fileText);
		parsePackFile(packText.toString().split("\n"));
	}

	/**
	 * Parse the pack file and obtain all the regions.
	 */
	private function parsePackFile(splitedTxt:Array<String>):Void
	{
		var elem:String = null;
		var info:AtlasRegion = null;

		// Read each file element
		var exit:Bool = false;
		var line:Int = 4;

		while (!exit) {
			elem = splitedTxt[line];
			// unused: var rotate = splitedTxt[line + 1];
			var xy:String = splitedTxt[line + 2];
			var size:String = splitedTxt[line + 3];
			// unused: var orig = splitedTxt[line + 4];
			// unused: var offset = splitedTxt[line + 5];
			// unused: var index = splitedTxt[line + 6];

			// Extract the info from the strings
			// Extract the point
			xy = xy.replace(" xy: ", "").replace(" ", "");
			var x:Int = Std.parseInt(xy.split(",")[0]);
			var y:Int = Std.parseInt(xy.split(",")[1]);

			// Extrat the size
			size = size.replace(" size: ", "").replace(" ", "");
			var w:Int = Std.parseInt(size.split(",")[0]);
			var h:Int = Std.parseInt(size.split(",")[1]);

			info = new AtlasRegion(_texture, elem, x, y, w, h);
			_regions.set(elem, info);
			
			// Increase the line counter
			line += 7;
			if (splitedTxt.length < line + 6)
				exit = true;
		}
	}
}