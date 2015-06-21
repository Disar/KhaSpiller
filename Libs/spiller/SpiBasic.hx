package spiller;

import spiller.tweens.SpiTween;
import spiller.util.interfaces.ISpiDestroyable;
import spiller.util.SpiStringUtil;

/**
 * This is a useful "generic" spiller object.
 * Both <code>SpiObject</code> and <code>SpiGroup</code> extend this class,
 * as do the plugins.  Has no size, position or graphical data.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 27/03/2013
 * @author ratalaika / Ratalaika Games
 * @author Ka Wing Chin
 */
class SpiBasic implements ISpiDestroyable
{
	/**
	 * Number of active SpiBasics in the game.
	 */
	public static var ACTIVECOUNT:Int;
	/**
	 * Number of visible SpiBasics in the game.
	 */
	public static var VISIBLECOUNT:Int;
	/**
	 * IDs seem like they could be pretty useful, huh?
	 * They're not actually used for anything yet though.
	 */
	public var ID:Int;
	/**
	 * Controls whether <code>update():Void</code> and <code>draw():Void</code> are automatically called by SpiState/SpiGroup.
	 */
	public var exists:Bool;
	/**
	 * Controls whether <code>update():Void</code> is automatically called by SpiState/SpiGroup.
	 */
	public var active:Bool;
	/**
	 * Controls whether <code>draw():Void</code> is automatically called by SpiState/SpiGroup.
	 */
	public var visible:Bool;
	/**
	 * Useful state for many game objects - "dead" (!alive) vs alive.
	 * <code>kill():Void</code> and <code>revive():Void</code> both flip this switch (along with exists, but you can override that).
	 */
	public var alive:Bool;
	/**
	 * An array of camera objects that this object will use during <code>draw():Void</code>.
	 * This value will initialize itself during the first draw to automatically
	 * point at the main camera list out in <code>SpiG</code> unless you already set it.
	 * You can also change it afterward too, very flexible!
	 */
	public var cameras:Array<SpiCamera>;
	/**
	 * Setting this to true will prevent the object from appearing
	 * when the visual debug mode in the debugger overlay is toggled on.
	 */
	public var ignoreDrawDebug:Bool;
	/**
	 * If the Tweener should clear on removal. For Entities, this is when they are
	 * removed from a World, and for World this is when the active World is switched.
	 */
	public var autoClear:Bool;
	/**
	 * The SpiTween reference.
	 */
	private var _tween:SpiTween;
	/**
	 * Enum that informs the collision system which type of object this is (to avoid expensive type casting).
	 */
	public var type(default, null):SpiType = SpiType.BASIC;

	/**
	 * Instantiate the basic spiller object.
	 */
	public function new()
	{
		ID = -1;
		exists = true;
		active = true;
		visible = true;
		alive = true;
		ignoreDrawDebug = false;
		
		autoClear = true;
	}

	/**
	 * Override this function to null out variables or manually call
	 * <code>destroy():Void</code> on class members if necessary.
	 * Don't forget to call <code>super.destroy():Void</code>!
	 */
	public function destroy():Void
	{
		// Nothing to destroy initially.
		if (autoClear && hasTween()) {
			clearTweens(true);
			_tween = null;
		}
	}

	/**
	 * Pre-update is called right before <code>update():Void</code> on each object in the game loop.
	 */
	public function preUpdate():Void
	{
		ACTIVECOUNT++;
	}

	/**
	 * Override this function to update your class's position and appearance.
	 * This is where most of your game rules and behavioral code will go.
	 */
	public function update():Void
	{
		// Nothing to update initially.
	}

	/**
	 * Post-update is called right after <code>update():Void</code> on each object in the game loop.
	 */
	public function postUpdate():Void
	{
		// Nothing to post update initially.
	}

	/**
	 * Override this function to control how the object is drawn.
	 * Overriding <code>draw():Void</code> is rarely necessary, but can be very useful.
	 */
	public function draw():Void
	{
		var camera:SpiCamera = SpiG.activeCamera;

		if (cameras == null)
			cameras = SpiG.cameras;
		if (cameras.indexOf(camera) == -1)
			return;
		
		VISIBLECOUNT++;
		if(SpiG.visualDebug && !ignoreDrawDebug)
			drawDebug(camera);
	}

	/**
	 * Override this function to draw custom "debug mode" graphics to the
	 * specified camera while the debugger's visual mode is toggled on.
	 * 
	 * @param	Camera	Which camera to draw the debug visuals to.
	 */
	public function drawDebug(Camera:SpiCamera = null):Void
	{
		// Nothing to draw in debug mode initially.
	}

	/**
	 * Handy function for "killing" game objects.
	 * Default behavior is to flag them as nonexistent AND dead.
	 * However, if you want the "corpse" to remain in the game,
	 * like to animate an effect or whatever, you should override this,
	 * setting only alive to false, and leaving exists true.
	 */
	public function kill():Void
	{
		alive = false;
		exists = false;
	}
	
	/**
	 * Handy function for bringing game objects "back to life". Just sets alive and exists back to true.
	 * In practice, this function is most often called by <code>SpiObject.reset():Void</code>.
	 */
	public function revive():Void
	{
		alive = true;
		exists = true;
	}
	
	/**
	 * Convert object to readable string name.  Useful for debugging, save games, etc.
	 */
	public function toString():String
	{
		return SpiStringUtil.getDebugString([
			LabelValuePair.weak("active", active),
			LabelValuePair.weak("visible", visible),
			LabelValuePair.weak("alive", alive),
			LabelValuePair.weak("exists", exists)]);
	}

	/**
	 * Add a new SpiTween instance to this object.
	 * 
	 * @param t			The SpiTween instance.
	 * @param start		True if it should start.
	 * @return			The t instance.
	 */
	public function addTween(t:SpiTween, start:Bool):SpiTween
	{
		var ft:SpiTween = t;
		if (ft.parent != null) {
			SpiG.log("Cannot add a SpiTween object more than once.");
			return t;
		}
		ft.parent = this;
		ft.next = _tween;
		var friendTween:SpiTween = _tween;
		if (_tween != null) 
			friendTween.prev = t;

		_tween = t;
		if (start) 
			_tween.start();

		return t;
	}

	/**
	 * Remove a new SpiTween instance to this object.
	 * 
	 * @param t			The SpiTween instance.
	 * @param destroy	True if it should be destroyed.
	 * @return			The t instance.
	 */
	public function removeTween(t:SpiTween, destroy:Bool = false):SpiTween
	{
		var ft:SpiTween = t;
		if (ft.parent != this) 
		{
			SpiG.log("Core object does not contain SpiTween.");
			return t;
		}
		if (ft.next != null) 
			ft.next.prev = ft.prev;
		if (ft.prev != null)
			ft.prev.next = ft.next;
		else
			_tween = (ft.next == null) ? null : ft.next;

		ft.next = ft.prev = null;
		ft.parent = null;
		if (destroy) t.destroy();
		t.active = false;
		return t;
	}

	/**
	 * Clear all the game tweens.
	 * 
	 * @param destroy		True if they should be destroyed.
	 */
	public function clearTweens(destroy:Bool = false):Void
	{
		var ft:SpiTween = _tween;
		var fn:SpiTween;
		while (ft != null)
		{
			fn = ft.next;
			removeTween(ft, destroy);
			ft = fn;
		}
	}

	/**
	 * Update the SpiBasic tweens.
	 */
	public function updateTweens():Void
	{
		var t:SpiTween;
		var ft:SpiTween = _tween;
		while (ft != null)
		{
			t = ft;
			if (t.active) {
				t.update();
				if (ft.isFinished) {
					ft.finish();
				}
			}
			ft = ft.next;
		}
	}

	/**
	 * Return true if the SpiBasic has a tween.
	 * 
	 * @return		True if the SpiBasic has a tween.
	 */
	public function hasTween():Bool
	{
		return (_tween != null); 
	}
}

/**
 * Types of spiller objects - mainly for collisions.
 * To be safe, start your own ID's from 1000.
 */
abstract SpiType(Int) from Int from UInt to Int to UInt
{
	public static inline var NONE:SpiType        = 0;
	public static inline var BASIC:SpiType       = 1;
	public static inline var OBJECT:SpiType      = 2;
	public static inline var GROUP:SpiType       = 3;
	public static inline var TILEMAP:SpiType     = 4;
	public static inline var PARTICLE:SpiType    = 5;




	public static inline var PLUGIN_TIME_MANAGER:SpiType    = 500;
}