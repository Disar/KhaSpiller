package spiller.system.kha.graphics;

import kha.Image;

/**
 * Handly class representing a texture.
 */
class TextureRegion
{
	/**
	 * The region X position.
	 */
	private var _regionX:Int;
	/**
	 * The region Y position.
	 */
	private var _regionY:Int;
	/**
	 * The region width.
	 */
	private var _regionWidth:Int;
	/**
	 * The region height.
	 */
	private var _regionHeight:Int;
	/**
	 * The region texture.
	 */
	private var _texture:Image;

	/**
	 * Class constructor.
	 */
	public function new()
	{

	}

	/**
	 * Return the region X position.
	 */
	public function getRegionX():Int
	{
		return _regionX;
	}

	/**
	 * Return the region Y position.
	 */
	public function getRegionY():Int
	{
		return _regionY;
	}

	/**
	 * Return the region width.
	 */
	public function getRegionWidth():Int
	{
		return _regionWidth;
	}
	/**
	 * Return the region height.
	 */
	public function getRegionHeight():Int
	{
		return _regionHeight;
	}

	/**
	 * Return the region texture.
	 */
	public function getTexture():Image
	{
		return _texture;
	}
	
	public function setRegion(?texture:TextureRegion, X:Int, Y:Int, Width:Int, Height:Int):Void
	{

	}
}