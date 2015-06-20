package spiller.system.kha.graphics;

import kha.graphics2.Graphics;

/**
 * A class simulaitng a simple sprite.
 */
class Sprite extends TextureRegion
{
	/**
	 * The sprite X position.
	 */
	private var _x:Int;
	/**
	 * The sprite Y position.
	 */
	private var _y:Int;
	/**
	 * The sprite angle.
	 */
	private var _angle:Int;

	/**
	 * Class constructor.
	 */
	public function new()
	{
		super();
	}

	public function setSize(Width:Int, Height:Int):Void
	{

	}


	public function setRotation(Angle:Float):Void
	{

	}

	/**
	 * Draw this sprite into the screen.
	 */
	public function draw(g:Graphics):Void
	{
		if(_angle != 0) {
			g.pushTransformation();
			g.rotate(_angle, _regionWidth * 0.5, _regionWidth * 0.5);
		}
		
		g.drawSubImage(_texture, _x, _y, _regionX, _regionY, _regionWidth, _regionHeight);

		if(_angle != 0) {
			g.popTransformation();
		}
	}

	/**
	 * Flip the sprite.
	 * 
	 * @param x		Perform horizontal flip
	 * @param y		Perform vertical flip
	 */
	public function flip (x:Bool, y:Bool)
	{
	}
}