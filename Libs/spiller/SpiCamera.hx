package spiller;

// import com.badlogic.gdx.Gdx;
// import com.badlogic.gdx.Application.ApplicationType;
// import com.badlogic.gdx.graphics.GL20;
// import com.badlogic.gdx.graphics.OrthographicCamera;
// import com.badlogic.gdx.graphics.glutils.ShapeRenderer;
// import com.badlogic.gdx.graphics.glutils.ShapeRenderer.ShapeType;

// import spiller.system.flash.SpiGameStage;
// import spiller.util.SpiDestroyUtil;

/**
 * The camera class is used to display the game's visuals in the Flash player.<br>
 * By default one camera is created automatically, that is the same size as the Flash player.<br>
 * You can add more cameras or even replace the main camera using utilities in <code>SpiG</code>.<br>
 * <br>
 * v1.0 Initial version
 * 
 * @version 1.0 - 17/07/2013
 * @author ratalaika / Ratalaika Games
 * @author Ka Wing Chin
 */
class SpiCamera extends SpiBasic
{
	/**
	 * Camera "follow" style preset: camera has no deadzone, just tracks the focus object directly.
	 */
	public static inline var STYLE_LOCKON:Int = 0;
	/**
	 * Camera "follow" style preset: camera deadzone is narrow but tall.
	 */
	public static inline var STYLE_PLATFORMER:Int = 1;
	/**
	 * Camera "follow" style preset: camera deadzone is a medium-size square around the focus object.
	 */
	public static inline var STYLE_TOPDOWN:Int = 2;
	/**
	 * Camera "follow" style preset: camera deadzone is a small square around the focus object.
	 */
	public static inline var STYLE_TOPDOWN_TIGHT:Int = 3;
	/**
	 * Camera "follow" style preset: camera will move screenwise.
	 */
	public static inline var STYLE_SCREEN_BY_SCREEN:Int = 4;
	/**
	 * Camera "follow" style preset: camera has no deadzone, just tracks the focus object directly and centers it.
	 */
	public static inline var STYLE_NO_DEAD_ZONE:Int = 5;
	/**
	 * Camera "shake" effect preset: shake camera on both the X and Y axes.
	 */
	public static inline var SHAKE_BOTH_AXES:Int = 0;
	/**
	 * Camera "shake" effect preset: shake camera on the X axis only.
	 */
	public static inline var SHAKE_HORIZONTAL_ONLY:Int = 1;
	/**
	 * Camera "shake" effect preset: shake camera on the Y axis only.
	 */
	public static inline var SHAKE_VERTICAL_ONLY:Int = 2;
	/**
	 * Camera "scale" mode preset: The game is not scaled.
	 */
	public static inline var NO_SCALE:Int = 0;
	/**
	 * Camera "scale" mode preset: Scales the stage to fill the display
	 * in the x direction without stretching. 
	 */
	public static inline var FILL_X:Int = 1;
	/**
	 * Camera "scale" mode preset: Scales the stage to fill the display
	 * in the y direction without stretching.
	 */
	public static inline var FILL_Y:Int = 2;
	/**
	 * Camera "scale" mode preset: Stretches the game to fill the entire screen.
	 */
	public static inline var STRETCH:Int = 3;
	// /**
	//  * The time between checks for stop following the object.<br>
	//  * Default 0.1sec.
	//  */
	// public static float stopFollowTimeCheck = 0.1f;
	// /**
	//  * The margin to stop following the object.<br>
	//  * Default 10px.
	//  */
	// public static float stopFollowMargin = 10;
	// /**
	//  * While you can alter the zoom of each camera after the fact,
	//  * this variable determines what value the camera will start at when created.
	//  */
	// public static float defaultZoom;
	// /**
	//  * While you can alter the scale mode of each camera after the fact,
	//  * this variable determines what value the camera will start at when created.
	//  */
	// public static int defaultScaleMode;
	// /**
	//  * The X position of this camera's display.  Zoom does NOT affect this number.
	//  * Measured in pixels from the left side of the flash window.
	//  */
	// public float x;
	// /**
	//  * The Y position of this camera's display.  Zoom does NOT affect this number.
	//  * Measured in pixels from the top of the flash window.
	//  */
	// public float y;
	// /**
	//  * How wide the camera display is, in game pixels.
	//  */
	// public int width;
	// /**
	//  * How tall the camera display is, in game pixels.
	//  */
	// public int height;
	// /**
	//  * Tells the camera to follow this <code>SpiObject</code> object around.
	//  */
	// public SpiObject target;
	// /**
	//  * Used to smoothly track the camera as it follows.
	//  */
	// public float followLerp = 0;
	// /**
	//  * You can assign a "dead zone" to the camera in order to better control its movement.
	//  * The camera will always keep the focus object inside the dead zone,
	//  * unless it is bumping up against the bounds rectangle's edges.
	//  * The deadzone's coordinates are measured from the camera's upper left corner in game pixels.
	//  * For rapid prototyping, you can use the preset deadzones (e.g. <code>STYLE_PLATFORMER</code>) with <code>follow()</code>.
	//  */
	// public SpiRect deadzone;
	// /**
	//  * The edges of the camera's range, i.e. where to stop scrolling.
	//  * Measured in game pixels and world coordinates.
	//  */
	// public SpiRect bounds;
	// /**
	//  * Stores the basic parallax scrolling values.
	//  */
	// public SpiPoint scroll;
	// /**
	//  * The actual libgdx camera.
	//  */
	// private OrthographicCamera glCamera;
	// /**
	//  * The natural background color of the camera. Defaults to SpiG.bgColor.
	//  * NOTE: can be transparent for crazy FX!
	//  */
	// public int bgColor;
	// /**
	//  * Indicates how far the camera is zoomed in.
	//  */
	// private float _zoom;
	// /**
	//  * Decides how spiller handles different screen sizes.
	//  */
	// private int _scaleMode;
	// public float _screenScaleFactorX;
	// public float _screenScaleFactorY;
	// public int viewportWidth;
	// public int viewportHeight;
	// /**
	//  * Internal, to help avoid costly allocations.
	//  */
	// private SpiPoint _point;
	// /**
	//  * Internal, help with color transforming the flash bitmap.
	//  */
	// private int _color;
	// /**
	//  * Internal, used to render buffer to screen space.
	//  */
	// float _flashOffsetX;
	// /**
	//  * Internal, used to render buffer to screen space.
	//  */
	// float _flashOffsetY;
	// /**
	//  * Internal, used to control the "flash" special effect.
	//  */
	// private int _fxFlashColor;
	// /**
	//  * Internal, used to control the "flash" special effect.
	//  */
	// private float _fxFlashDuration;
	// /**
	//  * Internal, used to control the "flash" special effect.
	//  */
	// private ISpiCamera _fxFlashComplete;
	// /**
	//  * Internal, used to control the "flash" special effect.
	//  */
	// private float _fxFlashAlpha;
	// /**
	//  * Internal, used to control the "fade" special effect.
	//  */
	// private int _fxFadeColor;
	// /**
	//  * Internal, used to control the "fade" special effect.
	//  */
	// private float _fxFadeDuration;
	// /**
	//  * Internal, used to control the "fade" special effect.
	//  */
	// private ISpiCamera _fxFadeComplete;
	// /**
	//  * Internal, used to control the "fade" special effect.
	//  */
	// private float _fxFadeAlpha;
	// /**
 //     * Internal, used to control the "fade" special effect.
 //     */
 //    private boolean _fxFadeIn;
	// /**
	//  * Internal, used to control the "shake" special effect.
	//  */
	// private float _fxShakeIntensity;
	// /**
	//  * Internal, used to control the "shake" special effect.
	//  */
	// private float _fxShakeDuration;
	// /**
	//  * Internal, used to control the "shake" special effect.
	//  */
	// private ISpiCamera _fxShakeComplete;
	// /**
	//  * Internal, used to control the "shake" special effect.
	//  */
	// private SpiPoint _fxShakeOffset;
	// /**
	//  * Internal, used to control the "shake" special effect.
	//  */
	// private int _fxShakeDirection;
	// /**
	//  * Internal helper to store the angle of the camera.
	//  */
	// private float _angle;
	// /**
	//  * Internal helper to store the alpha value of the camera.
	//  */
	// private float _alpha;
	// /**
	//  * Tells the camera to use this following style.
	//  */
	// private int _style;
	// /**
	//  * If we want to use the zoom offset for the bound calculation.
	//  */
	// private boolean _useZoomOffsetForBounds;
	// /**
	//  * Used to calculate the following target current velocity.
	//  */
	// private SpiPoint _lastTargetPosition;
	// /**
	//  * Helper to calculate follow target current scroll.
	//  */
	// private SpiPoint _scrollTarget;
	// /**
	//  * Used to force the camera to look ahead of the target.
	//  */
	// public SpiPoint followLead;
	// /**
	//  * If we stop the camera when reaching the object.
	//  */
	// private boolean _stopReach;
	// /**
	//  * The last scroll position.
	//  */
	// private SpiPoint _lastScroll;
	// /**
	//  * Counter for stop follow checks.
	//  */
	// private float _stopFollowCounter;
	// /**
	//  * The amount we need to move the camera to center on the screen.
	//  */
	// private SpiPoint _offsetFullscreen;

	// /**
	//  * Instantiates a new camera at the specified location, with the specified size and zoom level.
	//  * 
	//  * @param X			X location of the camera's display in pixels. Uses native, 1:1 resolution, ignores zoom.
	//  * @param Y			Y location of the camera's display in pixels. Uses native, 1:1 resolution, ignores zoom.
	//  * @param Width		The width of the camera display in pixels.
	//  * @param Height	The height of the camera display in pixels.
	//  * @param Zoom		The initial zoom level of the camera.  A zoom level of 2 will make all pixels display at 2x resolution.
	//  * @param ScaleMode	The initial scale mode of the camera.
	//  */
	// public SpiCamera(int X, int Y, int Width, int Height, float Zoom, int ScaleMode)
	// {
	// 	x = X;
	// 	y = Y;
	// 	width = Width;
	// 	height = Height;
	// 	target = null;
	// 	deadzone = null;
	// 	scroll = SpiPoint.get();
	// 	_point = SpiPoint.get();
	// 	bounds = null;
	// 	glCamera = new OrthographicCamera();						
	// 	bgColor = SpiG.getBgColor();
	// 	_color = 0xFFFFFF;
	// 	_alpha = 1.0f;
	// 	_useZoomOffsetForBounds = false;
	// 	_scrollTarget = SpiPoint.get();
	// 	followLead = SpiPoint.get();
	// 	_offsetFullscreen = SpiPoint.get();
		
	// 	setScaleMode(ScaleMode);
	// 	setZoom(Zoom); //sets the scale of flash sprite, which in turn loads flashoffset values
	// 	_flashOffsetX = glCamera.position.x - _offsetFullscreen.x;
	// 	_flashOffsetY = glCamera.position.y - _offsetFullscreen.y;

	// 	glCamera.position.x = _flashOffsetX - (x / getZoom());
	// 	glCamera.position.y = _flashOffsetY - (y / getZoom());

	// 	_fxFlashColor = 0;
	// 	_fxFlashDuration = 0.0f;
	// 	_fxFlashComplete = null;
	// 	_fxFlashAlpha = 0.0f;
		
	// 	_fxFadeColor = 0;
	// 	_fxFadeDuration = 0.0f;
	// 	_fxFadeComplete = null;
	// 	_fxFadeAlpha = 0.0f;
	// 	_fxFadeIn = false;
		
	// 	_fxShakeIntensity = 0.0f;
	// 	_fxShakeDuration = 0.0f;
	// 	_fxShakeComplete = null;
	// 	_fxShakeOffset = SpiPoint.get();
	// 	_fxShakeDirection = 0;

	// 	_style = -1;
	// 	_lastScroll = SpiPoint.get();
	// }

	// /**
	//  * Instantiates a new camera at the specified location, with the specified size and zoom level.
	//  * 
	//  * @param X			X location of the camera's display in pixels. Uses native, 1:1 resolution, ignores zoom.
	//  * @param Y			Y location of the camera's display in pixels. Uses native, 1:1 resolution, ignores zoom.
	//  * @param Width		The width of the camera display in pixels.
	//  * @param Height	The height of the camera display in pixels.
	//  * @param Zoom		The initial zoom level of the camera.  A zoom level of 2 will make all pixels display at 2x resolution.
	//  */
	// public SpiCamera(int X, int Y, int Width, int Height, float Zoom)
	// {
	// 	this(X, Y, Width, Height, Zoom, 0);
	// }
		
	// /**
	//  * Instantiates a new camera at the specified location, with the specified size and zoom level.
	//  * 
	//  * @param X			X location of the camera's display in pixels. Uses native, 1:1 resolution, ignores zoom.
	//  * @param Y			Y location of the camera's display in pixels. Uses native, 1:1 resolution, ignores zoom.
	//  * @param Width		The width of the camera display in pixels.
	//  * @param Height	The height of the camera display in pixels.
	//  */
	// public SpiCamera(int X, int Y, int Width, int Height)
	// {
	// 	this(X, Y, Width, Height, 0, 0);
	// }
	
	// /**
	//  * Clean up memory.
	//  */
	// override
	// public void destroy()
	// {
	// 	_point = SpiDestroyUtil.put(_point);
	// 	followLead = SpiDestroyUtil.put(followLead);
	// 	_offsetFullscreen = SpiDestroyUtil.put(_offsetFullscreen);
	// 	_lastScroll = SpiDestroyUtil.put(_lastScroll);
	// 	_scrollTarget = SpiDestroyUtil.put(_scrollTarget);

	// 	target = null;
	// 	scroll = SpiDestroyUtil.put(scroll);
	// 	deadzone = null;
	// 	bounds = null;
	// 	glCamera = null;
	// 	_fxFlashComplete = null;
	// 	_fxFadeComplete = null;
	// 	_fxShakeComplete = null;
	// 	_fxShakeOffset = SpiDestroyUtil.put(_fxShakeOffset);
	// 	super.destroy();
	// }
	
	// /**
	//  * Updates the camera scroll as well as special effects like screen-shake or fades.
	//  */
	// override
	// public void update()
	// {
	// 	// Follow the target, if there is one
	// 	if (target != null)
	// 		updateFollow();
		
	// 	// Make sure we didn't go outside the camera's bounds
	// 	if(bounds != null)
	// 		updateBounds();
		
	// 	// Update all effects
	// 	updateFlash();
	// 	updateFade();
	// 	updateShake();

	// 	// Update gl camera
	// 	glCamera.update(false);
	// }
	
	// /**
	//  * Update the bounds.
	//  */
	// private void updateBounds()
	// {
	// 	float zoomOffsetWidth = 0;
	// 	float zoomOffsetHeight = 0;
		
	// 	if (getZoom() > 1 && _useZoomOffsetForBounds) {
	// 		zoomOffsetWidth = width * (getZoom() - 1) / (2 * getZoom());
	// 		zoomOffsetHeight = height * (getZoom() - 1) / (2 * getZoom());
	// 	}
		
	// 	if(scroll.x < bounds.getLeft() - zoomOffsetWidth)
	// 		scroll.x = bounds.getLeft() - zoomOffsetWidth;
	// 	if(scroll.x > bounds.getRight() - width + zoomOffsetWidth)
	// 		scroll.x = bounds.getRight() - width + zoomOffsetWidth;
	// 	if(scroll.y < bounds.getTop() - zoomOffsetHeight)
	// 		scroll.y = bounds.getTop() - zoomOffsetHeight;
	// 	if(scroll.y > bounds.getBottom() - height + zoomOffsetHeight)
	// 		scroll.y = bounds.getBottom() - height + zoomOffsetHeight;
	// }
	
	// /**
	//  * Update the "flash" special effect
	//  */
	// private void updateFlash()
	// {
	// 	if(_fxFlashAlpha > 0.0f)
	// 	{
	// 		_fxFlashAlpha -= SpiG.elapsed/_fxFlashDuration;
	// 		if((_fxFlashAlpha <= 0) && (_fxFlashComplete != null))
	// 			_fxFlashComplete.callback();
	// 	}
	// }
		
	// /**
	//  * Update the "fade" special effect
	//  */
	// private void updateFade()
	// {
	// 	if((_fxFadeAlpha > 0.0f) && (_fxFadeAlpha < 1.0f))
	// 	{
	// 		if (_fxFadeIn)
	// 		{
	// 			_fxFadeAlpha -= SpiG.elapsed /_fxFadeDuration;
	// 			if(_fxFadeAlpha <= 0.0)
	// 			{
	// 				_fxFadeAlpha = 0.0f;
	// 				if(_fxFadeComplete != null)
	// 					_fxFadeComplete.callback();
	// 			}
	// 		} else {
	// 			_fxFadeAlpha += SpiG.elapsed / _fxFadeDuration;
	// 			if(_fxFadeAlpha >= 1.0)
	// 			{
	// 				_fxFadeAlpha = 1.0f;
	// 				if (_fxFadeComplete != null)
	// 					_fxFadeComplete.callback();
	// 			}
	// 		}
	// 	}
	// }

	// /**
	//  * Update the "shake" special effect
	//  */
	// private void updateShake() {
	// 	if(_fxShakeDuration > 0)
	// 	{
	// 		_fxShakeDuration -= SpiG.elapsed;
	// 		if(_fxShakeDuration <= 0)
	// 		{
	// 			_fxShakeOffset.make();
	// 			if(_fxShakeComplete != null)
	// 				_fxShakeComplete.callback();
	// 		}
	// 		else
	// 		{
	// 			if((_fxShakeDirection == SHAKE_BOTH_AXES) || (_fxShakeDirection == SHAKE_HORIZONTAL_ONLY))
	// 				_fxShakeOffset.x = (float) ((SpiG.random()* (_fxShakeIntensity*width)*2-(_fxShakeIntensity*width))*_zoom);
	// 			if((_fxShakeDirection == SHAKE_BOTH_AXES) || (_fxShakeDirection == SHAKE_VERTICAL_ONLY))
	// 				_fxShakeOffset.y = (float) ((SpiG.random()*_fxShakeIntensity*height*2-_fxShakeIntensity*height)*_zoom);
	// 		}
	// 	}
	// }

	// /**
	//  * Following behaviour.<br>
	//  * Either follow the object closely, or doublecheck our deadzone and update accordingly.
	//  */
	// private void updateFollow()
	// {
	// 	if(deadzone == null)
	// 		focusOn(target.getMidpoint(_point));
	// 	else
	// 	{
	// 		float edge;
	// 		float targetX = target.x;//SpiU.floor(target.x + ((target.x > 0)?0.0000001f:-0.0000001f));
	// 		float targetY = target.y;//SpiU.floor(target.y + ((target.y > 0)?0.0000001f:-0.0000001f));
			
	// 		if (_style == STYLE_SCREEN_BY_SCREEN)  {
	// 			if (targetX > _scrollTarget.x + width)
	// 				_scrollTarget.x += width;
	// 			else if (targetX < _scrollTarget.x)
	// 				_scrollTarget.x -= width;

	// 			if (targetY > _scrollTarget.y + height)
	// 				_scrollTarget.y += height;
	// 			else if (targetY < _scrollTarget.y)
	// 				_scrollTarget.y -= height;
	// 		} else {
	// 			edge = targetX - deadzone.x;
	// 			if(_scrollTarget.x > edge)
	// 				_scrollTarget.x = edge;
	// 			edge = targetX + target.width - deadzone.x - deadzone.width;
	// 			if(_scrollTarget.x < edge)
	// 				_scrollTarget.x = edge;
				
	// 			edge = targetY - deadzone.y;
	// 			if(_scrollTarget.y > edge)
	// 				_scrollTarget.y = edge;
	// 			edge = targetY + target.height - deadzone.y - deadzone.height;
	// 			if(_scrollTarget.y < edge)
	// 				_scrollTarget.y = edge;
	// 		}

	// 		// Check if we need to look ahead of the target.
	// 		if (target instanceof SpiSprite) {
	// 			if (_lastTargetPosition == null) {
	// 				_lastTargetPosition = SpiPoint.get(target.x, target.y); // Creates this point.
	// 			}

	// 			_scrollTarget.x += (target.x - _lastTargetPosition.x ) * followLead.x;
	// 			_scrollTarget.y += (target.y - _lastTargetPosition.y ) * followLead.y;


	// 			_lastTargetPosition.x = target.x;
	// 			_lastTargetPosition.y = target.y;
	// 		}

	// 		// Apply lerp
	// 		if (followLerp == 0) {
	// 			scroll.copyFrom(_scrollTarget); // Prevents Camera Jittering with no lerp.
	// 		}
	// 		else {
	// 			scroll.x += (_scrollTarget.x - scroll.x) * SpiG.elapsed / (SpiG.elapsed + followLerp * SpiG.elapsed);
	// 			scroll.y += (_scrollTarget.y - scroll.y) * SpiG.elapsed / (SpiG.elapsed + followLerp * SpiG.elapsed);
	// 		}
			
	// 		// Apply stop when reach
	// 		if(_stopReach) {
	// 			_stopFollowCounter += SpiG.elapsed;
				
	// 			// Avoid checking too fast
	// 			if(_stopFollowCounter > stopFollowTimeCheck) {
	// 				_stopFollowCounter = 0; // Clear the counter

	// 				// Check if we need to stop
	// 				if(SpiU.abs(_lastScroll.x - scroll.x) < stopFollowMargin && SpiU.abs(_lastScroll.y - scroll.y) < stopFollowMargin) {
	// 					stopFollow();
	// 					_stopReach = false;
	// 				} else
	// 					_lastScroll.set(scroll);
	// 			}
	// 		}
	// 	}
	// }

	// /**
	//  * Tells this camera object what <code>SpiObject</code> to track.
	//  * 
	//  * @param	Target		The object you want the camera to track.  Set to null to not follow anything.
	//  * @param	Style		Leverage one of the existing "deadzone" presets.  If you use a custom deadzone, ignore this parameter and manually specify the deadzone after calling <code>follow()</code>.
	//  * @param	Offset		Offset the follow deadzone by a certain amount. Only applicable for STYLE_PLATFORMER and STYLE_LOCKON styles.
	//  * @param	Lerp		How much lag the camera should have (can help smooth out the camera movement).
	//  * @param	stopReach	Stop the camera when reaching the object.
	//  */
	// public void follow(SpiObject Target, int Style, SpiPoint Offset, float Lerp, boolean stopReach)
	// {
	// 	_style = Style;
	// 	target = Target;
	// 	followLerp = Lerp;
	// 	_stopReach = stopReach;
	// 	float helper;
	// 	float w = 0;
	// 	float h = 0;
	// 	switch(Style)
	// 	{
	// 		case STYLE_PLATFORMER:
	// 			w = (width/8f) + (Offset != null ? Offset.x : 0);
	// 			h = (height/3f) + (Offset != null ? Offset.y : 0);
	// 			deadzone = new SpiRect((width-w)/2f,(height-h)/2f - h*0.25f,w,h);
	// 			break;
	// 		case STYLE_TOPDOWN:
	// 			helper = SpiU.max(width,height)/4;
	// 			deadzone = new SpiRect((width-helper)/2f,(height-helper)/2f,helper,helper);
	// 			break;
	// 		case STYLE_TOPDOWN_TIGHT:
	// 			helper = SpiU.max(width,height)/8;
	// 			deadzone = new SpiRect((width-helper)/2f,(height-helper)/2f,helper,helper);
	// 			break;
	// 		case STYLE_LOCKON:
	// 			if (target != null)  {
	// 				w = target.width + (Offset != null ? Offset.x : 0);
	// 				h = target.height + (Offset != null ? Offset.y : 0);
	// 			}
	// 			deadzone = new SpiRect((width - w) / 2, (height - h) / 2 - h * 0.25f, w, h);
	// 			break;
	// 		case STYLE_SCREEN_BY_SCREEN:
	// 			deadzone = new SpiRect(0, 0, width, height);
	// 		default:
	// 			deadzone = null;
	// 			break;
	// 	}
		
	// 	if (Offset != null) {
	// 		Offset.putWeak();
	// 	}
	// }
	
	// /**
	//  * Tells this camera object what <code>SpiObject</code> to track.
	//  * 
	//  * @param	Target		The object you want the camera to track.  Set to null to not follow anything.
	//  * @param	Style		Leverage one of the existing "deadzone" presets.  If you use a custom deadzone, ignore this parameter and manually specify the deadzone after calling <code>follow()</code>.
	//  * @param	Offset		Offset the follow deadzone by a certain amount. Only applicable for STYLE_PLATFORMER and STYLE_LOCKON styles.
	//  * @param	Lerp		How much lag the camera should have (can help smooth out the camera movement).
	//  * @param	stopReach	Stop the camera when reaching the object.
	//  */
	// public void follow(SpiObject Target, int Style, SpiPoint Offset, float Lerp)
	// {
	// 	follow(Target, Style, Offset, Lerp, false);
	// }
	
	// /**
	//  * Tells this camera object what <code>SpiObject</code> to track.
	//  * 
	//  * @param	Target		The object you want the camera to track.  Set to null to not follow anything.
	//  * @param	Style		Leverage one of the existing "deadzone" presets.  If you use a custom deadzone, ignore this parameter and manually specify the deadzone after calling <code>follow()</code>.
	//  * @param	Offset		Offset the follow deadzone by a certain amount. Only applicable for STYLE_PLATFORMER and STYLE_LOCKON styles.
	//  */
	// public void follow(SpiObject Target, int Style, SpiPoint Offset)
	// {
	// 	follow(Target, Style, Offset, 0, false);
	// }

	// /**
	//  * Tells this camera object what <code>SpiObject</code> to track.
	//  * 
	//  * @param	Target		The object you want the camera to track.  Set to null to not follow anything.
	//  * @param	Style		Leverage one of the existing "deadzone" presets.  If you use a custom deadzone, ignore this parameter and manually specify the deadzone after calling <code>follow()</code>.
	//  */
	// public void follow(SpiObject Target, int Style)
	// {
	// 	follow(Target, Style, null, 0, false);
	// }

	// /**
	//  * Tells this camera object what <code>SpiObject</code> to track.
	//  * 
	//  * @param	Target		The object you want the camera to track.  Set to null to not follow anything.
	//  */
	// public void follow(SpiObject Target)
	// {
	// 	follow(Target, STYLE_LOCKON, null, 0, false);
	// }
	
	// /**
	//  * Stop following an object.
	//  */
	// public void stopFollow()
	// {
	// 	target = null;
	// }
	
	// /**
	//  * Move the camera focus to this location instantly.
	//  * 
	//  * @param	Point		Where you want the camera to focus.
	//  */
	// public void focusOn(SpiPoint Point)
	// {
	// 	Point.x += (Point.x > 0)?0.0000001f:-0.0000001f;
	// 	Point.y += (Point.y > 0)?0.0000001f:-0.0000001f;
	// 	scroll.make(Point.x - width*0.5f, Point.y - height*0.5f);
	// }
	
	// /**
	//  * Specify the boundaries of the level or where the camera is allowed to move.
	//  * 
	//  * @param	X				The smallest X value of your level (usually 0).
	//  * @param	Y				The smallest Y value of your level (usually 0).
	//  * @param	Width			The largest X value of your level (usually the level width).
	//  * @param	Height			The largest Y value of your level (usually the level height).
	//  * @param	UpdateWorld		Whether the global quad-tree's dimensions should be updated to match (default: false).
	//  */
	// public void setBounds(float X, float Y, float Width, float Height, boolean UpdateWorld)
	// {
	// 	if(bounds == null)
	// 		bounds = new SpiRect();
	// 	bounds.make(X,Y,Width,Height);
	// 	if(UpdateWorld)
	// 		SpiG.worldBounds.copyFrom(bounds);
	// 	update();
	// }
	
	// /**
	//  * Specify the boundaries of the level or where the camera is allowed to move.
	//  * 
	//  * @param	X				The smallest X value of your level (usually 0).
	//  * @param	Y				The smallest Y value of your level (usually 0).
	//  * @param	Width			The largest X value of your level (usually the level width).
	//  * @param	Height			The largest Y value of your level (usually the level height).
	//  */
	// public void setBounds(float X, float Y, float Width, float Height)
	// {
	// 	setBounds(X, Y, Width, Height, false);
	// }
	
	// /**
	//  * Specify the boundaries of the level or where the camera is allowed to move.
	//  * 
	//  * @param	X				The smallest X value of your level (usually 0).
	//  * @param	Y				The smallest Y value of your level (usually 0).
	//  * @param	Width			The largest X value of your level (usually the level width).
	//  */
	// public void setBounds(float X, float Y, float Width)
	// {
	// 	setBounds(X, Y, Width, 0, false);
	// }
	
	// /**
	//  * Specify the boundaries of the level or where the camera is allowed to move.
	//  * 
	//  * @param	X				The smallest X value of your level (usually 0).
	//  * @param	Y				The smallest Y value of your level (usually 0).
	//  */
	// public void setBounds(float X, float Y)
	// {
	// 	setBounds(X, Y, 0, 0, false);
	// }
	
	// /**
	//  * Specify the boundaries of the level or where the camera is allowed to move.
	//  * 
	//  * @param	X				The smallest X value of your level (usually 0).
	//  */
	// public void setBounds(float X)
	// {
	// 	setBounds(X, 0, 0, 0, false);
	// }
	
	// /**
	//  * Specify the boundaries of the level or where the camera is allowed to move.
	//  */
	// public void setBounds()
	// {
	// 	setBounds(0, 0, 0, 0, false);
	// }
	
	// /**
	//  * The screen is filled with this color and gradually returns to normal.
	//  * 
	//  * @param	Color		The color you want to use.
	//  * @param	Duration	How long it takes for the flash to fade.
	//  * @param	OnComplete	A function you want to run when the flash finishes.
	//  * @param	Force		Force the effect to reset.
	//  */
	// public void flash(int Color, float Duration, ISpiCamera OnComplete, boolean Force)
	// {
	// 	if(!Force && (_fxFlashAlpha > 0.0f))
	// 		return;
	// 	_fxFlashColor = Color;
	// 	if(Duration <= 0)
	// 		Duration = Float.MIN_VALUE;
	// 	_fxFlashDuration = Duration;
	// 	_fxFlashComplete = OnComplete;
	// 	_fxFlashAlpha = 1.0f;
	// }
	
	// /**
	//  * The screen is filled with this color and gradually returns to normal.
	//  * 
	//  * @param	Color		The color you want to use.
	//  * @param	Duration	How long it takes for the flash to fade.
	//  * @param	OnComplete	A function you want to run when the flash finishes.
	//  */
	// public void flash(int Color, float Duration, ISpiCamera OnComplete)
	// {
	// 	flash(Color, Duration, OnComplete, false);
	// }
	
	// /**
	//  * The screen is filled with this color and gradually returns to normal.
	//  * 
	//  * @param	Color		The color you want to use.
	//  * @param	Duration	How long it takes for the flash to fade.
	//  */
	// public void flash(int Color, float Duration)
	// {
	// 	flash(Color, Duration, null, false);
	// }
	
	// /**
	//  * The screen is filled with this color and gradually returns to normal.
	//  * 
	//  * @param	Color		The color you want to use.
	//  */
	// public void flash(int Color)
	// {
	// 	flash(Color, 1, null, false);
	// }
	
	// /**
	//  * The screen is filled with this color and gradually returns to normal.
	//  */
	// public void flash()
	// {
	// 	flash(0xFFFFFFFF, 1, null, false);
	// }

	// /**
	//  * The screen is gradually filled with this color.
	//  * 
	//  * @param	Color		The color you want to use.
	//  * @param	Duration	How long it takes for the fade to finish.
	//  * @param   FadeIn      True fades from a color, false fades to it.
	//  * @param	OnComplete	A function you want to run when the fade finishes.
	//  * @param	Force		Force the effect to reset.
	//  */
	// public void fade(int Color, float Duration, boolean FadeIn, ISpiCamera OnComplete, boolean Force)
	// {
	// 	if(!Force && (_fxFadeAlpha > 0.0f))
	// 		return;
	// 	_fxFadeColor = Color;
	// 	if(Duration <= 0)
	// 		Duration = Float.MIN_VALUE;

	// 	_fxFadeIn = FadeIn;
	// 	_fxFadeDuration = Duration;
	// 	_fxFadeComplete = OnComplete;
	// 	if(_fxFadeIn)
	// 		_fxFadeAlpha = 0.999999f;
	// 	else
	// 		_fxFadeAlpha = Float.MIN_VALUE;
	// }
	
	// /**
	//  * The screen is gradually filled with this color.
	//  * 
	//  * @param	Color		The color you want to use.
	//  * @param	Duration	How long it takes for the fade to finish.
	//  * @param	OnComplete	A function you want to run when the fade finishes.
	//  */
	// public void fade(int Color, float Duration, boolean FadeIn, ISpiCamera OnComplete)
	// {
	// 	fade(Color, Duration, FadeIn, OnComplete, false);
	// }

	// /**
	//  * The screen is gradually filled with this color.
	//  * 
	//  * @param	Color		The color you want to use.
	//  * @param	Duration	How long it takes for the fade to finish.
	//  * @param   FadeIn      True fades from a color, false fades to it.
	//  */
	// public void fade(int Color, float Duration, boolean FadeIn)
	// {
	// 	fade(Color, Duration, FadeIn, null, false);
	// }

	// /**
	//  * The screen is gradually filled with this color.
	//  * 
	//  * @param	Color		The color you want to use.
	//  * @param	Duration	How long it takes for the fade to finish.
	//  * @param	OnComplete	A function you want to run when the fade finishes.
	//  */
	// public void fade(int Color, float Duration, ISpiCamera OnComplete)
	// {
	// 	fade(Color, Duration, false, OnComplete, false);
	// }

	// /**
	//  * The screen is gradually filled with this color.
	//  * 
	//  * @param	Color		The color you want to use.
	//  * @param	Duration	How long it takes for the fade to finish.
	//  */
	// public void fade(int Color, float Duration)
	// {
	// 	fade(Color, Duration, false, null, false);
	// }
	
	// /**
	//  * The screen is gradually filled with this color.
	//  * 
	//  * @param	Color		The color you want to use.
	//  */
	// public void fade(int Color)
	// {
	// 	fade(Color, 1, false, null, false);
	// }
	
	// /**
	//  * The screen is gradually filled with this color.
	//  */
	// public void fade()
	// {
	// 	fade(0xFF000000, 1, false, null, false);
	// }
		
	// /**
	//  * A simple screen-shake effect.
	//  * 
	//  * @param	Intensity	Percentage of screen size representing the maximum distance that the screen can move while shaking.
	//  * @param	Duration	The length in seconds that the shaking effect should last.
	//  * @param	OnComplete	A function you want to run when the shake effect finishes.
	//  * @param	Force		Force the effect to reset (default = true, unlike flash() and fade()!).
	//  * @param	Direction	Whether to shake on both axes, just up and down, or just side to side (use class constants SHAKE_BOTH_AXES, SHAKE_VERTICAL_ONLY, or SHAKE_HORIZONTAL_ONLY).
	//  */
	// public void shake(float Intensity, float Duration, ISpiCamera OnComplete, boolean Force, int Direction)
	// {
	// 	if(!Force && ((_fxShakeOffset.x != 0) || (_fxShakeOffset.y != 0)))
	// 		return;
	// 	_fxShakeIntensity = Intensity;
	// 	_fxShakeDuration = Duration;
	// 	_fxShakeComplete = OnComplete;
	// 	_fxShakeDirection = Direction;
	// 	_fxShakeOffset.make();
	// }
	
	// /**
	//  * A simple screen-shake effect.
	//  * 
	//  * @param	Intensity	Percentage of screen size representing the maximum distance that the screen can move while shaking.
	//  * @param	Duration	The length in seconds that the shaking effect should last.
	//  * @param	OnComplete	A function you want to run when the shake effect finishes.
	//  * @param	Force		Force the effect to reset (default = true, unlike flash() and fade()!).
	//  */
	// public void shake(float Intensity, float Duration, ISpiCamera OnComplete, boolean Force)
	// {
	// 	shake(Intensity, Duration, OnComplete, Force, SHAKE_BOTH_AXES);
	// }
	
	// /**
	//  * A simple screen-shake effect.
	//  * 
	//  * @param	Intensity	Percentage of screen size representing the maximum distance that the screen can move while shaking.
	//  * @param	Duration	The length in seconds that the shaking effect should last.
	//  * @param	OnComplete	A function you want to run when the shake effect finishes.
	//  */
	// public void shake(float Intensity, float Duration, ISpiCamera OnComplete)
	// {
	// 	shake(Intensity, Duration, OnComplete, true, SHAKE_BOTH_AXES);
	// }
	
	// /**
	//  * A simple screen-shake effect.
	//  * 
	//  * @param	Intensity	Percentage of screen size representing the maximum distance that the screen can move while shaking.
	//  * @param	Duration	The length in seconds that the shaking effect should last.
	//  */
	// public void shake(float Intensity, float Duration)
	// {
	// 	shake(Intensity, Duration, null, true, SHAKE_BOTH_AXES);
	// }
	
	// /**
	//  * A simple screen-shake effect.
	//  * 
	//  * @param	Intensity	Percentage of screen size representing the maximum distance that the screen can move while shaking.
	//  */
	// public void shake(float Intensity)
	// {
	// 	shake(Intensity, 0.5f, null, true, SHAKE_BOTH_AXES);
	// }
	
	// /**
	//  * A simple screen-shake effect.
	//  * 
	//  * @param	Intensity	Percentage of screen size representing the maximum distance that the screen can move while shaking.
	//  */
	// public void shake()
	// {
	// 	shake(0.05f, 0.5f, null, true, SHAKE_BOTH_AXES);
	// }
	
	// /**
	//  * Just turns off all the camera effects instantly.
	//  */
	// public void stopFX()
	// {
	// 	_fxFlashAlpha = 0.0f;
	// 	_fxFadeAlpha = 0.0f;
	// 	_fxShakeDuration = 0;
	// 	glCamera.position.x = _flashOffsetX - (x / getZoom());
	// 	glCamera.position.y = _flashOffsetY - (y / getZoom());
	// }
	
	// /**
	//  * Copy the bounds, focus object, and deadzone info from an existing camera.
	//  * 
	//  * @param	Camera	The camera you want to copy from.
	//  * 
	//  * @return	A reference to this <code>SpiCamera</code> object.
	//  */
	// public SpiCamera copyFrom(SpiCamera Camera)
	// {
	// 	if(Camera.bounds == null)
	// 		bounds = null;
	// 	else
	// 	{
	// 		if(bounds == null)
	// 			bounds = new SpiRect();
	// 		bounds.copyFrom(Camera.bounds);
	// 	}
	// 	target = Camera.target;
	// 	if(target != null)
	// 	{
	// 		if(Camera.deadzone == null)
	// 			deadzone = null;
	// 		else
	// 		{
	// 			if(deadzone == null)
	// 				deadzone = new SpiRect();
	// 			deadzone.copyFrom(Camera.deadzone);
	// 		}
	// 	}
	// 	return this;
	// }
	
	// /**
	//  * The zoom level of this camera. 1 = 1:1, 2 = 2x zoom, etc.
	//  */
	// public float getZoom()
	// {
	// 	return _zoom;
	// }
	
	// /**
	//  * @private
	//  */
	// public void setZoom(float Zoom)
	// {
	// 	if(Zoom == 0)
	// 		_zoom = defaultZoom;
	// 	else
	// 		_zoom = Zoom;
	// 	setScale(_zoom, _zoom);
	// }
	
	// /**
	//  * The scale mode of this camera.
	//  */
	// public int getScaleMode()
	// {
	// 	return _scaleMode;
	// }
	
	// /**
	//  * @private
	//  */
	// public void setScaleMode(int ScaleMode)
	// {
	// 	if(ScaleMode == 0)
	// 		_scaleMode = defaultScaleMode;
	// 	else
	// 		_scaleMode = ScaleMode;
	// 	setScale(_zoom, _zoom);
	// }
	
	// /**
	//  * The alpha value of this camera display (a Number between 0.0 and 1.0).
	//  */
	// public float getAlpha()
	// {
	// 	return _alpha;
	// }
	
	// /**
	//  * @private
	//  */ 
	// public void setAlpha(float Alpha)
	// {		
	// 	_alpha = Alpha;
	// }
	
	// /**
	//  * The angle of the camera display (in degrees).
	//  * Currently yields weird display results,
	//  * since cameras aren't nested in an extra display object yet.
	//  */
	// public float getAngle()
	// {
	// 	return _angle;
	// }

	// /**
	//  * @private
	//  */
	// public void setAngle(float Angle)
	// {
	// 	_angle = Angle;
	// 	glCamera.rotate(Angle, 0, 0, 1);
	// }
	
	// /**
	//  * The color tint of the camera display. 
	//  */
	// public int getColor()
	// {
	// 	return _color;
	// }
	
	// /**
	//  * @private
	//  */
	// public void setColor(int Color)
	// {
	// 	_color = Color;
	// }
	
	// /**
	//  * Whether the camera display is smooth and filtered, or chunky and pixelated.
	//  * Default behavior is chunky-style.
	//  */
	// public boolean getAntialiasing()
	// {
	// 	return true;
	// }

	// /**
	//  * @private
	//  */
	// public void setAntialiasing(boolean Antialiasing)
	// {
		
	// }
	
	// /**
	//  * The scale of the camera object, irrespective of zoom.
	//  * Currently yields weird display results,
	//  * since cameras aren't nested in an extra display object yet.
	//  */
	// public SpiPoint getScale()
	// {
	// 	SpiGameStage stage = SpiG.getStage();
	// 	return _point.make(stage.stageWidth/glCamera.viewportWidth,stage.stageHeight/glCamera.viewportHeight);
	// }
	
	// /**
	//  * @private
	//  */
	// public void setScale(float X, float Y)
	// {
	// 	// Do nothing if any of the values is 0
	// 	if(X == 0 || Y == 0)
	// 		return;
		
	// 	SpiGameStage stage = SpiG.getStage();
	// 	float screenAspectRatio = SpiG.screenWidth / (float)SpiG.screenHeight;

	// 	switch(_scaleMode)
	// 	{
	// 		case NO_SCALE:
	// 			_screenScaleFactorY = 1;
	// 			_screenScaleFactorX = 1;
	// 			viewportWidth = (int) (SpiG.screenWidth/X);
	// 			viewportHeight = (int) (SpiG.screenHeight/Y);
	// 			break;
	// 		default:
	// 		case STRETCH:
	// 			_screenScaleFactorY = (float)SpiG.screenHeight / stage.stageHeight;
	// 			_screenScaleFactorX = (float)SpiG.screenWidth / stage.stageWidth;
	// 			viewportWidth = (int) (stage.stageWidth/X);
	// 			viewportHeight = (int) (stage.stageHeight/Y);
	// 			break;
	// 		case FILL_X:
	// 			_screenScaleFactorX = (float)SpiG.screenWidth / (stage.stageHeight * screenAspectRatio);
	// 			_screenScaleFactorY = (float)SpiG.screenHeight / stage.stageHeight;
	// 			viewportWidth = (int) ((stage.stageHeight * screenAspectRatio)/X);
	// 			viewportHeight = (int) (stage.stageHeight/Y);
	// 			break;
	// 		case FILL_Y:
	// 			_screenScaleFactorX = (float)SpiG.screenWidth / stage.stageWidth;
	// 			_screenScaleFactorY = (float)SpiG.screenHeight / (stage.stageWidth / screenAspectRatio);
	// 			viewportWidth = (int) (stage.stageWidth/X);
	// 			viewportHeight = (int) ((stage.stageWidth / screenAspectRatio)/Y);
	// 			break;
	// 	}

	// 	// Set the screen size
	// 	if(Gdx.graphics.isFullscreen() && Gdx.app.getType() != ApplicationType.Android) {
	// 		// Update the offset full screen
	// 		_offsetFullscreen.set(SpiG.screenWidth - SpiG.width, SpiG.screenHeight - SpiG.height);
	// 		_offsetFullscreen.mul(0.5f);
			
	// 		glCamera.setToOrtho(true, SpiG.screenWidth, SpiG.screenHeight);
	// 	} else {
	// 		glCamera.setToOrtho(true, viewportWidth, viewportHeight);
	// 	}
		
	// 	// Set the offset
	// 	_flashOffsetX = glCamera.position.x - _offsetFullscreen.x;
	// 	_flashOffsetY = glCamera.position.y - _offsetFullscreen.y;	
	// }
	
	// /**
	//  * Fill the camera with the specified color.
	//  * 
	//  * @param	Color		The color to fill with in 0xAARRGGBB hex format.
	//  * @param	BlendAlpha	Whether to blend the alpha value or just wipe the previous contents.  Default is true.
	//  */
	// public void fill(int Color, boolean BlendAlpha)
	// {
	// 	if (BlendAlpha)
	// 	{
	// 		SpiG.gl.glEnable(GL20.GL_BLEND);
	// 		SpiG.gl.glBlendFunc(GL20.GL_SRC_ALPHA, GL20.GL_ONE_MINUS_SRC_ALPHA);
	// 	}
	// 	else
	// 		SpiG.gl.glDisable(GL20.GL_BLEND);
		
	// 	ShapeRenderer flashGfx = SpiG.flashGfx.getShapeRenderer();
	// 	flashGfx.setProjectionMatrix(glCamera.combined);
	// 	flashGfx.begin(ShapeType.Filled);
	// 	int color = SpiU.multiplyColors(Color, _color);
	// 	flashGfx.setColor(((color >> 16) & 0xFF) * 0.00392f, ((color >> 8) & 0xFF) * 0.00392f, (color & 0xFF) * 0.00392f, ((Color >> 24) & 0xFF) * 0.00392f);
	// 	flashGfx.rect(0, 0, width, height);
	// 	flashGfx.end();
	// }
	
	// /**
	//  * Fill the camera with the specified color.
	//  * 
	//  * @param	Color		The color to fill with in 0xAARRGGBB hex format.
	//  */
	// public void fill(int Color)
	// {
	// 	fill(Color, true);
	// }
	
	// /**
	//  * Internal helper function, handles the actual drawing of all the special effects.
	//  */
	// void drawFX()
	// {
	// 	float alphaComponent;
		
	// 	//Draw the "flash" special effect onto the buffer
	// 	if(_fxFlashAlpha > 0.0f)
	// 	{
	// 		alphaComponent = _fxFlashColor>>24;
	// 		fill(((int)(((alphaComponent <= 0)?0xff:alphaComponent)*_fxFlashAlpha)<<24)+(_fxFlashColor&0x00ffffff));
	// 	}
		
	// 	//Draw the "fade" special effect onto the buffer
	// 	if(_fxFadeAlpha > 0.0f)
	// 	{
	// 		alphaComponent = _fxFadeColor>>24;
	// 		fill(((int) (((alphaComponent <= 0) ? 0xff : alphaComponent) * _fxFadeAlpha) << 24) + (_fxFadeColor & 0x00ffffff));
	// 	}
		
	// 	if((_fxShakeOffset.x != 0) || (_fxShakeOffset.y != 0))
	// 	{
	// 		glCamera.position.x = x + _flashOffsetX + _fxShakeOffset.x;
	// 		glCamera.position.y = y + _flashOffsetY + _fxShakeOffset.y;
	// 	}
	// }

	// /**
	//  * Return the orthographic camera for crazy camera effects.
	//  */
	// public OrthographicCamera getOrthographicCamera()
	// {
	// 	return glCamera;
	// }

	// /**
	//  * If we want to use the Zoom Offset for bounds checking.
	//  */
	// public void setUseZoomOffsetForBounds(boolean value)
	// {
	// 	_useZoomOffsetForBounds = value;
	// }


	// /**
	//  * Return if we are using the Zoom Offset for bounds checking.
	//  */
	// public boolean getUseZoomOffsetForBounds()
	// {
	// 	return _useZoomOffsetForBounds;
	// }
	
	// /**
	//  * Get the offset full screen.
	//  */
	// public SpiPoint getOffsetFullscreen()
	// {
	// 	return _offsetFullscreen;
	// }
}