package spiller.tweens.util;

/**
 * Static class with useful easer floats that can be used by Tweens.
 * 
 * v1.1 Ported to Java
 * v1.0 Initial version (?)
 * 
 * @version 1.1 - January 24th 2013
 * @author ratalaika / Ratalaika Games
 */
class SpiEase 
{
	/** Quadratic in. */
	public static inline function quadIn(t:Float):Float
	{
	return t * t;
	}
	
	/** Quadratic out. */
	public static inline function quadOut(t:Float):Float
	{
		return -t * (t - 2);
	}		

	
	/** Quadratic in and out. */
	public static inline function quadInOut(t:Float):Float
	{
		return t <= .5 ? t * t * 2 : 1 - (--t) * t * 2;
	}		

	
	/** Cubic in. */
	public static inline function cubeIn (t:Float):Float
	{
		return t * t * t;
	}		

	
	/** Cubic out. */
	public static inline function cubeOut(t:Float):Float
	{
		return 1 + (--t) * t * t;
	}		

	
	/** Cubic in and out. */
	public static inline function cubeInOut(t:Float):Float
	{
		return t <= .5 ? t * t * t * 4 : 1 + (--t) * t * t * 4;
	}		

	
	/** Quart in. */
	public static inline function quartIn(t:Float):Float
	{
		return t * t * t * t;
	}		

	
	/** Quart out. */
	public static inline function quartOut(t:Float):Float
	
	{
		return 1 - (t-=1) * t * t * t;
	}		

	
	/** Quart in and out. */
	public static inline function quartInOut(t:Float):Float
	
	{
		return t <= 0.5 ? t * t * t * t * 8 : (1 - (t = t * 2 - 2) * t * t * t) / 2 + 0.5;
	}		

	
	/** Quint in. */
	public static inline function quintIn(t:Float):Float
	
	{
		return t * t * t * t * t;
	}		

	
	/** Quint out. */
	public static inline function quintOut(t:Float):Float
	
	{
		return (t = t - 1) * t * t * t * t + 1;
	}		

	
	/** Quint in and out. */
	public static inline function quintInOut(t:Float):Float
	
	{
		return ((t *= 2) < 1) ? (t * t * t * t * t) / 2 : ((t -= 2) * t * t * t * t + 2) / 2;
	}		

	
	/** Sine in. */
	public static inline function sineIn(t:Float):Float
	
	{
		return -Math.cos(PI2 * t) + 1;
	}		

	
	/** Sine out. */
	public static inline function sineOut(t:Float):Float
	
	{
		return Math.sin(PI2 * t);
	}		

	
	/** Sine in and out. */
	public static inline function sineInOut(t:Float):Float
	
	{
		return -Math.cos(PI * t) / 2 + 0.5;
	}		

	
	/** Bounce in. */
	public static inline function bounceIn(t:Float):Float
	
	{
		t = 1 - t;
		if (t < B1) return 1 - 7.5625 * t * t;
		if (t < B2) return 1 - (7.5625 * (t - B3) * (t - B3) + 0.75);
		if (t < B4) return 1 - (7.5625 * (t - B5) * (t - B5) + 0.9375);
		return 1 - (7.5625 * (t - B6) * (t - B6) + 0.984375);
	}		

	
	/** Bounce out. */
	public static inline function bounceOut(t:Float):Float
	{
		if (t < B1) return 7.5625 * t * t;
		if (t < B2) return 7.5625 * (t - B3) * (t - B3) + 0.75;
		if (t < B4) return 7.5625 * (t - B5) * (t - B5) + 0.9375;
		return 7.5625 * (t - B6) * (t - B6) + 0.984375;
	}		

	
	/** Bounce in and out. */
	public static inline function bounceInOut(t:Float):Float
	{
		if (t < .5)
		{
		t = 1 - t * 2;
		if (t < B1) return (1 - 7.5625 * t * t) / 2;
		if (t < B2) return (1 - (7.5625 * (t - B3) * (t - B3) + 0.75)) / 2;
		if (t < B4) return (1 - (7.5625 * (t - B5) * (t - B5) + 0.9375)) / 2;
		return (1 - (7.5625 * (t - B6) * (t - B6) + 0.984375)) / 2;
		}
		t = t * 2 - 1;
		if (t < B1) return (7.5625 * t * t) / 2 + 0.5;
		if (t < B2) return (7.5625 * (t - B3) * (t - B3) + 0.75) / 2 + 0.5;
		if (t < B4) return (7.5625 * (t - B5) * (t - B5) + 0.9375) / 2 + 0.5;
		return (7.5625 * (t - B6) * (t - B6) + 0.984375) / 2 + 0.5;
	}		

	
	/** Circle in. */
	public static inline function circIn(t:Float):Float
	{
		return -(Math.sqrt(1 - t * t) - 1);
	}		

	
	/** Circle out. */
	public static inline function circOut(t:Float):Float
	{
		return Math.sqrt(1 - (t - 1) * (t - 1));
	}		

	
	/** Circle in and out. */
	public static inline function circInOut(t:Float):Float
	{
		return t <= 0.5 ? (Math.sqrt(1 - t * t * 4) - 1) / -2 : (Math.sqrt(1 - (t * 2 - 2) * (t * 2 - 2)) + 1) / 2;
	}		

	
	/** Exponential in. */
	public static inline function expoIn(t:Float):Float
	{
		return Math.pow(2, 10 * (t - 1));
	}		

	
	/** Exponential out. */
	public static inline function expoOut(t:Float):Float
	{
		return -Math.pow(2, -10 * t) + 1;
	}		

	
	/** Exponential in and out. */
	public static inline function expoInOut(t:Float):Float
	{
		return t < 0.5 ? Math.pow(2, 10 * (t * 2 - 1)) / 2 : (-Math.pow(2, -10 * (t * 2 - 1)) + 2) / 2;
	}		

	
	/** Back in. */
	public static inline function backIn(t:Float):Float
	{
		return t * t * (2.70158 * t - 1.70158);
	}		

	
	/** Back out. */
	public static inline function backOut(t:Float):Float
	{
		return 1 - (--t) * (t) * (-2.70158 * t - 1.70158);
	}		

	
	/** Back in and out. */
	public static inline function backInOut(t:Float):Float
	{
		t *= 2;
		if (t < 1) return t * t * (2.70158 * t - 1.70158) / 2;
		t --;
		return (1 - (--t) * (t) * (-2.70158 * t - 1.70158)) / 2 + 0.5;
	}		

	
	// Easing constants.
	private static inline var PI:Float = 3.1415927;
	private static inline var PI2:Float = 0.5 * 3.1415927;
//	private static inline var EL = 2 * PI / 0.45;
	private static inline var B1:Float = 1 / 2.75;
	private static inline var B2:Float = 2 / 2.75;
	private static inline var B3:Float = 1.5 / 2.75;
	private static inline var B4:Float = 2.5 / 2.75;
	private static inline var B5:Float = 2.25 / 2.75;
	private static inline var B6:Float = 2.625 / 2.75;
	
	/**
	 * Operation of in/out easers:
	 * 
	 * in(t)
	 *	return t;
	 * out(t)
	 * 	return 1 - in(1 - t);
	 * inOut(t)
	 * 	return (t <= .5) ? in(t * 2) / 2 : out(t * 2 - 1) / 2 + .5;
	 */
}