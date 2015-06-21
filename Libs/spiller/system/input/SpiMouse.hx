package spiller.system.input;

import kha.Scaler;
import kha.ScreenCanvas;
import kha.ScreenRotation;
import kha.Sys;

import spiller.SpiCamera;
import spiller.SpiG;
import spiller.math.SpiPoint;
import spiller.SpiSprite;
import spiller.data.SpiSystemAsset;
import spiller.util.SpiDestroyUtil;

#if SPI_RECORD_REPLAY
import spiller.system.replay.SpiMouseRecord;
#end

/**
 * This class helps contain and track the pointers in your game.
 * Automatically accounts for parallax scrolling, etc.
 * For multi-touch devices the <code>x</code>, <code>y</code>, <code>screenX</code>, and <code>screenY</code>
 * properties refer to the first pointer.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 09/05/2014
 * @author ratalaika / Ratalaika Games
 * @author Ka Wing Chin
 */
class SpiMouse
{
	/**
	 * The X coordinate of the point.
	 */
	public var x:Float;
	/**
	 * The Y coordinate of the point.
	 */
	public var y:Float;
	/**
	 * Current "delta" value of mouse wheel.  If the wheel was just scrolled up, it will have a positive value.  If it was just scrolled down, it will have a negative value.  If it wasn't just scroll this frame, it will be 0.
	 */
	public var wheel:Int;
	/**
	 * Current X position of the pointer on the screen. For multi-touch devices this is the first pointer.
	 */
	public var screenX:Int;
	/**
	 * Current Y position of the pointer on the screen. For multi-touch devices this is the first pointer.
	 */
	public var screenY:Int;	
	/**
	 * Helper variables for recording purposes.
	 */
	private var _lastWheel:Int;
	/**
	 * Pre allocated point used to prevent to much initialization.
	 */
	private var _point:SpiPoint;
	/**
	 * An array of all the pointers in the game.
	 */
	private var _pointers:Array<Pointer>;
	/**
	 * The current active pointers.
	 */
	public var activePointers:Int;
	/**
	 * This is just a reference to the current cursor image, if there is one.
	 */
	private var _cursor:SpiSprite;

	/**
	 * Constructor
	 */
	public function new()
	{
		screenX = 0;
		screenY = 0;
		_lastWheel = wheel = 0;	
		_point = SpiPoint.get();
		_pointers = new Array<Pointer>();
		_pointers.push(new Pointer());
		activePointers = 0;
	}

	/**
	 * Clean up memory.
	 */
	public function destroy():Void
	{
		_point = null;
		_pointers.splice(0, _pointers.length);
		_pointers = null;
	}
	
	/**
	 * Either show an existing cursor or load a new one.
	 * 
	 * @param	Graphic		The image you want to use for the cursor.
	 * @param	Scale		Change the size of the cursor.  Default = 1, or native size.  2 = 2x as big, 0.5 = half size, etc.
	 * @param	XOffset		The number of pixels between the mouse's screen position and the graphic's top left corner.
	 * @param	YOffset		The number of pixels between the mouse's screen position and the graphic's top left corner. 
	 */
	public function show(Graphic:String = null, Scale:Float = 1, XOffset:Int = 0, YOffset:Int = 0):Void
	{
		if(Graphic != null)
			load(Graphic, Scale, XOffset, YOffset);
		else if(_cursor == null)
			load();
	}
	
	/**
	 * Hides the mouse cursor
	 */
	public function hide():Void
	{
		// Gdx.input.setCursorCatched(false);
		if(_cursor != null)
			_cursor.visible = false;
	}
	
	/**
	 * Read only, check visibility of mouse cursor.
	 */
	public function getVisible():Bool
	{
		if(_cursor == null)
			return true;
		else
			return _cursor.visible;
	}
	
	/**
	 * Load a new mouse cursor graphic
	 * 
	 * @param	Graphic		The image you want to use for the cursor.
	 * @param	Scale		Change the size of the cursor.
	 * @param	XOffset		The number of pixels between the mouse's screen position and the graphic's top left corner.
	 * @param	YOffset		The number of pixels between the mouse's screen position and the graphic's top left corner. 
	 */
	public function load(Graphic:String = null, Scale:Float = 1, XOffset:Int = 0, YOffset:Int = 0):Void
	{
		if(Graphic == null)
			Graphic = SpiSystemAsset.ImgDefault; //TODO: Default cursor
		_cursor = new SpiSprite();
		_cursor.loadGraphic(Graphic);
		_cursor.offset.x = XOffset;
		_cursor.offset.y = YOffset;
		_cursor.scale.x = _cursor.scale.x = Scale;

		// Hide system cursor
		// Gdx.input.setCursorCatched(true);
	}

	/**
	 * Unload the current cursor graphic.  If the current cursor is visible,
	 * then the default system cursor is loaded up to replace the old one.
	 */
	public function unload():Void
	{
		if(_cursor != null) {
			if(_cursor.visible)
				load();
			else {
				_cursor = null;
			}
		}
	}
	
	/**
	 * Called by the internal game loop to update the pointers positions in the game world.
	 * Also updates the just pressed/just released flags.
	 */
	public function update():Void
	{	
		var o:Pointer;
		var i:Int = 0;
		var l:Int = _pointers.length;
		
		while (i < l)
		{
			o = _pointers[i];

			if((o.last == -1) && (o.current == -1))
				o.current = 0;
			else if((o.last == 2) && (o.current == 2))
				o.current = 1;
			o.last = o.current;
			
			++i;
		}

		updateCursor();
	}
	
	/**
	 * Internal function for helping to update the cursor graphic and world coordinates.
	 */
	private function updateCursor():Void
	{
		var o:Pointer = _pointers[0];
		
		// Actually position the spiller mouse cursor graphic
		if(_cursor != null) {
			_cursor.x = o.screenPosition.x;
			_cursor.y = o.screenPosition.y;
		}
		
		// Update the x, y, screenX, and screenY variables based on the default camera.
		// This is basically a combination of getWorldPosition() and getScreenPosition()
		var camera:SpiCamera = SpiG.camera;

		//TODO Remove?
		if(camera == null)
			return;

		screenX = Std.int((o.screenPosition.x - camera.x)/(camera.getZoom() * camera._screenScaleFactorX));
		screenY = Std.int((o.screenPosition.y - camera.y)/(camera.getZoom() * camera._screenScaleFactorY));
		x = screenX + camera.scroll.x;
		y = screenY + camera.scroll.y;
	}
	
	/**
	 * Fetch the world position of the specified pointer on any given camera.
	 *
	 * @param Pointer	The pointer id.
	 * @param Camera	If unspecified, first/main global camera is used instead.
	 * @param Point		An existing point object to store the results (if you don't want a new one created). 
	 *
	 * @return The pointer's location in world space.
	 */
	public function getWorldPosition(?Pointer:Int, ?Camera:SpiCamera, ?Point:SpiPoint):SpiPoint
	{
		if(Camera == null)
			Camera = SpiG.camera;
		if(Point == null)
			Point = SpiPoint.get();
		getScreenPosition(Pointer, Camera, _point);
		Point.x = _point.x + Camera.scroll.x;
		Point.y = _point.y + Camera.scroll.y;
		
		return Point;
	}
	
	/**
	 * Fetch the screen position of the specified pointer on any given camera.
	 *
	 * @param Pointer	The pointer id.
	 * @param Camera	If unspecified, first/main global camera is used instead.
	 * @param Point		An existing point object to store the results (if you don't want a new one created). 
	 * 
	 * @return The pointer's location in screen space.
	 */
	public function getScreenPosition(?Pointer:Int, ?Camera:SpiCamera, ?Point:SpiPoint):SpiPoint
	{
		if(Camera == null)
			Camera = SpiG.camera;
		if(Point == null)
			Point = SpiPoint.get();
		
		if (Pointer >= _pointers.length)
			return Point;
		
		var o:Pointer = _pointers[Pointer];

		#if SPI_RECORD_REPLAY
		// Dirty fix for multiple scale records ;D
		if(SpiG.isReplaying()) {
			Point.x = x;
			Point.y = y;
		} else {
		#end
			Point.x = (o.screenPosition.x - Camera.x)/(Camera.getZoom() * Camera._screenScaleFactorX);
			Point.y = (o.screenPosition.y - Camera.y)/(Camera.getZoom() * Camera._screenScaleFactorY);
		#if SPI_RECORD_REPLAY
		}
		#end
		
		return Point;
	}

	/**
	 * Resets the just pressed/just released flags and sets mouse to not pressed.
	 */
	public function reset():Void
	{
		// Pool pointers points.
		for(i in 0 ... _pointers.length) {
			_pointers[i].screenPosition = SpiDestroyUtil.put(_pointers[i].screenPosition);
		}
		
		_pointers.splice(0, _pointers.length);
		_pointers.push(new Pointer());
	}
	
	/**
	 * Check to see if the mouse is pressed.
	 * 
	 * @param Pointer	The pointer id.
	 * 
	 * @return	Whether the screen is pressed.
	 */
	public function pressed(Pointer:Int = 0):Bool
	{
		if (Pointer >= _pointers.length)
			return false;
		return _pointers[Pointer].current > 0;
	}
	
	/**
	 * Check to see if the screen was just pressed.
	 * 
	 * @param	Pointer	The pointer id.
	 * 
	 * @return Whether the screen was just pressed.
	 */
	public function justPressed(Pointer:Int = 0):Bool
	{	
		if (Pointer >= _pointers.length)
			return false;
		return _pointers[Pointer].current == 2;
	}

	/**
	 * Check to see if the screen was just released.
	 * 
	 * @param	Pointer	The pointer id.
	 * 
	 * @return	Whether the screen was just released.
	 */
	public function justReleased(Pointer:Int = 0):Bool
	{
		if (Pointer >= _pointers.length)
			return false;
		return _pointers[Pointer].current == -1;
	}

	/**
	 * Event handler so SpiGame can update the pointer.
	 * 
	 * @param	X	The x position of the pointer.
	 * @param	Y	The y position of the pointer.
	 * @param	Pointer	The pointer id.
	 * @param	Button	Which mouse button was released.
	 */
	public function handleMouseUp(X:Int, Y:Int, Pointer:Int, Button:Int):Void
	{
		var o:Pointer;
		
		if (Pointer >= _pointers.length)
		{
			o = new Pointer();
			_pointers.push(o);
		}
		else
			o = _pointers[Pointer];
		
		if(o.current > 0)
			o.current = -1;
		else 
			o.current = 0;

		o.screenPosition.x = Scaler.transformX(X, Y, SpiG.getGame()._backBuffer, ScreenCanvas.the, Sys.screenRotation); 
		o.screenPosition.y = Scaler.transformY(X, Y, SpiG.getGame()._backBuffer, ScreenCanvas.the, Sys.screenRotation);
		
		activePointers--;
		
		SpiG.keys.handleKeyUp(Button);
	}
	
	/**
	 * Event handler so SpiGame can update the pointer.
	 * 
	 * @param	X	The x position of the pointer.
	 * @param	Y	The y position of the pointer.
	 * @param	Pointer	The pointer id.
	 * @param	Button	Which mouse button was pressed.
	 */
	public function handleMouseDown(X:Int, Y:Int, Pointer:Int, Button:Int):Void
	{
		var o:Pointer;
		
		if (Pointer >= _pointers.length)
		{
			o = new Pointer();
			_pointers.push(o);
		}
		else
			o = _pointers[Pointer];

		if(o.current > 0) 
			o.current = 1;
		else
			o.current = 2;

		o.screenPosition.x = Scaler.transformX(X, Y, SpiG.getGame()._backBuffer, ScreenCanvas.the, Sys.screenRotation); 
		o.screenPosition.y = Scaler.transformY(X, Y, SpiG.getGame()._backBuffer, ScreenCanvas.the, Sys.screenRotation);

		activePointers++;
		
		SpiG.keys.handleKeyDown(Button);
	}

	/**
	 * Event handler so SpiGame can update the pointer.
	 * 
	 * @param	X	The x position of the pointer.
	 * @param	Y	The y position of the pointer.
	 * @param	Pointer	The pointer id.
	 */
	public function handleMouseMove(X:Int, Y:Int, Pointer:Int):Void
	{
		var o:Pointer;
		
		if (Pointer >= _pointers.length) {
			o = new Pointer();
			_pointers.push(o);
		}
		else
			o = _pointers[Pointer];

		o.screenPosition.x = Scaler.transformX(X, Y, SpiG.getGame()._backBuffer, ScreenCanvas.the, Sys.screenRotation); 
		o.screenPosition.y = Scaler.transformY(X, Y, SpiG.getGame()._backBuffer, ScreenCanvas.the, Sys.screenRotation);
	}
	
	
	/**
	 * Event handler so SpiGame can update the pointer.
	 * 
	 * @param	Amount	The amount the wheel was scrolled.
	 */
	public function handleMouseWheel(Amount:Int):Void
	{
		wheel = Amount;
	}

	#if SPI_RECORD_REPLAY
	/**
	 * If the mouse changed state or is pressed, return that info now
	 *
	 * @return	An array of key state data.  Null if there is no data.
	 */
	//TODO: This should record all pointers, not just the first one.
	public function record():SpiMouseRecord
	{
		var o:Pointer = _pointers[0];
		
		if((o.lastX == o.screenPosition.x) && (o.lastY == o.screenPosition.y) && (o.current == 0) && (_lastWheel == wheel))
			return null;
		o.lastX = Std.int(o.screenPosition.x);
		o.lastY = Std.int(o.screenPosition.y);
		_lastWheel = wheel;
		return new SpiMouseRecord(Std.int(x), Std.int(y), o.current,_lastWheel);
	}
	
	/**
	 * Part of the keystroke recording system.
	 * Takes data about key presses and sets it into array.
	 * 
	 * @param	KeyStates	Array of data about key states.
	 */
	//TODO: This should play all pointers, not just the first one.
	public function playback(Record:SpiMouseRecord):Void
	{
		var o:Pointer = _pointers[0];
		
		o.current = Record.button;
		wheel = Record.wheel;
		x = Record.x;
		y = Record.y;

		//TODO: Fix? updateCursor();
	}
	#end

	/**
	 * Return the cursor.
	 */
	public function getCursor():SpiSprite
	{
		return _cursor;
	}
}

/**
 * An internal helper class to store the state of the pointers in game.
 */
class Pointer
{
	/**
	 * The current pressed state of the pointer.
	 */
	public var current:Int;
	/**
	 * The last pressed state of the pointer.
	 */
	public var last:Int;
	/**
	 * The current position of the pointer in screen space.
	 */
	public var screenPosition:SpiPoint;
	/**
	 * The last X position of the pointer in screen space.
	 */
	public var lastX:Int;
	/**
	 * The last Y position of the pointer in screen space.
	 */
	public var lastY:Int;
	
	public function new()
	{
		current = 0;
		last = 0;
		screenPosition = SpiPoint.get();
		lastX = 0;
		lastY = 0;
	}
}