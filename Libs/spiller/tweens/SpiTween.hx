package spiller.tweens;

import spiller.SpiBasic;
import spiller.SpiG;
import spiller.util.interfaces.ISpiDestroyable;

/**
 * The global tween class.
 * 
 * v1.1 Ported to Java
 * v1.0 Initial version (?)
 * 
 * @version 1.1 - January 24th 2013
 * @author ratalaika / Ratalaika Games
 */
class SpiTween implements ISpiDestroyable
{
	/**
	 * Persistent Tween type, will stop when it finishes.
	 */
	public static inline var PERSIST:Int = 1;
	/**
	 * Looping Tween type, will restart immediately when it finishes.
	 */
	public static inline var LOOPING:Int = 2;
	/**
	 * "To and from" Tween type, will play tween hither and thither
	 */
	public static inline var PINGPONG:Int = 4;
	/**
	 * Oneshot Tween type, will stop and remove itself from its core container when it finishes.
	 */
	public static inline var ONESHOT:Int = 8;
	/**
	 * Backward Tween type, will play tween in reverse direction
	 */
	public static inline var BACKWARD:Int = 16;
	/**
	 * True if the tweening is active.
	 */
	public var active:Bool;
	/**
	 * This method will be called when the tween complete.
	 */
	public var complete:Void->Void = null;
	/**
	 * The period of time that tween has completed. 
	 */
	public var percent:Float;
	/**
	 * The scale of time.
	 */
	public var scale:Float;
	/**
	 * The type of tween.
	 */
	private var _type:Int;
	/**
	 * The easer method to apply to the Tweened value.
	 */
	private var _ease:Float->Float = null;
	/**
	 * The percent of completed tween. 
	 */
	private var _t:Float;
	/**
	 * The time that has passed since the tween started.
	 */
	private var _time:Float;
	/**
	 * Duration of the tween (in seconds or frames).
	 */
	private var _target:Float;
	/**
	 * True if the tweening has finished.
	 */
	public var isFinished:Bool;
	/**
	 * The parent object.
	 */
	public var parent:SpiBasic;
	/**
	 * The previous tween.
	 */
	public var prev:SpiTween;
	/**
	 * The next tween.
	 */
	public var next:SpiTween;
	/**
	 * If the tween has to be played in a reverse direction.
	 */
	private var _backward:Bool;

	/**
	 * Constructor. Specify basic information about the Tween.
	 * @param	duration		Duration of the tween (in seconds or frames).
	 * @param	type			Tween type, one of Tween.PERSIST (default), Tween.LOOPING, or Tween.ONESHOT.
	 * @param	complete		Optional callback for when the Tween completes.
	 * @param	ease			Optional easer method to apply to the Tweened value.
	 */
	public function new(duration:Float, type:Int = PERSIST, complete:Void->Void = null, ease:Float->Float = null)
	{
		_target = duration;
		
		if (type == BACKWARD) {
			type = PERSIST | BACKWARD;
		}
		_type = type;
		this.complete = complete;
		_ease = ease;
		_t = 0;
		
		_backward = (_type & BACKWARD) > 0;
	}

	/**
	 * Destroy method.
	 */
	public function destroy():Void
	{
		complete = null;
		parent = null;
		_ease = null;
	}

	/**
	 * Updates the Tween, called by World.
	 */
	public function update():Void
	{
		_time += SpiG.elapsed;
		_t = _time / _target;
		if (_ease != null) {
			_t = _ease(_t);
		}

		if (_backward) {
			_t = 1 - _t;
		}

		if (_time >= _target) {
			if (!_backward) {
				_t = 1;
			} else {
				_t = 0;
			}
			isFinished = true;
		}
	}

	/**
	 * Starts the Tween, or restarts it if it's currently running.
	 */
	public function start():Void
	{
		_time = 0;
		if (_target == 0) {
			active = false;
			return;
		}
		active = true;
	}
	
	/**
	 * Immediately stops the Tween and removes it from its Tweener without calling the complete callback.
	 */
	public function cancel():Void
	{
		active = false;
		if (parent != null) {
			parent.removeTween(this);
		}
	}

	/** 
	 * Called when the Tween completes.
	 */
	public function finish():Void
	{
		if (complete != null)
			complete();

		switch ((_type & ~BACKWARD))
		{
			case PERSIST:
				_time = _target;
				active = false;
			case LOOPING:
				_time %= _target;
				_t = _time / _target;
				if (_ease != null && _t > 0 && _t < 1)
					_t = _ease(_t);
				start();
			case PINGPONG:
				_time %= _target;
				_t = _time / _target;
				if (_ease != null && _t > 0 && _t < 1) _t = _ease(_t);
				if (_backward) _t = 1 - _t;
				_backward = !_backward;
				start();
			case ONESHOT:
				_time = _target;
				active = false;
				parent.removeTween(this, true);
		}
		isFinished = false;
	}

	/**
	 * Get the percent of completed tween.
	 * 
	 * @return
	 */
	public function getPercent():Float
	{
		return _time / _target;
	}

	/**
	 * Set the percent.
	 * 
	 * @param value		The percent value.
	 * @return
	 */
	public function setPercent(value:Float):Float
	{
		_time = _target * value;
		return _time;
	}

	/**
	 * Return the time scale.
	 */
	public function getScale():Float
	{
		return _t;
	}
}
