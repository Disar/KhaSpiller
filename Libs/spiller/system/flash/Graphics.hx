package spiller.system.flash;

import spiller.SpiG;
import spiller.math.SpiPoint;
import spiller.util.SpiColor;
import kha.math.Matrix4;
import kha.math.Vector2;
import kha.Image;
import kha.Color;

using kha.graphics2.GraphicsExtension;

/**
 * This class just wraps the libgdx <code>ShapeRenderer</code>
 * to make it look more like the Flash graphics API.
 * If you need access to the actual <code>ShapeRenderer</code>,
 * use the <code>getShapeRenderer</code> method.
 * It has a Singleton structure.
 * 
 * v1.2 Added Singleton structure, and added not called end() errors prevention.
 * v1.1 New methods and code commented
 * v1.0 Initial version
 * 
 * @version 1.2 - 05/03/2013
 * @author ratalaika / Ratalaika Games
 * @author Thomas Weston
 */
class Graphics
{
	/**
	 * The shape renderer instance.
	 */
	private static var _shapeRenderer:kha.graphics2.Graphics;
	/**
	 * The graphics instance.
	 */
	private static var _graphics:Graphics;
	/**
	 * Indicates if we are drawing filled shapes or not.
	 */
	private var _filled:Bool;
	/**
	 * The drawing position.
	 */
	private var _drawingPosition:SpiPoint;
	/**
	 * The drawing line strngth.
	 */
	private var _lineStrength:Float;
	/**
	 * Indicates if we call end or not.
	 */
	private var _ended:Bool;

	/**
	 * Private constructor.
	 */
	private function new()
	{
		_drawingPosition = SpiPoint.get();
		_ended = false;
	}

	/**
	 * Initialize the graphics
	 */
	public static function initGraphics():Graphics
	{
		// Initialize the graphics
		if(_graphics == null) {
			_graphics = new Graphics();
			_shapeRenderer = Image.createRenderTarget(SpiG.width, SpiG.height).g2;
		}

		return _graphics;
	}

	/**
	 * Clears the graphics, and resets fill and line style settings.
	 */
	public function clear():Void
	{
		lineStyle();
	}

	/**
	 * Moves the current drawing position to (x, y).
	 * 
	 * @param x		The X position.
	 * @param y		The Y position.
	 */
	public function moveTo(x:Float, y:Float):Void
	{
		_drawingPosition.set(x, y);
	}

	/**
	 * Draws a line using the current line style from the current drawing position to (x, y);
	 * The current drawing position is then set to (x, y).
	 * 
	 * @param x			The X position of end.
	 * @param y			The Y position of end.
	 */
	public function lineTo(x:Float, y:Float):Void
	{
		if(_ended)
			begin();
		
		if(_filled)
			return;
		if(_shapeRenderer != null)
			_shapeRenderer.drawLine(_drawingPosition.x, _drawingPosition.y, x, y, _lineStrength);
		_drawingPosition.set(x, y);
	}

	/**
	 * Draws a rectangle.
	 * 
	 * @param x				The X position.
	 * @param y				The Y position.
	 * @param width			The width of the rectangle.
	 * @param height		The height of the rectangle.
	 */
	public function drawRect(x:Float, y:Float, width:Float, height:Float):Void
	{
		if(_ended)
			begin();
		
		if(_filled) {
			if(_shapeRenderer != null)
				_shapeRenderer.drawRect(x, y, width, height);
		} else {
			if(_shapeRenderer != null) {
				_shapeRenderer.drawLine(x, y, x + width, y, _lineStrength);
				_shapeRenderer.drawLine(x + width, y, x + width, y + height, _lineStrength);
				_shapeRenderer.drawLine(x + width, y + height, x, y + height, _lineStrength);
				_shapeRenderer.drawLine(x, y + height, x, y, _lineStrength);
			}
		}
	}
	
	/**
	 * Draws a circle.
	 * 
	 * @param x				The center X position.
	 * @param y				The center Y position.
	 * @param radius		The circle radius.
	 */
	public function drawCircle(x:Float, y:Float, radius:Float):Void
	{
		if(_shapeRenderer != null)
			_shapeRenderer.drawCircle(x, y, radius);
	}

	/**
	 * Specifies a line style used for subsequent calls to Graphics methods such as the lineTo() method or the drawCircle() method.
	 * 
	 * @param thickness		The line thickness.
	 * @param color			The line color.
	 * @param alpha			The line alpha value.
	 */
	public function lineStyle(thickness:Float = 0, color:SpiColor = SpiColor.BLACK, alpha:Float = 1)
	{
		_lineStrength = thickness;
		if(_shapeRenderer != null)
			_shapeRenderer.color = Color.fromValue(color);
	}

	/**
	 * Start the drawing.
	 * 
	 * @param filled		True if we want to draw filled figures.
	 */
	public function begin(filled:Bool = false):Void
	{
		_ended = false;
		
		_filled = filled;
	}

	/**
	 * Terminate the drawing.
	 */
	public function end():Void
	{
		if(_shapeRenderer != null)
			_shapeRenderer.end();
		_ended = true;
	}

	/**
	 * Draw a polygon.
	 * 
	 * @param poitns		The polygon points.
	 */
	public function polygon(vertices:Array<Float>):Void
	{
		if(_ended)
			begin();
		
		// Prevent null
		if(_shapeRenderer != null) {

			// Exit if needed
			if(vertices.length >= 6) {
				SpiG.log("You need a polygon with at least 3 points (x, y) so 6 values!");
				return;
			}

			// Create the new vertices
			var vectorArray:Array<Vector2> = new Array<Vector2>();
			var j:Int = 0;
			for(i in 0 ... vertices.length) {
				// Thank you Haxe for not letting me change i values inside a loop <.<
				if(i % 2 == 0)
					continue;
				vectorArray[j++] = new Vector2(vertices[i], vertices[i+1]);
			}

			// If we are drawing a filled stuff end
			if(_filled) {
				_shapeRenderer.fillPolygon(_drawingPosition.x, _drawingPosition.y, vectorArray);
			} else {
				_shapeRenderer.drawPolygon(_drawingPosition.x, _drawingPosition.y, vectorArray, _lineStrength);
			}
		}
	}

	/**
	 * Clean up memory.
	 */
	public function dispose():Void
	{
		_shapeRenderer = null;
		_drawingPosition = null;
		_graphics = null;
	}
}