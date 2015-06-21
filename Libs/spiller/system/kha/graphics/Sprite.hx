package spiller.system.kha.graphics;

import kha.Canvas;
import kha.Color;
import kha.Framebuffer;
import kha.graphics2.Graphics;
import kha.Image;
import kha.Loader;
import kha.math.Vector2;
import kha.Rectangle;

import spiller.system.kha.graphics.atlas.AtlasRegion;
import spiller.system.kha.graphics.atlas.TextureAtlas;
import spiller.util.SpiColor;

/**
 * A class simulaitng a simple sprite.
 */
class Sprite
{
	/**
	 * X offset.
	 */
	public var x:Float;
	/**
	 * Y offset.
	 */
	public var y:Float;
	/**
	 * 
	 */
	private var point:Vector2;
	/**
	 * X scrollfactor, effects how much the camera offsets the drawn graphic.
	 * Can be used for parallax effect, eg. Set to 0 to follow the camera,
	 * 0.5 to move at half-speed of the camera, or 1 (default) to stay still.
	 */
	public var scrollX:Float;
	/**
	 * Y scrollfactor, effects how much the camera offsets the drawn graphic.
	 * Can be used for parallax effect, eg. Set to 0 to follow the camera,
	 * 0.5 to move at half-speed of the camera, or 1 (default) to stay still.
	 */
	public var scrollY:Float;

	// Source and buffer information.
	private var _source:Image;
	private var _sourceRect:Rectangle;
	private var _region:AtlasRegion;

	// Color and alpha information.
	private var _alpha:Float;
	private var _color:Int;
	//private var _colorTransform:ColorTransform;
	//private var _matrix:Matrix;
	private var _red:Float;
	private var _green:Float;
	private var _blue:Float;

	// Flipped image information.
	private var _class:String;
	private var _flippedX:Bool;
	private var _flippedY:Bool;
	//private var _flip:BitmapData;
	//private static var _flips:Map<String,BitmapData> = new Map<String,BitmapData>();

	private var _scale:Float;
	/**
	 * Rotation of the image, in degrees.
	 */
	public var angle:Float;
	/**
	 * Scale of the image, effects both x and y scale.
	 */
	public var scale(get, set):Float;
	private inline function get_scale():Float { return _scale; }
	private inline function set_scale(value:Float):Float { return _scale = value; }
	/**
	 * X scale of the image.
	 */
	public var scaleX:Float;
	/**
	 * Y scale of the image.
	 */
	public var scaleY:Float;
	/**
	 * X origin of the image, determines transformation point.
	 * Defaults to top-left corner.
	 */
	public var originX:Float;
	/**
	 * Y origin of the image, determines transformation point.
	 * Defaults to top-left corner.
	 */
	public var originY:Float;
	
	
	/**
	 * Constructor.
	 * @param	source		Source image.
	 * @param	clipRect	Optional rectangle defining area of the source image to draw.
	 * @param	name		Optional name, necessary to identify the bitmapData if you are using flipped
	 */
	public function new(source:Dynamic, clipRect:Rectangle = null, name:String = "")
	{
		init();

		_sourceRect = new Rectangle(0, 0, 0, 0);
		
		// check if the _source or _region were set in a higher class
		if (_source == null && _region == null)
		{
			_class = name;
			/*if (Std.is(source, TextureAtlas))
			{
				var t:TextureAtlas = cast(source, TextureAtlas);
				setAtlasRegion(t.getRegion(name));
			}*/
			if (Std.is(source, AtlasRegion)) {
				setAtlasRegion(source);
			} else
			if (Std.is(source, Image)) {
				setBitmapSource(source);
			} else
			if (Std.is(source, String)) {
				
				setBitmapSource(Loader.the.getImage(source));
			}

			if (_source == null && _region == null)
				throw "Invalid source image.";
		}
		
		if (_region == null && _sourceRect != null) {
			_region = new AtlasRegion(_source, 0, 0, _source.width, _source.height);
		}

		if (clipRect != null) {
			if (clipRect.width == 0) clipRect.width = _sourceRect.width;
			if (clipRect.height == 0) clipRect.height = _sourceRect.height;
			_sourceRect = clipRect;
		}
		
	}
	
	private inline function setAtlasRegion(region:AtlasRegion)
	{
		_region = region;
		_source = region.getTexture();
		_sourceRect = new Rectangle(0, 0, _region.getRegionWidth(), _region.getRegionHeight());
	}
	
	private inline function setBitmapSource(image:Image)
	{
		_sourceRect.width = image.width;
		_sourceRect.height = image.height;
		_source = image;
		
	}
	
	/** @private Initialize variables */
	private inline function init()
	{
		angle = 0;
		scale = scaleX = scaleY = 1;
		originX = originY = 0;
		point = new Vector2();

		_alpha = 1;
		_flippedX = false;
		_color = 0x00FFFFFF;
		_red = _green = _blue = 1;
		//_matrix = KP.matrix;
	}
	
	/**
	 * Renders the image.
	 */
	public function render(buffer:Graphics)
	{
		
		var sx = scale * scaleX,
			sy = scale * scaleY;
			
		// determine drawing location
		this.point.x = x - originX * sx;
		this.point.y = y - originY * sy;
		
		if (_flippedX) this.point.x += _sourceRect.width * sx;
		if (_flippedY) this.point.y += _sourceRect.height * sy;
		
		buffer.pushRotation(angle, 
		this.point.x +  (sx * (_flippedX ? -1 : 1)) * _region.getRegionWidth() * 0.5 , 
		this.point.y +  (sy * (_flippedY ? -1 : 1)) * _region.getRegionHeight() * 0.5);
		
		buffer.color = Color.fromValue(_color);
		buffer.pushOpacity(_alpha);
		
		buffer.drawScaledSubImage(
			_source,
			_region.getRegionX(),
			_region.getRegionY(),
			_region.getRegionWidth(),
			_region.getRegionHeight(),
			this.point.x,
			this.point.y,
			_region.getRegionWidth() * (sx * (_flippedX ? -1 : 1)),
			_region.getRegionHeight() * (sy * (_flippedY ? -1 : 1)));
		
		buffer.popTransformation();
		
		buffer.popOpacity();
		buffer.color = Color.White;
		
	}
	
	/**
	 * Change the opacity of the Image, a value from 0 to 1.
	 */
	public var alpha(get, set):Float;
	private function get_alpha():Float { return _alpha; }
	private function set_alpha(value:Float):Float
	{
		value = value < 0 ? 0 : (value > 1 ? 1 : value);
		if (_alpha == value) return value;
		_alpha = value;
		
		return _alpha;
	}
	
	/**
	 * The tinted color of the Image. Use 0xFFFFFF to draw the Image normally.
	 */
	public var color(get, set):Int;
	private function get_color():Int { return _color; }
	private function set_color(value:Int):Int
	{
		value &= 0xFFFFFF;
		if (_color == value) return value;
		_color = value;

		// save individual color channel values
		_red = SpiColor.getRed(_color) / 255;
		_green = SpiColor.getGreen(_color) / 255;
		_blue = SpiColor.getBlue(_color) / 255;
		
		return _color;
	}
	
	/**
	 * Centers the Image's originX/Y to its center.
	 */
	public function centerOrigin()
	{
		originX = Std.int(width / 2);
		originY = Std.int(height / 2);
	}
	
	/**
	 * Centers the Image's originX/Y to its center, and negates the offset by the same amount.
	 */
	public function centerOO()
	{
		x += originX;
		y += originY;
		centerOrigin();
		x -= originX;
		y -= originY;
	}
	
	/**
	 * Width of the image.
	 */
	public var width(get, never):Int;
	private function get_width():Int
	{
		return _region.getRegionWidth();
	}

	/**
	 * Height of the image.
	 */
	public var height(get, never):Int;
	private function get_height():Int
	{
		return _region.getRegionHeight();
	}
	
	/**
	 * The scaled width of the image.
	 */
	public var scaledWidth(get, set):Float;
	private function get_scaledWidth():Float
	{
		return width * scaleX * scale;
	}
	private function set_scaledWidth(w:Float):Float 
	{
		scaleX = w / scale / width;
		return scaleX;
	}

	/**
	 * The scaled height of the image.
	 */
	public var scaledHeight(get, set):Float;
	private function get_scaledHeight():Float
	{
		return height * scaleY * scale;
	}
	private function set_scaledHeight(h:Float):Float
	{
		scaleY = h / scale / height;
		return scaleY;
	}
	
	/**
	 * Clipping rectangle for the image.
	 */
	public var clipRect(get, null):Rectangle;
	private function get_clipRect():Rectangle
	{
		return _sourceRect;
	}
	
	
	/**
	 * If you want to draw the Image horizontally flipped. This is
	 * faster than setting scaleX to -1 if your image isn't transformed.
	 */
	public var flippedX(get, set):Bool;
	private function get_flippedX():Bool
	{
		return _flippedX;
	}
	private function set_flippedX(value:Bool):Bool
	{
		if (_flippedX == value)
			return value;

		_flippedX = value;
		return _flippedX;
	}
	
	/**
	 * If you want to draw the Image vertically flipped. This is
	 * faster than setting scaleY to -1 if your image isn't transformed.
	 */
	public var flippedY(get, set):Bool;
	private function get_flippedY():Bool
	{
		return _flippedY;
	}
	private function set_flippedY(value:Bool):Bool
	{
		if (_flippedY == value)
			return value;

		_flippedY = value;
		return _flippedY;
	}
	

	/**
	 * Return the region X position.
	 */
	public function getRegionX():Int
	{
		return _region.getRegionX();
	}

	/**
	 * Return the region Y position.
	 */
	public function getRegionY():Int
	{
		return _region.getRegionY();
	}

	/**
	 * Return the region width.
	 */
	public function getRegionWidth():Int
	{
		return _region.getRegionWidth();
	}
	/**
	 * Return the region height.
	 */
	public function getRegionHeight():Int
	{
		return _region.getRegionHeight();
	}

	/**
	 * Return the region texture.
	 */
	public function getTexture():Image
	{
		return _source;
	}

	/**
	 * Set the rotation angle.
	 */
	public function setRotation(Angle:Float):Void
	{
		angle = Angle;
	}

	/**
	 * Flip the sprite.
	 * 
	 * @param x		Perform horizontal flip
	 * @param y		Perform vertical flip
	 */
	public function flip (x:Bool, y:Bool)
	{
		flippedX = x;
		flippedY = y;
	}
	
	/**
	 * Update the region
	 */
	public function setRegion(?texture:Image = null, X:Int, Y:Int, Width:Int, Height:Int):Void
	{
		if(texture != null) {
			_source = texture;
			_region = new AtlasRegion(_source, X, Y, Width, Height);
		} else {
			_region.setRegion(X, Y, Width, Height);
		}
	}

	/**
	 * Update the region
	 */
	public function setSize(Width:Int, Height:Int):Void
	{
		_region.setRegion(_region.getRegionX(), _region.getRegionY(), Width, Height);
	}
}