package spiller;


// import spiller.event.ISpiObject;
// import spiller.math.SpiMath;
// import spiller.system.SpiTile;
// import spiller.system.flash.Graphics;
// import spiller.util.SpiDestroyUtil;
import spiller.math.SpiPoint;

/**
 * This is the base class for most of the display objects<br>
 * (<code>SpiSprite</code>, <code>SpiText</code>, etc).<br>
 * It includes some basic attributes about game objects,<br>
 * including retro-style flickering, basic state information,<br>
 * sizes, scrolling, and basic physics and motion.<br>
 * <br>
 * v1.0 Initial version
 * 
 * @version 1.0 - 17/07/2013
 * @author ratalaika / ratalaikaGames
 * @author Ka Wing Chin
 * @author Thomas Weston
 */
class SpiObject extends SpiBasic
{
	// /**
	//  * Generic value for "left" Used by <code>facing</code>, <code>allowCollisions</code>, and <code>touching</code>.
	//  */
	// public static inline var LEFT = 0x000100;
	// /**
	//  * Generic value for "right" Used by <code>facing</code>, <code>allowCollisions</code>, and <code>touching</code>.
	//  */
	// public static inline var RIGHT = 0x001000;
	// /**
	//  * Generic value for "up" Used by <code>facing</code>, <code>allowCollisions</code>, and <code>touching</code>.
	//  */
	// public static inline var UP = 0x010000;
	// /**
	//  * Generic value for "down" Used by <code>facing</code>, <code>allowCollisions</code>, and <code>touching</code>.
	//  */
	// public static inline var DOWN = 0x100000;	
	// /**
	//  * Special-case const meaning no collisions, used mainly by <code>allowCollisions</code> and <code>touching</code>.
	//  */
	// public static inline var NONE = 0;
	// /**
	//  * Special-case const meaning up, used mainly by <code>allowCollisions</code> and <code>touching</code>.
	//  */
	// public static inline var CEILING = UP;
	// /**
	//  * Special-case const meaning down, used mainly by <code>allowCollisions</code> and <code>touching</code>.
	//  */
	// public static inline var FLOOR = DOWN;
	// /**
	//  * Special-case const meaning only the left and right sides, used mainly by <code>allowCollisions</code> and <code>touching</code>.
	//  */
	// public static inline var WALL = LEFT | RIGHT;
	// /**
	//  * Special-case const meaning any direction, used mainly by <code>allowCollisions</code> and <code>touching</code>.
	//  */
	// public static inline var ANY	= LEFT | RIGHT | UP | DOWN;
	// /**
	//  * The number of pixels the overlap can have before it won't count.<br>
	//  * Default value is 4, should be enough for normal games 16x16 or so<br>
	//  * for bigger game you may need to increase this to avoid entering on the map.<br>
	//  * (Used in <code>separateX()</code> and <code>separateY()</code>).
	//  */
	// public static float OVERLAP_BIAS = 4;
	// /**
	//  * If we want to prevent overlapping of colliding objects.<br>
	//  * This is useful to prevent that one objects move inside another a few pixels.
	//  */
	// public static boolean PREVENT_OVERLAP = false;
	// /**
	//  * Path behavior controls: move from the start of the path to the end then stop.
	//  */
	// public static inline var PATH_FORWARD = 0x000000;
	// /**
	//  * Path behavior controls: move from the end of the path to the start then stop.
	//  */
	// public static inline var PATH_BACKWARD = 0x000001;
	// /**
	//  * Path behavior controls: move from the start of the path to the end then directly back to the start, and start over.
	//  */
	// public static inline var PATH_LOOP_FORWARD = 0x000010;
	// /**
	//  * Path behavior controls: move from the end of the path to the start then directly back to the end, and start over.
	//  */
	// public static inline var PATH_LOOP_BACKWARD = 0x000100;
	// /**
	//  * Path behavior controls: move from the start of the path to the end then turn around and go back to the start, over and over.
	//  */
	// public static inline var  PATH_YOYO = 0x001000;
	// /**
	//  * Path behavior controls: ignores any vertical component to the path data, only follows side to side.
	//  */
	// public static inline var PATH_HORIZONTAL_ONLY = 0x010000;
	// /**
	//  * Path behavior controls: ignores any horizontal component to the path data, only follows up and down.
	//  */
	// public static inline var PATH_VERTICAL_ONLY = 0x100000;

	// //==========================//
	// //	NON STATIC ATTRIBUTES	//
	// //==========================//
	// /**
	//  * X position of the upper left corner of this object in world space.
	//  */
	// public float x;
	// /**
	//  * Y position of the upper left corner of this object in world space.
	//  */
	// public float y;
	// /**
	//  * The width of this object.
	//  */
	// public float width;
	// /**
	//  * The height of this object.
	//  */
	// public float height;
	// /**
	//  * Whether an object will move/alter position after a collision.
	//  */
	// public boolean immovable;
	// /**
	//  * Whether an object will move/alter position after a collision in the X.
	//  */
	// public boolean immovableX;
	// /**
	//  * Whether an object will move/alter position after a collision in the Y axis.
	//  */
	// public boolean immovableY;
	// /**
	//  * The basic speed of this object.
	//  */
	// public SpiPoint velocity;
	// /**
	//  * The virtual mass of the object. Default value is 1.
	//  * Currently only used with <code>elasticity</code> during collision resolution.
	//  * Change at your own risk; effects seem crazy unpredictable so far!
	//  */
	// public float mass;
	// /**
	//  * The bounciness of this object.  Only affects collisions.  Default value is 0, or "not bouncy at all."
	//  */
	// public float elasticity;
	// /**
	//  * How fast the speed of this object is changing.
	//  * Useful for smooth movement and gravity.
	//  */
	// public SpiPoint acceleration;
	// /**
	//  * This isn't drag exactly, more like deceleration that is only applied
	//  * when acceleration is not affecting the sprite.
	//  */
	// public SpiPoint drag;
	// /**
	//  * If you are using <code>acceleration</code>, you can use <code>maxVelocity</code> with it
	//  * to cap the speed automatically (very useful!).
	//  */
	// public SpiPoint maxVelocity;
	// /**
	//  * Set the angle of a sprite to rotate it.
	//  * WARNING: rotating sprites decreases rendering
	//  * performance for this sprite by a factor of 10x!
	//  */
	// public float angle;
	// /**
	//  * This is how fast you want this sprite to spin.
	//  */
	// public float angularVelocity;
	// /**
	//  * How fast the spin speed should change.
	//  */
	// public float angularAcceleration;
	// /**
	//  * Like <code>drag</code> but for spinning.
	//  */
	// public float angularDrag;
	// /**
	//  * Use in conjunction with <code>angularAcceleration</code> for fluid spin speed control.
	//  */
	// public float maxAngular;
	/**
	 * Should always represent (0,0) - useful for different things, for avoiding unnecessary <code>new</code> calls.
	 */
	private static var _pZero(default, never):SpiPoint = SpiPoint.get();
	// /**
	//  * A point that can store numbers from 0 to 1 (for X and Y independently)
	//  * that governs how much this object is affected by the camera subsystem.
	//  * 0 means it never moves, like a HUD element or far background graphic.
	//  * 1 means it scrolls along a the same speed as the foreground layer.
	//  * scrollFactor is initialized as (1,1) by default.
	//  */
	// public SpiPoint scrollFactor;
	// /**
	//  * Internal helper used for retro-style flickering.
	//  */
	// private boolean _flicker;
	// /**
	//  * Internal helper used for retro-style flickering.
	//  */
	// private float _flickerTimer;
	// /**
	//  * Handy for storing health percentage or armor points or whatever.
	//  */
	// public float health;
	// /**
	//  * This is just a pre-allocated x-y point container to be used however you like
	//  */
	// private SpiPoint _point;
	// /**
	//  * This is just a pre-allocated rectangle container to be used however you like
	//  */
	// private SpiRect _rect;
	// /**
	//  * Set this to false if you want to skip the automatic motion/movement stuff (see <code>updateMotion()</code>).
	//  * SpiObject and SpiSprite default to true.
	//  * SpiText, SpiTileblock and SpiTilemap default to false.
	//  */
	// public boolean moves;
	// /**
	//  * Bit field of flags (use with UP, DOWN, LEFT, RIGHT, etc) indicating surface contacts.
	//  * Use bitwise operators to check the values stored here, or use touching(), justStartedTouching(), etc.
	//  * You can even use them broadly as boolean values if you're feeling saucy!
	//  */
	// public int touching;
	// /**
	//  * Bit field of flags (use with UP, DOWN, LEFT, RIGHT, etc) indicating surface contacts from the previous game loop step.
	//  * Use bitwise operators to check the values stored here, or use touching(), justStartedTouching(), etc.
	//  * You can even use them broadly as boolean values if you're feeling saucy!
	//  */
	// public int wasTouching;
	// /**
	//  * Bit field of flags (use with UP, DOWN, LEFT, RIGHT, etc) indicating collision directions.
	//  * Use bitwise operators to check the values stored here.
	//  * Useful for things like one-way platforms (e.g. allowCollisions = UP;)
	//  * The accessor "solid" just flips this variable between NONE and ANY.
	//  */
	// public int allowCollisions;
	// /**
	//  * Important variable for collision processing.
	//  * By default this value is set automatically during <code>preUpdate()</code>.
	//  */
	// public SpiPoint last;
	// /**
	//  * A reference to a path object.  Null by default, assigned by <code>followPath()</code>.
	//  */
	// public SpiPath path;
	// /**
	//  * The speed at which the object is moving on the path.
	//  * When an object completes a non-looping path circuit,
	//  * the pathSpeed will be zeroed out, but the <code>path</code> reference
	//  * will NOT be nulled out.  So <code>pathSpeed</code> is a good way
	//  * to check if this object is currently following a path or not.
	//  */
	// public float pathSpeed;
	// /**
	//  * The angle in degrees between this object and the next node, where 0 is directly upward, and 90 is to the right.
	//  */
	// public float pathAngle;
	// /**
	//  * Internal helper, tracks which node of the path this object is moving toward.
	//  */
	// private int _pathNodeIndex;
	// /**
	//  * Internal tracker for path behavior flags (like looping, horizontal only, etc).
	//  */
	// private int _pathMode;
	// /**
	//  * Internal helper for node navigation, specifically yo-yo and backwards movement.
	//  */
	// private int _pathInc;
	// /**
	//  * Internal flag for whether the object's angle should be adjusted to the path angle during path follow behavior.
	//  */
	// private boolean _pathRotate;
	// /**
	//  * The object you are seeking.
	//  */
	// private SpiObject _seeked;
	// /**
	//  * The force of the seeker.
	//  */
	// private SpiPoint steerForce;
	// /**
	//  * The collision categoryBits.
	//  */
	// public int categoryBits = NONE;
	// /**
	//  * The collision maskBits.
	//  */
	// public int maskBits = NONE;
	// /**
	//  * The ground index for collisions.
	//  */
	// public int groupIndex = NONE;
	// /**
	//  * The information about the last collision.<br>
	//  * You can use it on the postCollision method. 
	//  */
	// private int _lastTouching;
		
	// /**
	//  * Instantiates a <code>SpiObject</code>.
	//  * 
	//  * @param	X		The X-coordinate of the point in space.
	//  * @param	Y		The Y-coordinate of the point in space.
	//  * @param	Width	Desired width of the rectangle.
	//  * @param	Height	Desired height of the rectangle.
	//  */
	// public SpiObject(float X, float Y, int Width, int Height)
	// {
	// 	x = X;
	// 	y = Y;
	// 	last = SpiPoint.get(x, y);
	// 	width = Width;
	// 	height = Height;
	// 	mass = 1.0f;
	// 	elasticity = 0.0f;

	// 	health = 1;
		
	// 	immovable = false;
	// 	immovableX = false;
	// 	immovableY = false;
	// 	moves = true;
		
	// 	touching = NONE;
	// 	wasTouching = NONE;
	// 	allowCollisions = ANY;
		
	// 	velocity = SpiPoint.get();
	// 	acceleration = SpiPoint.get();
	// 	drag = SpiPoint.get();
	// 	maxVelocity = SpiPoint.get(10000,10000);
	// 	steerForce = SpiPoint.get();
		
	// 	angle = 0;
	// 	angularVelocity = 0;
	// 	angularAcceleration = 0;
	// 	angularDrag = 0;
	// 	maxAngular = 10000;
		
	// 	scrollFactor = SpiPoint.get(1.0f,1.0f);
	// 	_flicker = false;
	// 	_flickerTimer = 0;
		
	// 	_point = SpiPoint.get();
	// 	_rect = new SpiRect();
		
	// 	path = null;
	// 	pathSpeed = 0;
	// 	pathAngle = 0;

	// 	_seeked = null;
	// }
	
	// /**
	//  * Instantiates a <code>SpiObject</code>.
	//  * 
	//  * @param	X		The X-coordinate of the point in space.
	//  * @param	Y		The Y-coordinate of the point in space.
	//  * @param	Width	Desired width of the rectangle.
	//  */
	// public SpiObject(float X, float Y, int Width)
	// {
	// 	this(X, Y, Width, 0);
	// }
	
	// /**
	//  * Instantiates a <code>SpiObject</code>.
	//  * 
	//  * @param	X		The X-coordinate of the point in space.
	//  * @param	Y		The Y-coordinate of the point in space.
	//  */
	// public SpiObject(float X,float Y)
	// {
	// 	this(X, Y, 0, 0);
	// }
	
	// /**
	//  * Instantiates a <code>SpiObject</code>.
	//  * 
	//  * @param	X		The X-coordinate of the point in space.
	//  */
	// public SpiObject(float X)
	// {
	// 	this(X, 0, 0, 0);
	// }
	
	// /**
	//  * Instantiates a <code>SpiObject</code>.
	//  */
	// public SpiObject()
	// {
	// 	this(0, 0, 0, 0);
	// }
	
	// /**
	//  * Override this method to null out variables or
	//  * manually call destroy() on class members if necessary.
	//  * Don't forget to call super.destroy()!
	//  */
	// override
	// public void destroy()
	// {
	// 	velocity = SpiDestroyUtil.put(velocity);
	// 	acceleration = SpiDestroyUtil.put(acceleration);
	// 	drag = SpiDestroyUtil.put(drag);
	// 	maxVelocity = SpiDestroyUtil.put(maxVelocity);
	// 	scrollFactor = SpiDestroyUtil.put(scrollFactor);
	// 	last = SpiDestroyUtil.put(last);
	// 	_point = SpiDestroyUtil.put(_point);
	// 	steerForce = SpiDestroyUtil.put(steerForce);
	// 	_rect = null;
		
	// 	cameras = null;
	// 	if(path != null)
	// 		path.destroy();
	// 	path = null;
	// 	_seeked = null;

	// 	super.destroy();
	// }
	
	// /**
	//  * Pre-update is called right before <code>update()</code> on each object in the game loop.
	//  * In <code>SpiObject</code> it controls the flicker timer,
	//  * tracking the last coordinates for collision purposes,
	//  * and checking if the object is moving along a path or not.
	//  */
	// override
	// public void preUpdate()
	// {
	// 	ACTIVECOUNT++;
		
	// 	if(_flickerTimer != 0)
	// 	{
	// 		_flicker = !_flicker;
	// 		if(_flickerTimer > 0)
	// 		{
	// 			_flickerTimer = _flickerTimer - SpiG.elapsed;
	// 			if(_flickerTimer <= 0)
	// 			{
	// 				_flickerTimer = 0;
	// 				_flicker = false;
	// 			}
	// 		}
	// 	}
		
	// 	last.x = x;
	// 	last.y = y;
		
	// 	if((path != null) && (pathSpeed != 0) && (path.nodes.get(_pathNodeIndex) != null))
	// 		updatePathMotion();

	// 	if(_seeked != null)
	// 		updateSeekMotion();
	// }
	
	// /**
	//  * Post-update is called right after <code>update()</code> on each object in the game loop.
	//  * In <code>SpiObject</code> this method handles integrating the objects motion
	//  * based on the velocity and acceleration settings, and tracking/clearing the <code>touching</code> flags.
	//  */
	// override
	// public void postUpdate()
	// {
	// 	if(moves)
	// 		updateMotion();
		
	// 	wasTouching = touching;
	// 	touching = NONE;
	// }
	
	// /**
	//  * Internal method for updating the position and speed of this object.
	//  * Useful for cases when you need to update this but are buried down in too many supers.
	//  * Does a slightly fancier-than-normal integration to help with higher fidelity framerate-independenct motion.
	//  */
	// private void updateMotion()
	// {
	// 	float delta;
	// 	float velocityDelta;

	// 	velocityDelta = (SpiU.computeVelocity(angularVelocity, angularAcceleration, angularDrag, maxAngular, SpiG.elapsed) - angularVelocity) / 2.f;
	// 	angularVelocity += velocityDelta; 
	// 	angle += angularVelocity * SpiG.elapsed;
	// 	angularVelocity += velocityDelta;

	// 	velocityDelta = (SpiU.computeVelocity(velocity.x, acceleration.x, drag.x, maxVelocity.x, SpiG.elapsed) - velocity.x)/2f;
	// 	velocity.x += velocityDelta;
	// 	delta = velocity.x * SpiG.elapsed;
	// 	velocity.x += velocityDelta;
	// 	x += delta;

	// 	velocityDelta = (SpiU.computeVelocity(velocity.y, acceleration.y, drag.y, maxVelocity.y, SpiG.elapsed) - velocity.y) / 2f;
	// 	velocity.y += velocityDelta;
	// 	delta = velocity.y * SpiG.elapsed;
	// 	velocity.y += velocityDelta;
	// 	y += delta;
	// }
	
	// /**
	//  * Rarely called, and in this case just increments the visible objects count and calls <code>drawDebug()</code> if necessary.
	//  */
	// override
	// public void draw()
	// {
	// 	SpiCamera camera = SpiG.activeCamera;
		
	// 	if (cameras == null)
	// 		cameras = SpiG.cameras;
	// 	if(cameras.indexOf(camera) == -1)
	// 		return;
		
	// 	if(!onScreen(camera))
	// 		return;
	// 	VISIBLECOUNT++;
	// 	if(SpiG.visualDebug && !ignoreDrawDebug)
	// 		drawDebug(camera);
	// }
	
	// /**
	//  * Override this method to draw custom "debug mode" graphics to the
	//  * specified camera while the debugger's visual mode is toggled on.
	//  * 
	//  * @param	Camera	Which camera to draw the debug visuals to.
	//  */
	// override
	// public void drawDebug(SpiCamera Camera)
	// {
	// 	if(Camera == null)
	// 		Camera = SpiG.camera;
		
	// 	// Get bounding box coordinates
	// 	float boundingBoxX = x - (int)(Camera.scroll.x*scrollFactor.x); //copied from getScreenXY()
	// 	float boundingBoxY = y - (int)(Camera.scroll.y*scrollFactor.y);
	// 	boundingBoxX = (int) (boundingBoxX + ((boundingBoxX > 0)?0.0000001f:-0.0000001f));
	// 	boundingBoxY = (int) (boundingBoxY + ((boundingBoxY > 0)?0.0000001f:-0.0000001f));
	// 	int boundingBoxWidth = (int) width;
	// 	int boundingBoxHeight = (int) height;
		
	// 	Graphics gfx = SpiG.flashGfx;
	// 	int boundingBoxColor;
	// 	if(allowCollisions > 0)
	// 	{
	// 		if(allowCollisions != ANY)
	// 			boundingBoxColor = SpiG.PINK;
	// 		if(immovable)
	// 			boundingBoxColor = SpiG.GREEN;
	// 		else
	// 			boundingBoxColor = SpiG.RED;
	// 	}
	// 	else
	// 		boundingBoxColor = SpiG.BLUE;
		
	// 	gfx.lineStyle(1.0f, boundingBoxColor, 0.5f);
	// 	gfx.drawRect(boundingBoxX, boundingBoxY, boundingBoxWidth, boundingBoxHeight);
	// }
	
	// /**
	//  * Call this method to give this object a path to follow.
	//  * If the path does not have at least one node in it, this method
	//  * will log a warning message and return.
	//  * 
	//  * @param	Path		The <code>SpiPath</code> you want this object to follow.
	//  * @param	Speed		How fast to travel along the path in pixels per second.
	//  * @param	Mode		Optional, controls the behavior of the object following the path using the path behavior constants.  Can use multiple flags at once, for example PATH_YOYO|PATH_HORIZONTAL_ONLY will make an object move back and forth along the X axis of the path only.
	//  * @param	AutoRotate	Automatically point the object toward the next node.  Assumes the graphic is pointing upward.  Default behavior is false, or no automatic rotation.
	//  */
	// public void followPath(SpiPath Path, float Speed, int Mode, boolean AutoRotate)
	// {
	// 	if (Path == null || Path.nodes.size <= 0) {
	// 		SpiG.log("WARNING: Paths need at least one node in them to be followed.");
	// 		return;
	// 	}
		
	// 	path = Path;
	// 	pathSpeed = SpiU.abs(Speed);
	// 	_pathMode = Mode;
	// 	_pathRotate = AutoRotate;
		
	// 	//get starting node
	// 	if((_pathMode == PATH_BACKWARD) || (_pathMode == PATH_LOOP_BACKWARD)) {
	// 		_pathNodeIndex = path.nodes.size-1;
	// 		_pathInc = -1;
	// 	} else {
	// 		_pathNodeIndex = 0;
	// 		_pathInc = 1;
	// 	}
	// }
	
	// /**
	//  * Call this method to give this object a path to follow.
	//  * If the path does not have at least one node in it, this method
	//  * will log a warning message and return.
	//  * 
	//  * @param	Path		The <code>SpiPath</code> you want this object to follow.
	//  * @param	Speed		How fast to travel along the path in pixels per second.
	//  * @param	Mode		Optional, controls the behavior of the object following the path using the path behavior constants.  Can use multiple flags at once, for example PATH_YOYO|PATH_HORIZONTAL_ONLY will make an object move back and forth along the X axis of the path only.
	//  */
	// public void followPath(SpiPath Path, float Speed, int Mode)
	// {
	// 	followPath(Path, Speed, Mode, false);
	// }
	
	// /**
	//  * Call this method to give this object a path to follow.
	//  * If the path does not have at least one node in it, this method
	//  * will log a warning message and return.
	//  * 
	//  * @param	Path		The <code>SpiPath</code> you want this object to follow.
	//  * @param	Speed		How fast to travel along the path in pixels per second.
	//  */
	// public void followPath(SpiPath Path, float Speed)
	// {
	// 	followPath(Path, Speed, PATH_FORWARD, false);
	// }
	
	// /**
	//  * Call this method to give this object a path to follow.
	//  * If the path does not have at least one node in it, this method
	//  * will log a warning message and return.
	//  * 
	//  * @param	Path		The <code>SpiPath</code> you want this object to follow.
	//  */
	// public void followPath(SpiPath Path)
	// {
	// 	followPath(Path, 100, PATH_FORWARD, false);
	// }
	
	// /**
	//  * Tells this object to stop following the path its on.
	//  * 
	//  * @param	DestroyPath		Tells this method whether to call destroy on the path object.  Default value is false.
	//  */
	// public void stopFollowingPath(boolean DestroyPath)
	// {
	// 	pathSpeed = 0;
	// 	velocity.x = 0;
	// 	velocity.y = 0;

	// 	if(DestroyPath && (path != null)) {
	// 		path.destroy();
	// 		path = null;
	// 	}
	// }
	
	// /**
	//  * Tells this object to stop following the path its on. 
	//  */
	// public void stopFollowingPath()
	// {
	// 	stopFollowingPath(false);
	// }
		
	// /**
	//  * Internal method that decides what node in the path to aim for next based on the behavior flags.
	//  * 
	//  * @param Snap		True if you want to update the X or Y positions for PATH_VERTICAL_ONLY and PATH_HORIZONTAL_ONLY, false otherwise.
	//  * @return			The node (a <code>SpiPoint</code> object) we are aiming for next.
	//  */
	// private SpiPoint advancePath(boolean Snap)
	// {
	// 	if(Snap) {
	// 		SpiPoint oldNode = path.nodes.get(_pathNodeIndex);
	// 		if(oldNode != null) {
	// 			if((_pathMode & PATH_VERTICAL_ONLY) == 0)
	// 				x = oldNode.x - width * 0.5f;
	// 			if((_pathMode & PATH_HORIZONTAL_ONLY) == 0)
	// 				y = oldNode.y - height * 0.5f;
	// 		}
	// 	}
		
	// 	_pathNodeIndex += _pathInc;
		
	// 	if((_pathMode & PATH_BACKWARD) > 0) {
	// 		if(_pathNodeIndex < 0) {
	// 			_pathNodeIndex = 0;
	// 			stopFollowingPath(false);
	// 		}
	// 	} else if((_pathMode & PATH_LOOP_FORWARD) > 0) {
	// 		if(_pathNodeIndex >= path.nodes.size)
	// 			_pathNodeIndex = 0;
	// 	} else if((_pathMode & PATH_LOOP_BACKWARD) > 0) {
	// 		if(_pathNodeIndex < 0) {
	// 			_pathNodeIndex = path.nodes.size - 1;
	// 			if(_pathNodeIndex < 0)
	// 				_pathNodeIndex = 0;
	// 		}
	// 	} else if((_pathMode & PATH_YOYO) > 0) {
	// 		if(_pathInc > 0) {
	// 			if(_pathNodeIndex >= path.nodes.size) {
	// 				_pathNodeIndex = path.nodes.size - 2;
	// 				if(_pathNodeIndex < 0)
	// 					_pathNodeIndex = 0;
	// 				_pathInc = -_pathInc;
	// 			}
	// 		} else if(_pathNodeIndex < 0) {
	// 			_pathNodeIndex = 1;
	// 			if(_pathNodeIndex >= path.nodes.size)
	// 				_pathNodeIndex = path.nodes.size - 1;
	// 			if(_pathNodeIndex < 0)
	// 				_pathNodeIndex = 0;
	// 			_pathInc = -_pathInc;
	// 		}
	// 	}
	// 	else
	// 	{
	// 		if(_pathNodeIndex >= path.nodes.size) {
	// 			_pathNodeIndex = path.nodes.size - 1;
	// 			stopFollowingPath(false);
	// 		}
	// 	}

	// 	return path.nodes.get(_pathNodeIndex);
	// }
	
	// /**
	//  * Internal method that decides what node in the path to aim for next based on the behavior flags.
	//  * 
	//  * @return	The node (a <code>SpiPoint</code> object) we are aiming for next.
	//  */
	// private SpiPoint advancePath()
	// {
	// 	return advancePath(true);
	// }
	
	// /**
	//  * Internal method for moving the object along the path.
	//  * Generally this method is called automatically by <code>preUpdate()</code>.
	//  * The first half of the method decides if the object can advance to the next node in the path,
	//  * while the second half handles actually picking a velocity toward the next node.
	//  */
	// private void updatePathMotion()
	// {
	// 	// First check if we need to be pointing at the next node yet
	// 	_point.x = x + width * 0.5f;
	// 	_point.y = y + height * 0.5f;
	// 	SpiPoint node = path.nodes.get(_pathNodeIndex);
	// 	float deltaX = node.x - _point.x;
	// 	float deltaY = node.y - _point.y;
		
	// 	boolean horizontalOnly = (_pathMode & PATH_HORIZONTAL_ONLY) > 0;
	// 	boolean verticalOnly = (_pathMode & PATH_VERTICAL_ONLY) > 0;
		
	// 	if(horizontalOnly) {
	// 		if(((deltaX>0)?deltaX:-deltaX) < pathSpeed * SpiG.elapsed)
	// 			node = advancePath();
	// 	} else if(verticalOnly) {
	// 		if(((deltaY>0)?deltaY:-deltaY) < pathSpeed * SpiG.elapsed)
	// 			node = advancePath();
	// 	} else {
	// 		if(Math.sqrt(deltaX*deltaX + deltaY*deltaY) < pathSpeed * SpiG.elapsed)
	// 			node = advancePath();
	// 	}
		
	// 	// Then just move toward the current node at the requested speed
	// 	if(pathSpeed != 0)
	// 	{
	// 		// Set velocity based on path mode
	// 		_point.x = x + width * 0.5f;
	// 		_point.y = y + height * 0.5f;
	// 		if(horizontalOnly || (_point.y == node.y))
	// 		{
	// 			velocity.x = (_point.x < node.x) ? pathSpeed : -pathSpeed;
	// 			if(velocity.x < 0)
	// 				pathAngle = -90;
	// 			else
	// 				pathAngle = 90;
	// 			if(!horizontalOnly)
	// 				velocity.y = 0;
	// 		}
	// 		else if(verticalOnly || (_point.x == node.x))
	// 		{
	// 			velocity.y = (_point.y < node.y) ? pathSpeed : -pathSpeed;
	// 			if(velocity.y < 0)
	// 				pathAngle = 0;
	// 			else
	// 				pathAngle = 180;
	// 			if(!verticalOnly)
	// 				velocity.x = 0;
	// 		}
	// 		else
	// 		{
	// 			pathAngle = SpiU.getAngle(_point, node);
	// 			SpiU.rotatePoint(0, (int)pathSpeed, 0, 0, pathAngle, velocity);
	// 		}
			
	// 		// Then set object rotation if necessary
	// 		if(_pathRotate)
	// 		{
	// 			angularVelocity = 0;
	// 			angularAcceleration = 0;
	// 			angle = pathAngle;
	// 		}
	// 	}			
	// }

	// /**
	//  * Update your current speed in order to seek an object.
	//  */
	// private void updateSeekMotion()
	// {
	// 	_point.x = (_seeked.x + (int)(_seeked.width/2)) - (x + (int)(width/2));
	// 	_point.y = (_seeked.y + (int)(_seeked.height/2)) - (x + (int)(height/2));
	// 	SpiMath.normalize(_point);
	// 	SpiMath.multiply(_point, maxVelocity);
	// 	SpiMath.subtract(_point, velocity);
	// 	SpiMath.add(steerForce, _point);
	// 	SpiMath.add(velocity, steerForce);
	// }

	// /**
	//  * Start seeking an object
	//  */
	// public void seek(SpiObject o)
	// {
	// 	_seeked = o;
	// }

	// /**
	//  * Stop seeking an object.
	//  */
	// public void stopSeek()
	// {
	// 	_seeked = null;
	// }
	
	// /**
	//  * Override this method if you want to store something before the separate method.
	//  * 
	//  * @param otherObject	The object we are colliding with!
	//  */
	// private void preCollision(SpiObject otherObject)
	// {
	// 	// Nothing to do here
	// }
	
	// /**
	//  * Override this method if you want to store something before the separate method.<br>
	//  * You can check the <b>_lastTouching</b> value to get the collision info.
	//  * 
	//  * @param otherObject	The object we are colliding with!
	//  * @param separatedX	Whether the objects in fact touched and were separated along the X axis.
	//  * @param separatedY	Whether the objects in fact touched and were separated along the Y axis.
	//  */
	// private void postCollision(SpiObject otherObject, boolean separatedX, boolean separatedY)
	// {
	// 	// Nothing to do here
	// }

	// /**
	//  * Checks to see if some <code>SpiObject</code> overlaps this <code>SpiObject</code> or <code>SpiGroup</code>.
	//  * If the group has a LOT of things in it, it might be faster to use <code>SpiG.overlaps()</code>.
	//  * WARNING: Currently tilemaps do NOT support screen space overlap checks!
	//  * 
	//  * @param	ObjectOrGroup	The object or group being tested.
	//  * @param	InScreenSpace	Whether to take scroll factors into account when checking for overlap.  Default is false, or "only compare in world space."
	//  * @param	Camera			Specify which game camera you want.  If null getScreenXY() will just grab the first global camera.
	//  * 
	//  * @return	Whether or not the two objects overlap.
	//  */
	// public boolean overlaps(SpiBasic ObjectOrGroup,boolean InScreenSpace, SpiCamera Camera)
	// {
	// 	if(ObjectOrGroup instanceof SpiGroup)
	// 	{
	// 		boolean results = false;
	// 		SpiBasic basic = null;
	// 		int i = 0;
	// 		Array<SpiBasic> members = ((SpiGroup)ObjectOrGroup).members;
	// 		int length = ((SpiGroup)ObjectOrGroup).size();
	// 		while(i < length)
	// 		{
	// 			basic = members.get(i++);
	// 			if((basic != null) && basic.exists)
	// 			{
	// 				if(overlaps(basic,InScreenSpace,Camera))
	// 					results = true;
	// 			}
	// 		}
	// 		return results;
	// 	}
		
	// 	if(ObjectOrGroup instanceof SpiTilemap)
	// 	{
	// 		// Since tilemap's have to be the caller, not the target, to do proper tile-based collisions,
	// 		// we redirect the call to the tilemap overlap here.
	// 		return ((SpiTilemap)ObjectOrGroup).overlaps(this,InScreenSpace,Camera);
	// 	}
		
	// 	SpiObject object = (SpiObject)ObjectOrGroup;
	// 	if(!InScreenSpace)
	// 	{
	// 		return	(object.x + object.width > x) && 
	// 				(object.x < x + width) &&
	// 				(object.y + object.height > y) && 
	// 				(object.y < y + height);
	// 	}

	// 	if(Camera == null)
	// 		Camera = SpiG.camera;
	// 	SpiPoint objectScreenPos = object.getScreenXY(null,Camera);
	// 	getScreenXY(_point,Camera);
	// 	return	(objectScreenPos.x + object.width > _point.x) && 
	// 			(objectScreenPos.x < _point.x + width) &&
	// 			(objectScreenPos.y + object.height > _point.y) &&
	// 			(objectScreenPos.y < _point.y + height);
	// }
	
	// /**
	//  * Checks to see if some <code>SpiObject</code> overlaps this <code>SpiObject</code> or <code>SpiGroup</code>.
	//  * If the group has a LOT of things in it, it might be faster to use <code>SpiG.overlaps()</code>.
	//  * WARNING: Currently tilemaps do NOT support screen space overlap checks!
	//  * 
	//  * @param	ObjectOrGroup	The object or group being tested.
	//  * @param	InScreenSpace	Whether to take scroll factors into account when checking for overlap.  Default is false, or "only compare in world space."
	//  * 
	//  * @return	Whether or not the two objects overlap.
	//  */
	// public boolean overlaps(SpiBasic ObjectOrGroup,boolean InScreenSpace)
	// {
	// 	return overlaps(ObjectOrGroup, InScreenSpace, null);
	// }
	
	// /**
	//  * Checks to see if some <code>SpiObject</code> overlaps this <code>SpiObject</code> or <code>SpiGroup</code>.
	//  * If the group has a LOT of things in it, it might be faster to use <code>SpiG.overlaps()</code>.
	//  * WARNING: Currently tilemaps do NOT support screen space overlap checks!
	//  * 
	//  * @param	ObjectOrGroup	The object or group being tested.
	//  * 
	//  * @return	Whether or not the two objects overlap.
	//  */
	// public boolean overlaps(SpiBasic ObjectOrGroup)
	// {
	// 	return overlaps(ObjectOrGroup, false, null);
	// }
	
	// /**
	//  * Checks to see if this <code>SpiObject</code> were located at the given position, would it overlap the <code>SpiObject</code> or <code>SpiGroup</code>?
	//  * This is distinct from overlapsPoint(), which just checks that point, rather than taking the object's size into account.
	//  * WARNING: Currently tilemaps do NOT support screen space overlap checks!
	//  * 
	//  * @param	X				The X position you want to check.  Pretends this object (the caller, not the parameter) is located here.
	//  * @param	Y				The Y position you want to check.  Pretends this object (the caller, not the parameter) is located here.
	//  * @param	ObjectOrGroup	The object or group being tested.
	//  * @param	InScreenSpace	Whether to take scroll factors into account when checking for overlap.  Default is false, or "only compare in world space."
	//  * @param	Camera			Specify which game camera you want.  If null getScreenXY() will just grab the first global camera.
	//  * 
	//  * @return	Whether or not the two objects overlap.
	//  */
	// public boolean overlapsAt(float X, float Y, SpiBasic ObjectOrGroup, boolean InScreenSpace, SpiCamera Camera)
	// {
	// 	if(ObjectOrGroup instanceof SpiGroup)
	// 	{
	// 		boolean results = false;
	// 		SpiBasic basic = null;
	// 		int i = 0;
	// 		Array<SpiBasic> members = ((SpiGroup)ObjectOrGroup).members;
	// 		int length = ((SpiGroup)ObjectOrGroup).size();
	// 		while(i < length)
	// 		{
	// 			basic = members.get(i++);
	// 			if((basic != null) && basic.exists)
	// 			{
	// 				if(overlapsAt(X, Y, basic,InScreenSpace,Camera))
	// 					results = true;
	// 			}
	// 		}
	// 		return results;
	// 	}
		
	// 	if(ObjectOrGroup instanceof SpiTilemap)
	// 	{
	// 		//Since tilemap's have to be the caller, not the target, to do proper tile-based collisions,
	// 		// we redirect the call to the tilemap overlap here.
	// 		//However, since this is overlapsAt(), we also have to invent the appropriate position for the tilemap.
	// 		//So we calculate the offset between the player and the requested position, and subtract that from the tilemap.
	// 		SpiTilemap tilemap = (SpiTilemap) ObjectOrGroup;
	// 		return tilemap.overlapsAt(tilemap.x - (X - x),tilemap.y - (Y - y),this,InScreenSpace,Camera);
	// 	}
		
	// 	SpiObject object = (SpiObject) ObjectOrGroup;
	// 	if(!InScreenSpace)
	// 	{
	// 		return	(object.x + object.width > X) && 
	// 				(object.x < X + width) &&
	// 				(object.y + object.height > Y) && 
	// 				(object.y < Y + height);
	// 	}
		
	// 	if(Camera == null)
	// 		Camera = SpiG.camera;
	// 	SpiPoint objectScreenPos = object.getScreenXY(null,Camera);
	// 	_point.x = X - (Camera.scroll.x*scrollFactor.x); //copied from getScreenXY()
	// 	_point.y = Y - (Camera.scroll.y*scrollFactor.y);
	// 	_point.x += (_point.x > 0)?0.0000001f:-0.0000001f;
	// 	_point.y += (_point.y > 0)?0.0000001f:-0.0000001f;
	// 	return	(objectScreenPos.x + object.width > _point.x) && 
	// 			(objectScreenPos.x < _point.x + width) &&
	// 			(objectScreenPos.y + object.height > _point.y) && 
	// 			(objectScreenPos.y < _point.y + height);
	// }
	
	// /**
	//  * Checks to see if this <code>SpiObject</code> were located at the given position, would it overlap the <code>SpiObject</code> or <code>SpiGroup</code>?
	//  * This is distinct from overlapsPoint(), which just checks that point, rather than taking the object's size into account.
	//  * WARNING: Currently tilemaps do NOT support screen space overlap checks!
	//  * 
	//  * @param	X				The X position you want to check.  Pretends this object (the caller, not the parameter) is located here.
	//  * @param	Y				The Y position you want to check.  Pretends this object (the caller, not the parameter) is located here.
	//  * @param	ObjectOrGroup	The object or group being tested.
	//  * @param	InScreenSpace	Whether to take scroll factors into account when checking for overlap.  Default is false, or "only compare in world space."
	//  * 
	//  * @return	Whether or not the two objects overlap.
	//  */
	// public boolean overlapsAt(float X, float Y, SpiBasic ObjectOrGroup, boolean InScreenSpace)
	// {
	// 	return overlapsAt(X, Y, ObjectOrGroup, InScreenSpace, null);
	// }
	
	// /**
	//  * Checks to see if this <code>SpiObject</code> were located at the given position, would it overlap the <code>SpiObject</code> or <code>SpiGroup</code>?
	//  * This is distinct from overlapsPoint(), which just checks that point, rather than taking the object's size into account.
	//  * WARNING: Currently tilemaps do NOT support screen space overlap checks!
	//  * 
	//  * @param	X				The X position you want to check.  Pretends this object (the caller, not the parameter) is located here.
	//  * @param	Y				The Y position you want to check.  Pretends this object (the caller, not the parameter) is located here.
	//  * @param	ObjectOrGroup	The object or group being tested.
	//  * 
	//  * @return	Whether or not the two objects overlap.
	//  */
	// public boolean overlapsAt(float X, float Y, SpiBasic ObjectOrGroup)
	// {
	// 	return overlapsAt(X, Y, ObjectOrGroup, false, null);
	// }
	
	// /**
	//  * Checks to see if a point in 2D world space overlaps this <code>SpiObject</code> object.
	//  * 
	//  * @param	Point			The point in world space you want to check.
	//  * @param	InScreenSpace	Whether to take scroll factors into account when checking for overlap.
	//  * @param	Camera			Specify which game camera you want.  If null getScreenXY() will just grab the first global camera.
	//  * 
	//  * @return	Whether or not the point overlaps this object.
	//  */
	// public boolean overlapsPoint(SpiPoint Point, boolean InScreenSpace, SpiCamera Camera)
	// {
	// 	if(!InScreenSpace)
	// 		return (Point.x > x) && 
	// 				(Point.x < (x + width)) && 
	// 				(Point.y > y) && 
	// 				(Point.y < (y + height));

	// 	if(Camera == null)
	// 		Camera = SpiG.camera;
	// 	float X = Point.x - Camera.scroll.x;
	// 	float Y = Point.y - Camera.scroll.y;
	// 	getScreenXY(_point,Camera);
	// 	Point.putWeak();
	// 	return (X > _point.x) && 
	// 			(X < _point.x+width) && 
	// 			(Y > _point.y) && 
	// 			(Y < _point.y+height);
	// }
	
	// /**
	//  * Checks to see if a point in 2D world space overlaps this <code>SpiObject</code> object.
	//  * 
	//  * @param	Point			The point in world space you want to check.
	//  * @param	InScreenSpace	Whether to take scroll factors into account when checking for overlap.
	//  * 
	//  * @return	Whether or not the point overlaps this object.
	//  */
	// public boolean overlapsPoint(SpiPoint Point, boolean InScreenSpace)
	// {
	// 	return overlapsPoint(Point, InScreenSpace, null);
	// }
	
	// /**
	//  * Checks to see if a point in 2D world space overlaps this <code>SpiObject</code> object.
	//  * 
	//  * @param	Point			The point in world space you want to check.
	//  * 
	//  * @return	Whether or not the point overlaps this object.
	//  */
	// public boolean overlapsPoint(SpiPoint Point)
	// {
	// 	return overlapsPoint(Point, false, null);
	// }

	// /**
	//  * Check and see if this object is currently on screen.
	//  * 
	//  * @param	Camera		Specify which game camera you want.  If null getScreenXY() will just grab the first global camera.
	//  * 
	//  * @return	Whether the object is on screen or not.
	//  */
	// public boolean onScreen(SpiCamera Camera)
	// {
	// 	if(Camera == null)
	// 		Camera = SpiG.camera;
	// 	getScreenXY(_point,Camera);
	// 	return (_point.x + width > 0) && 
	// 			(_point.x < Camera.width) && 
	// 			(_point.y + height > 0) && 
	// 			(_point.y < Camera.height);
	// }
	
	// /**
	//  * Check and see if this object is currently on screen.
	//  * 
	//  * @param	Camera		Specify which game camera you want.  If null getScreenXY() will just grab the first global camera.
	//  */
	// public boolean onScreen()
	// {
	// 	return onScreen(null);
	// }
	
	// /**
	//  * Call this method to figure out the on-screen position of the object.
	//  * 
	//  * @param	Camera		Specify which game camera you want.  If null getScreenXY() will just grab the first global camera.
	//  * @param	Point		Takes a <code>SpiPoint</code> object and assigns the post-scrolled X and Y values of this object to it.
	//  * 
	//  * @return	The <code>Point</code> you passed in, or a new <code>Point</code> if you didn't pass one, containing the screen X and Y position of this object.
	//  */
	// public SpiPoint getScreenXY(SpiPoint Point, SpiCamera Camera)
	// {
	// 	if(Point == null)
	// 		Point = SpiPoint.get();
	// 	if(Camera == null)
	// 		Camera = SpiG.camera;

	// 	Point.x = x - (int)(Camera.scroll.x * scrollFactor.x);
	// 	Point.y = y - (int)(Camera.scroll.y * scrollFactor.y);
	// 	Point.x += (Point.x > 0)?0.0000001f:-0.0000001f;
	// 	Point.y += (Point.y > 0)?0.0000001f:-0.0000001f;
	// 	return Point;
	// }
	
	// /**
	//  * Call this method to figure out the on-screen position of the object.
	//  * 
	//  * @param	Camera		Specify which game camera you want.  If null getScreenXY() will just grab the first global camera. 
	//  *
	//  * @return	The <code>Point</code> you passed in, or a new <code>Point</code> if you didn't pass one, containing the screen X and Y position of this object.
	//  */
	// public SpiPoint getScreenXY(SpiPoint Point)
	// {
	// 	return getScreenXY(Point, null);
	// }
	
	// /**
	//  * Call this method to figure out the on-screen position of the object.
	//  *  
	//  * @return	The <code>Point</code> you passed in, or a new <code>Point</code> if you didn't pass one, containing the screen X and Y position of this object.
	//  */
	// public SpiPoint getScreenXY()
	// {
	// 	return getScreenXY(null, null);
	// }
	
	// /**
	//  * Tells this object to flicker, retro-style.
	//  * Pass a negative value to flicker forever.
	//  * 
	//  * @param	Duration	How many seconds to flicker for.
	//  */
	// public void flicker(float Duration)
	// {
	// 	_flickerTimer = Duration;
	// 	if(_flickerTimer == 0)
	// 		_flicker = false;
	// }
	
	// /**
	//  * Tells this object to flicker, retro-style.
	//  * Pass a negative value to flicker forever.
	//  */ 
	// public void flicker()
	// {
	// 	flicker(1);
	// }
	
	// /**
	//  * Check to see if the object is still flickering.
	//  * 
	//  * @return	Whether the object is flickering or not.
	//  */
	// public boolean getFlickering()
	// {
	// 	return _flickerTimer != 0;
	// }
	
	// /**
	//  * Whether the object collides or not.  For more control over what directions
	//  * the object will collide from, use collision constants (like LEFT, FLOOR, etc)
	//  * to set the value of allowCollisions directly.
	//  */
	// public boolean getSolid()
	// {
	// 	return (allowCollisions & ANY) > NONE;
	// }
	
	// /**
	//  * @private
	//  */
	// public void setSolid(boolean Solid)
	// {
	// 	if(Solid)
	// 		allowCollisions = ANY;
	// 	else
	// 		allowCollisions = NONE;
	// }
	
	// /**
	//  * Retrieve the midpoint of this object in world coordinates.
	//  * 
	//  * @Point	Allows you to pass in an existing <code>SpiPoint</code> object if you're so inclined.  Otherwise a new one is created.
	//  * 
	//  * @return	A <code>SpiPoint</code> object containing the midpoint of this object in world coordinates.
	//  */
	// public SpiPoint getMidpoint(SpiPoint Point)
	// {
	// 	if(Point == null)
	// 		Point = _point;
	// 	Point.x = x + width * 0.5f;
	// 	Point.y = y + height * 0.5f;
	// 	return Point;
	// }
	
	// /**
	//  * Retrieve the midpoint of this object in world coordinates.
	//  * 
	//  * @Point	Allows you to pass in an existing <code>SpiPoint</code> object if you're so inclined.  Otherwise a new one is created.
	//  */ 
	// public SpiPoint getMidpoint()
	// {
	// 	return getMidpoint(null);
	// }
	
	// /**
	//  * Handy method for reviving game objects.
	//  * Resets their existence flags and position.
	//  * 
	//  * @param	X	The new X position of this object.
	//  * @param	Y	The new Y position of this object.
	//  */
	// public void reset(float X, float Y)
	// {
	// 	revive();
	// 	touching = NONE;
	// 	wasTouching = NONE;
	// 	x = X;
	// 	y = Y;
	// 	last.x = x;
	// 	last.y = y;
	// 	velocity.x = 0;
	// 	velocity.y = 0;
	// }
	
	// /**
	//  * Handy method for checking if this object is touching a particular surface.
	//  * For slightly better performance you can just &amp; the value directly into <code>touching</code>.
	//  * However, this method is good for readability and accessibility.
	//  * 
	//  * @param	Direction	Any of the collision flags (e.g. LEFT, FLOOR, etc).
	//  * 
	//  * @return	Whether the object is touching an object in (any of) the specified direction(s) this frame.
	//  */
	// public boolean isTouching(int Direction)
	// {
	// 	return (touching & Direction) > NONE;
	// }
	
	// /**
	//  * Handy method for checking if this object touched a particular surface in this exact call to separate.<br>
	//  * For slightly better performance you can just &amp; the value directly into <code>_lastTouching</code>.<br>
	//  * However, this method is good for readability and accessibility.<br>
	//  * This should be used inside postCollision or inside the process callbacks.
	//  * 
	//  * @param	Direction	Any of the collision flags (e.g. LEFT, FLOOR, etc).
	//  * 
	//  * @return	Whether the object is touched an object in (any of) the specified direction(s) this call to separate.
	//  */
	// public boolean justTouching(int Direction)
	// {
	// 	return (_lastTouching & Direction) > NONE;
	// }
	
	// /**
	//  * Handy method for checking if this object was touching a particular surface.
	//  * For slightly better performance you can just &amp; the value directly into <code>wasTouching</code>.
	//  * However, this method is good for readability and accessibility.
	//  * 
	//  * @param	Direction	Any of the collision flags (e.g. LEFT, FLOOR, etc).
	//  * 
	//  * @return	Whether the object was touching an object in (any of) the specified direction(s) the previous frame.
	//  */
	// public boolean wasTouching(int Direction)
	// {
	// 	return (wasTouching & Direction) > NONE;
	// }
	
	// /**
	//  * Handy method for checking if this object is just landed on a particular surface.
	//  * 
	//  * @param	Direction	Any of the collision flags (e.g. LEFT, FLOOR, etc).
	//  * 
	//  * @return	Whether the object just landed on (any of) the specified surface(s) this frame.
	//  */
	// public boolean justTouched(int Direction)
	// {
	// 	return ((touching & Direction) > NONE) && ((wasTouching & Direction) <= NONE);
	// }
	
	// /**
	//  * Reduces the "health" variable of this sprite by the amount specified in Damage.
	//  * Calls kill() if health drops to or below zero.
	//  * 
	//  * @param	Damage		How much health to take away (use a negative number to give a health bonus).
	//  */
	// public void hurt(float Damage)
	// {
	// 	health = health - Damage;
	// 	if(health <= 0)
	// 		kill();
	// }

	// /**
	//  * The main collision resolution method in spiller.
	//  * 
	//  * @param	Object1 	Any <code>SpiObject</code>.
	//  * @param	Object2		Any other <code>SpiObject</code>.
	//  * 
	//  * @return	Whether the objects in fact touched and were separated.
	//  */
	// public static boolean separate(SpiObject object1, SpiObject object2)
	// {
	// 	// Pre collision callback, do not invoke for SpiTilemaps, in the case of maps
	// 	// the callback will be invoked in the separate X method
	// 	if(!(object1 instanceof SpiTilemap) && !(object2 instanceof SpiTilemap)) {
	// 		object1.preCollision(object2);
	// 		object2.preCollision(object1);
	// 	}
		
	// 	// Clear the preCollision values
	// 	object1._lastTouching = NONE;
	// 	object2._lastTouching = NONE;
		
	// 	// Separate the collision
	// 	boolean separatedX = separateX(object1, object2);
	// 	boolean separatedY = separateY(object1, object2);

	// 	// Post collision callback
	// 	object1.postCollision(object2, separatedX, separatedY);
	// 	object2.postCollision(object1, separatedX, separatedY);
		
	// 	return separatedX || separatedY;
	// }

	// /**
	//  * The X-axis component of the object separation process.
	//  * 
	//  * @param	Object1 	Any <code>SpiObject</code>.
	//  * @param	Object2		Any other <code>SpiObject</code>.
	//  * 
	//  * @return	Whether the objects in fact touched and were separated along the X axis.
	//  */
	// public static boolean separateX(SpiObject Object1, SpiObject Object2)
	// {
	// 	// Can't separate two immovable objects
	// 	boolean obj1immovable = Object1.immovable || Object1.immovableX;
	// 	boolean obj2immovable = Object2.immovable || Object2.immovableX;

	// 	if(obj1immovable && obj2immovable)
	// 		return false;
		
	// 	// If one of the objects is a tilemap, just pass it off.
	// 	if (Object1 instanceof SpiTilemap)
	// 		return ((SpiTilemap) (Object1)).overlapsWithCallback(Object2, separateX);
	// 	if (Object2 instanceof SpiTilemap)
	// 		return ((SpiTilemap) (Object2)).overlapsWithCallback(Object1, separateX, true);
	
	// 	// Check if one of the objects is a SpiTile and call again
	// 	if(Object1 instanceof SpiTile || Object2 instanceof SpiTile) {
	// 		// Pre collision callback
	// 		Object1.preCollision(Object2);
	// 		Object2.preCollision(Object1);
	// 	}
		
	// 	// First, get the two object deltas
	// 	float overlap = 0;
	// 	float obj1delta = Object1.x - Object1.last.x;
	// 	float obj2delta = Object2.x - Object2.last.x;
	// 	if(obj1delta != obj2delta)
	// 	{
	// 		// Check if the X hulls actually overlap
	// 		float obj1deltaAbs = (obj1delta > 0)?obj1delta:-obj1delta;
	// 		float obj2deltaAbs = (obj2delta > 0)?obj2delta:-obj2delta;
	// 		float obj1x = Object1.x-((obj1delta > 0)?obj1delta:0);
	// 		float obj1y = Object1.last.y;
	// 		float obj1width = Object1.width+((obj1delta > 0)?obj1delta:-obj1delta);
	// 		float obj1height = Object1.height;
	// 		float obj2x = Object2.x-((obj2delta > 0)?obj2delta:0);
	// 		float obj2y = Object2.last.y;
	// 		float obj2width = Object2.width+((obj2delta > 0)?obj2delta:-obj2delta);
	// 		float obj2height = Object2.height;
	// 		if((obj1x + obj1width > obj2x) && (obj1x < obj2x + obj2width) && (obj1y + obj1height > obj2y) && (obj1y < obj2y + obj2height))
	// 		{
	// 			float maxOverlap = obj1deltaAbs + obj2deltaAbs + OVERLAP_BIAS;
				
	// 			// If they did overlap (and can), figure out by how much and flip the corresponding flags
	// 			if(obj1delta > obj2delta)
	// 			{
	// 				overlap = Object1.x + Object1.width - Object2.x;
					
	// 				if((overlap > maxOverlap) || (Object1.allowCollisions & RIGHT) == 0 || (Object2.allowCollisions & LEFT) == 0)
	// 					overlap = 0;
	// 				else
	// 				{
	// 					Object1.touching |= RIGHT;
	// 					Object1._lastTouching |= RIGHT;
	// 					Object2.touching |= LEFT;
	// 					Object2._lastTouching |= LEFT;
	// 				}
	// 			}
	// 			else if(obj1delta < obj2delta)
	// 			{
	// 				overlap = Object1.x - Object2.width - Object2.x;
	// 				if((-overlap > maxOverlap) || (Object1.allowCollisions & LEFT) == 0 || (Object2.allowCollisions & RIGHT) == 0)
	// 					overlap = 0;
	// 				else
	// 				{
	// 					Object1.touching |= LEFT;
	// 					Object1._lastTouching |= LEFT;
	// 					Object2.touching |= RIGHT;
	// 					Object2._lastTouching |= RIGHT;
	// 				}
	// 			}
	// 		}
	// 	}

	// 	// Then adjust their positions and velocities accordingly (if there was any overlap)
	// 	if(overlap != 0)
	// 	{
	// 		float obj1v = Object1.velocity.x;
	// 		float obj2v = Object2.velocity.x;
			
	// 		if(!obj1immovable && !obj2immovable)
	// 		{
	// 			overlap *= 0.5f;
	// 			Object1.x = Object1.x - overlap;
	// 			Object2.x += overlap;

	// 			float obj1velocity = (float) (Math.sqrt((obj2v * obj2v * Object2.mass)/Object1.mass) * ((obj2v > 0)?1:-1));
	// 			float obj2velocity = (float) (Math.sqrt((obj1v * obj1v * Object1.mass)/Object2.mass) * ((obj1v > 0)?1:-1));
	// 			float average = (obj1velocity + obj2velocity)*0.5f;
	// 			obj1velocity -= average;
	// 			obj2velocity -= average;
	// 			Object1.velocity.x = average + obj1velocity * Object1.elasticity;
	// 			Object2.velocity.x = average + obj2velocity * Object2.elasticity;
	// 		}
	// 		else if(!obj1immovable)
	// 		{
	// 			Object1.x = Object1.x - overlap;
	// 			Object1.velocity.x = obj2v - obj1v*Object1.elasticity;
	// 		}
	// 		else if(!obj2immovable)
	// 		{
	// 			Object2.x += overlap;
	// 			Object2.velocity.x = obj1v - obj2v*Object2.elasticity;
	// 		}
	// 		return true;
	// 	}
	// 	else
	// 		return false;
	// }
	
	// /**
	//  * The Y-axis component of the object separation process.
	//  * 
	//  * @param	Object1 	Any <code>SpiObject</code>.
	//  * @param	Object2		Any other <code>SpiObject</code>.
	//  * 
	//  * @return	Whether the objects in fact touched and were separated along the Y axis.
	//  */
	// public static boolean separateY(SpiObject Object1, SpiObject Object2)
	// {
	// 	// Can't separate two immovable objects
	// 	boolean obj1immovable = Object1.immovable || Object1.immovableY;
	// 	boolean obj2immovable = Object2.immovable || Object2.immovableY;

	// 	if(obj1immovable && obj2immovable)
	// 		return false;
		
	// 	// If one of the objects is a tilemap, just pass it off.
	// 	if (Object1 instanceof SpiTilemap)
	// 		return ((SpiTilemap) (Object1)).overlapsWithCallback(Object2, separateY);
	// 	if (Object2 instanceof SpiTilemap)
	// 		return ((SpiTilemap) (Object2)).overlapsWithCallback(Object1, separateY, true);

	// 	// First, get the two object deltas
	// 	float overlap = 0;
	// 	float obj1delta = Object1.y - Object1.last.y;
	// 	float obj2delta = Object2.y - Object2.last.y;
	// 	if(obj1delta != obj2delta)
	// 	{
	// 		//Check if the Y hulls actually overlap
	// 		float obj1deltaAbs = (obj1delta > 0)?obj1delta:-obj1delta;
	// 		float obj2deltaAbs = (obj2delta > 0)?obj2delta:-obj2delta;
	// 		float obj1x = Object1.x;
	// 		float obj1y = Object1.y-((obj1delta > 0)?obj1delta:0);
	// 		float obj1width = Object1.width;
	// 		float obj1height = Object1.height+obj1deltaAbs;
	// 		float obj2x = Object2.x;
	// 		float obj2y = Object2.y-((obj2delta > 0)?obj2delta:0);
	// 		float obj2width = Object2.width;
	// 		float obj2height = Object2.height+obj2deltaAbs;
	// 		if((obj1x + obj1width > obj2x) && (obj1x < obj2x + obj2width) && (obj1y + obj1height > obj2y) && (obj1y < obj2y + obj2height))
	// 		{
	// 			float maxOverlap = obj1deltaAbs + obj2deltaAbs + OVERLAP_BIAS;
				
	// 			//If they did overlap (and can), figure out by how much and flip the corresponding flags
	// 			if(obj1delta > obj2delta)
	// 			{
	// 				overlap = Object1.y + Object1.height - Object2.y;
	// 				if((overlap > maxOverlap) || (Object1.allowCollisions & DOWN) == 0 || (Object2.allowCollisions & UP) == 0)
	// 					overlap = 0;
	// 				else
	// 				{
	// 					Object1.touching |= DOWN;
	// 					Object1._lastTouching |= DOWN;
	// 					Object2.touching |= UP;
	// 					Object2._lastTouching |= UP;
	// 				}
	// 			}
	// 			else if(obj1delta < obj2delta)
	// 			{
	// 				overlap = Object1.y - Object2.height - Object2.y;
	// 				if((-overlap > maxOverlap) || (Object1.allowCollisions & UP) == 0 || (Object2.allowCollisions & DOWN) == 0)
	// 					overlap = 0;
	// 				else
	// 				{
	// 					Object1.touching |= UP;
	// 					Object1._lastTouching |= UP;  
	// 					Object2.touching |= DOWN;
	// 					Object2._lastTouching |= DOWN;
	// 				}
	// 			}
	// 		}
	// 	}
		
	// 	// Then adjust their positions and velocities accordingly (if there was any overlap)
	// 	if(overlap != 0)
	// 	{
	// 		float obj1v = Object1.velocity.y;
	// 		float obj2v = Object2.velocity.y;
			
	// 		if(!obj1immovable && !obj2immovable)
	// 		{
	// 			overlap *= 0.5f;
	// 			Object1.y = Object1.y - overlap;
	// 			Object2.y += overlap;

	// 			float obj1velocity = (float) (Math.sqrt((obj2v * obj2v * Object2.mass)/Object1.mass) * ((obj2v > 0)?1:-1));
	// 			float obj2velocity = (float) (Math.sqrt((obj1v * obj1v * Object1.mass)/Object2.mass) * ((obj1v > 0)?1:-1));
	// 			float average = (obj1velocity + obj2velocity)*0.5f;
	// 			obj1velocity -= average;
	// 			obj2velocity -= average;
	// 			Object1.velocity.y = average + obj1velocity * Object1.elasticity;
	// 			Object2.velocity.y = average + obj2velocity * Object2.elasticity;
	// 		}
	// 		else if(!obj1immovable)
	// 		{
	// 			Object1.y = Object1.y - overlap;
	// 			Object1.velocity.y = obj2v - obj1v * Object1.elasticity;

	// 			// This is special case code that handles cases like horizontal moving platforms you can ride
	// 			if(Object2.active && Object2.moves && (obj1delta > obj2delta))
	// 				Object1.x += Object2.x - Object2.last.x;
				
	// 			// Check if we need to fix the position for overlapping
	// 			if(PREVENT_OVERLAP) {
	// 				if(Object1.y + Object1.height > Object2.y) {
	// 					Object1.y = Object2.y - Object1.height;
	// 				}
	// 			}
	// 		}
	// 		else if(!obj2immovable)
	// 		{
	// 			Object2.y += overlap;
	// 			Object2.velocity.y = obj1v - obj2v * Object2.elasticity;

	// 			// This is special case code that handles cases like horizontal moving platforms you can ride
	// 			if(Object1.active && Object1.moves && (obj1delta < obj2delta))
	// 				Object2.x += Object1.x - Object1.last.x;
				
	// 			// Check if we need to fix the position for overlapping
	// 			if(PREVENT_OVERLAP) {
	// 				if(Object2.y + Object2.height > Object1.y) {
	// 					Object2.y = Object1.y - Object2.height;
	// 				}
	// 			}
	// 		}			
	// 		return true;
	// 	}
	// 	else
	// 		return false;
	// }
	
	// /**
	//  * Internal callback method for collision.
	//  */
	// private static ISpiObject separateX = new ISpiObject()
	// {
	// 	override
	// 	public boolean callback(SpiObject Object1, SpiObject Object2)
	// 	{					
	// 		return separateX(Object1, Object2);
	// 	}
	// };
	
	// /**
	//  * Internal callback method for collision.
	//  */
	// private static ISpiObject separateY = new ISpiObject()
	// {
	// 	override
	// 	public boolean callback(SpiObject Object1, SpiObject Object2)
	// 	{
	// 		return separateY(Object1, Object2);
	// 	}
	// };
}