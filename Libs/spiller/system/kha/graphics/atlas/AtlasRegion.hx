package spiller.system.kha.graphics.atlas;

import kha.Image;

/**
 * This class represents an atlas element.
 * This can be inside a texture atlas or by itself on runtime generated textures.
 * 
 * @version 1.0 - 02/07/2013
 * @author ratalaika / Ratalaika Games
 */
class AtlasRegion
{
	/**
	 * The texture image.
	 */
	private var _image:Image;
	/**
	 * The name of this region.
	 */
	private var _name:String;
	/**
	 * The start X position of this region.
	 */
	private var _x:Int;
	/**
	 * The start Y position of this region.
	 */
	private var _y:Int;
	/**
	 * The width of this region.
	 */
	private var _width:Int;
	/**
	 * The height of this region.
	 */
	private var _height:Int;
	/**
	 * The parent texture atlas if there is any.
	 */
	private var _atlas:TextureAtlas;

	/**
	 * Create a new atlas region instance.
	 *
	 * @param texture
	 * @param X
	 * @param Y
	 * @param Width
	 * @param Height
	 */
	public function new(?texture:Image = null, ?key:String = null, ?X:Int = 0, ?Y:Int = 0, ?Width:Int = 0, ?Height:Int = 0)
	{
		_image = texture;
		_name = key;
		_x = X;
		_y = Y;
		_width = (Width == 0 && texture  != null) ? texture.width : Width;
		_height = (Height == 0 && texture  != null) ? texture.height : Height;
	}

	/**
	 * Return the region X position.
	 */
	public function getRegionX():Int
	{
		return _x;
	}

	/**
	 * Return the region Y position.
	 */
	public function getRegionY():Int
	{
		return _y;
	}

	/**
	 * Return the region width.
	 */
	public function getRegionWidth():Int
	{
		return _width;
	}
	/**
	 * Return the region height.
	 */
	public function getRegionHeight():Int
	{
		return _height;
	}

	/**
	 * Return the region texture.
	 */
	public function getTexture():Image
	{
		return _image;
	}

	/**
	 * Update the region
	 */
	public function setRegion(X:Int, Y:Int, Width:Int, Height:Int):Void
	{
		_width = Width;
		_height = Height;
		_x = X;
		_y = Y;
	}
}