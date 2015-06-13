package spiller.tweens.util;

import spiller.SpiBasic;


typedef TweenCallback = Void->Void;
typedef EaseFunction = Float->Float;

/**
 * Holder for a group of tween options.
 * Used for calls to SpiG.tween.
 * 
 * v1.0 Initial version
 * 
 * @version 1.o - January 28th 2013
 * @author ratalaika / Ratalaika Games
 */
typedef TweenOptions = {
	/**
	 * Tween type.
	 */
	?type:Null<Int>,
	/**
	 * Optional completion callback method.
	 */
	?complete:TweenCallback,
	/**
	 * Optional easer method.
	 */
	?ease:EaseFunction,
	/**
	 * The Tweener to add this Tween to.
	 */
	?tweener:Null<SpiBasic>,
}
