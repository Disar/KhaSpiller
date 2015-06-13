package spiller.math;

// import kha.math.Vector2;

// import spiller.SpiG;
// import spiller.SpiPoint;
// import spiller.SpiRect;
// import spiller.SpiU;

/**
 * Adds a set of fast Math functions and extends a few commonly used ones.
 * 
 * v1.1 Updated some references and commented 
 * v1.0 Initial version
 * 
 * @version 1.1 - 27/02/2013
 * @author ratalaika / Ratalaika Games
 * @author Richard Davey / Photon Storm
 */
class SpiMath
 {
 	#if (flash || js || ios)
	/**
	 * Minimum value of a floating point number.
	 */
	public static inline var MIN_VALUE_FLOAT:Float = 0.0000000000000001;
	#else
	/**
	 * Minimum value of a floating point number.
	 */
	public static inline var MIN_VALUE_FLOAT:Float = 5e-324;
	#end
	/**
	 * Maximum value of a floating point number.
	 */
	public static inline var MAX_VALUE_FLOAT:Float = 1.79e+308;
	/**
	 * Minimum value of an integer.
	 */
	public static inline var MIN_VALUE_INT:Int = -MAX_VALUE_INT;
	/**
	 * Maximum value of an integer.
	 */
	public static inline var MAX_VALUE_INT:Int = 0x7FFFFFFF;
	/**
	 * Approximation of Math.sqrt(2).
	 */
	public static inline var SQUARE_ROOT_OF_TWO:Float = 1.41421356237;
	/**
	 * Used to account for floating-point inaccuracies.
	 */
	public static inline var EPSILON:Float = 0.0000001;

// 	public static var getrandmax:Int = Integer.MAX_VALUE;
// 	private static var mr:Int = 0;
// 	private static var cosTable:Array<Float> = new Array<Float>();
// 	private static var sinTable:Array<Float> = new Array<Float>();
// 	/**
// 	 * A reference to SpiU.PI
// 	 */
// 	public static final float PI = SpiU.PI;
// 	/**
// 	 * 
// 	 */
// 	private static float coefficient1 = (float) (PI / 4);
// 	/**
// 	 * Degrees to radians.
// 	 */
// 	public static final float DEGREESTORADIANS = PI / 180f;
// 	/**
// 	 * Degrees to radians, but shorter variable name.
// 	 */
// 	public static final float DEGTORAD = DEGREESTORADIANS;
// 	/**
// 	 * Radians to degrees.
// 	 */
// 	public static final float RADIANSTODEGREES = 180f / PI;
// 	/**
// 	 * Radians to degrees, but shorter variable name.
// 	 */
// 	public static final float RADTODEG = RADIANSTODEGREES;
	
	/**
	 * Round to the closes number with the number of decimals given. E.g round(2.954165, 2) == 2.95
	 * 
	 * @param num	The number to round.
	 * @param dec 	The number of decimals wanted.
	 * @return The rounded value of that number.
	 */
	public static function roundDecimal(num:Float, dec:Int):Float
	{
		var p:Float = Math.pow(10, dec);
		num = num * p;
		var tmp:Float = Math.round(num);
		return tmp / p;
	}

	/**
	 * Bound a number by a minimum and maximum. Ensures that this number is 
	 * no smaller than the minimum, and no larger than the maximum.
	 * Leaving a bound null means that side is unbounded.
	 * 
	 * @param	Value	Any number.
	 * @param	Min		Any number.
	 * @param	Max		Any number.
	 * @return	The bounded value of the number.
	 */
	public static inline function bound(Value:Float, ?Min:Float, ?Max:Float):Float
	{
		var lowerBound:Float = (Min != null && Value < Min) ? Min : Value;
		return (Max != null && lowerBound > Max) ? Max : lowerBound;
	}

	/**
	 * Returns true if the given x/y coordinate is within the given rectangular block
	 * 
	 * @param	pointX		The X value to test
	 * @param	pointY		The Y value to test
	 * @param	rectX		The X value of the region to test within
	 * @param	rectY		The Y value of the region to test within
	 * @param	rectWidth	The width of the region to test within
	 * @param	rectHeight	The height of the region to test within
	 * 
	 * @return	true if pointX/pointY is within the region, otherwise false
	 */
	public static function pointInCoordinates(pointX:Float, pointY:Float, rectX:Float, rectY:Float, rectWidth:Float, rectHeight:Float):Bool
	{
		if (pointX >= rectX && pointX <= (rectX + rectWidth)) {
			if (pointY >= rectY && pointY <= (rectY + rectHeight)) {
				return true;
			}
		}
		
		return false;
	}
	
	/**
	 * Returns true if the given x/y coordinate is within the given rectangular block
	 * 
	 * @param	pointX		The X value to test
	 * @param	pointY		The Y value to test
	 * @param	rect		The SpiRect to test within
	 * @return	true if pointX/pointY is within the SpiRect, otherwise false
	 */
	public static function pointInSpiRect(pointX:Float, pointY:Float, rect:SpiRect):Bool
	{
		if (pointX >= rect.x && pointX <= rect.width && pointY >= rect.y && pointY <= rect.height)
		{
			return true;
		}
		
		return false;
	}
	
// 	/**
// 	 * Returns true if the mouse world x/y coordinate are within the given rectangular block
// 	 * 
// 	 * @param	useWorldCoords	If true the world x/y coordinates of the mouse will be used, otherwise screen x/y
// 	 * @param	rect			The SpiRect to test within. If this is null for any reason this function always returns true.
// 	 * 
// 	 * @return	true if mouse is within the SpiRect, otherwise false
// 	 */
// 	public static boolean mouseInSpiRect(boolean useWorldCoords, SpiRect rect)
// 	{
// 		if (rect == null) {
// 			return true;
// 		}
		
// 		if (useWorldCoords) {
// 			return pointInSpiRect(SpiG.mouse.x, SpiG.mouse.y, rect);
// 		} else {
// 			return pointInSpiRect(SpiG.mouse.screenX, SpiG.mouse.screenY, rect);
// 		}
// 	}
	
// 	/**
// 	 * Returns true if the given x/y coordinate is within the Rectangle
// 	 * 
// 	 * @param	pointX		The X value to test
// 	 * @param	pointY		The Y value to test
// 	 * @param	rect		The Rectangle to test within
// 	 * @return	true if pointX/pointY is within the Rectangle, otherwise false
// 	 */
// 	public static boolean pointInRectangle(int pointX, int pointY, SpiRect rect)
// 	{
// 		if (pointX >= rect.x && pointX <= rect.getRight() && pointY >= rect.y && pointY <= rect.getBottom())
// 		{
// 			return true;
// 		}
		
// 		return false;
// 	}
	
// 	/**
// 	 * A faster (but much less accurate) version of Math.atan2(). For close range / loose comparisons this works very well, 
// 	 * but avoid for long-distance or high accuracy simulations.
// 	 * Based on: http://blog.gamingyourway.com/PermaLink,guid,78341247-3344-4a7a-acb2-c742742edbb1.aspx
// 	 * <p>
// 	 * Computes and returns the angle of the point y/x in radians, when measured counterclockwise from a circle's x axis 
// 	 * (where 0,0 represents the center of the circle). The return value is between positive pi and negative pi. 
// 	 * Note that the first parameter to atan2 is always the y coordinate.
// 	 * </p>
// 	 * @param y The y coordinate of the point
// 	 * @param x The x coordinate of the point
// 	 * @return The angle of the point x/y in radians
// 	 */
// 	public static float atan2(float y, float x)
// 	{
// 		float absY = y;
// 		float coefficient2 = 3 * coefficient1;
// 		float r;
// 		float angle;
		
// 		if (absY < 0) {
// 			absY = -absY;
// 		}

// 		if (x >= 0) {
// 			r = (x - absY) / (x + absY);
// 			angle = coefficient1 - coefficient1 * r;
// 		} else {
// 			r = (x + absY) / (absY - x);
// 			angle = coefficient2 - coefficient1 * r;
// 		}

// 		return y < 0 ? -angle : angle;
// 	}
	
// 	/**
// 	 * Generate a sine and cosine table simultaneously and extremely quickly. Based on research by Franky of scene.at
// 	 * <p>
// 	 * The parameters allow you to specify the length, amplitude and frequency of the wave. Once you have called this function
// 	 * you should get the results via getSinTable() and getCosTable(). This generator is fast enough to be used in real-time.
// 	 * </p>
// 	 * @param length 		The length of the wave
// 	 * @param sinAmplitude 	The amplitude to apply to the sine table (default 1.0) if you need values between say -+ 125 then give 125 as the value
// 	 * @param cosAmplitude 	The amplitude to apply to the cosine table (default 1.0) if you need values between say -+ 125 then give 125 as the value
// 	 * @param frequency 	The frequency of the sine and cosine table data
// 	 * @return	Returns the sine table
// 	 * @see getSinTable
// 	 * @see getCosTable
// 	 */
// 	public static FloatArray sinCosGenerator(int length, float sinAmplitude, float cosAmplitude, float frequency)
// 	{
// 		float sin = sinAmplitude;
// 		float cos = cosAmplitude;
// 		float frq = (float) (frequency * Math.PI / length);
		
// 		cosTable = new FloatArray(length);
// 		sinTable = new FloatArray(length);
		
// 		for (int c = 0; c < length; c++)
// 		{
// 			cos -= sin * frq;
// 			sin += cos * frq;
			
// 			cosTable.insert(c, cos);
// 			sinTable.insert(c, sin);
// 		}
		
// 		return sinTable;
// 	}

// 	/**
// 	 * Generate a sine and cosine table simultaneously and extremely quickly. Based on research by Franky of scene.at
// 	 * <p>
// 	 * The parameters allow you to specify the length, amplitude and frequency of the wave. Once you have called this function
// 	 * you should get the results via getSinTable() and getCosTable(). This generator is fast enough to be used in real-time.
// 	 * </p>
// 	 * @param length 		The length of the wave
// 	 * @param sinAmplitude 	The amplitude to apply to the sine table (default 1.0) if you need values between say -+ 125 then give 125 as the value
// 	 * @param cosAmplitude 	The amplitude to apply to the cosine table (default 1.0) if you need values between say -+ 125 then give 125 as the value
// 	 * 
// 	 * @return	Returns the sine table
// 	 * @see getSinTable
// 	 * @see getCosTable
// 	 */
// 	public static FloatArray sinCosGenerator(int length, float sinAmplitude, float cosAmplitude)
// 	{
// 		return sinCosGenerator(length, sinAmplitude, cosAmplitude, 1.0f);
// 	}

// 	/**
// 	 * Generate a sine and cosine table simultaneously and extremely quickly. Based on research by Franky of scene.at
// 	 * <p>
// 	 * The parameters allow you to specify the length, amplitude and frequency of the wave. Once you have called this function
// 	 * you should get the results via getSinTable() and getCosTable(). This generator is fast enough to be used in real-time.
// 	 * </p>
// 	 * @param length 		The length of the wave
// 	 * @param sinAmplitude 	The amplitude to apply to the sine table (default 1.0) if you need values between say -+ 125 then give 125 as the value
// 	 * 
// 	 * @return	Returns the sine table
// 	 * @see getSinTable
// 	 * @see getCosTable
// 	 */
// 	public static FloatArray sinCosGenerator(int length, float sinAmplitude)
// 	{
// 		return sinCosGenerator(length, sinAmplitude, 1.0f, 1.0f);
// 	}

// 	/**
// 	 * Generate a sine and cosine table simultaneously and extremely quickly. Based on research by Franky of scene.at
// 	 * <p>
// 	 * The parameters allow you to specify the length, amplitude and frequency of the wave. Once you have called this function
// 	 * you should get the results via getSinTable() and getCosTable(). This generator is fast enough to be used in real-time.
// 	 * </p>
// 	 * @param length 		The length of the wave
// 	 * 
// 	 * @return	Returns the sine table
// 	 * @see getSinTable
// 	 * @see getCosTable
// 	 */
// 	public static FloatArray sinCosGenerator(int length)
// 	{
// 		return sinCosGenerator(length, 1.0f, 1.0f, 1.0f);
// 	}
	
// 	/**
// 	 * Returns the sine table generated by sinCosGenerator(), or an empty array object if not yet populated
// 	 * @return Array of sine wave data
// 	 * @see sinCosGenerator
// 	 */
// 	public static FloatArray getSinTable()
// 	{
// 		return sinTable;
// 	}
	
// 	/**
// 	 * Returns the cosine table generated by sinCosGenerator(), or an empty array object if not yet populated
// 	 * @return Array of cosine wave data
// 	 * @see sinCosGenerator
// 	 */
// 	public static FloatArray getCosTable()
// 	{
// 		return cosTable;
// 	}
	
// 	/**
// 	 * A faster version of Math.sqrt
// 	 * <p>
// 	 * Computes and returns the square root of the specified number.
// 	 * </p>
// 	 * @link http://osflash.org/as3_speed_optimizations#as3_speed_tests
// 	 * @param val A number greater than or equal to 0
// 	 * @return If the parameter val is greater than or equal to zero, a number; otherwise NaN (not a number).
// 	 */
// 	public static float sqrt(float val)
// 	{
// 		float thresh = 0.002f;
// 		float b = val * 0.25f;
// 		float a;
// 		float c;
		
// 		if (val == 0)
// 		{
// 			return 0;
// 		}
		
// 		do {
// 			c = val / b;
// 			b = (b + c) * 0.5f;
// 			a = b - c;
// 			if (a < 0) a = -a;
// 		}
// 		while (a > thresh);
		
// 		return b;
// 	}
	
// 	/**
// 	 * Generates a small random number between 0 and 65535 very quickly
// 	 * <p>
// 	 * Generates a small random number between 0 and 65535 using an extremely fast cyclical generator, 
// 	 * with an even spread of numbers. After the 65536th call to this function the value resets.
// 	 * </p>
// 	 * @return A pseudo random value between 0 and 65536 inclusive.
// 	 */
// 	public static int miniRand()
// 	{
// 		int result = mr;
		
// 		result++;
// 		result *= 75;
// 		result %= 65537;
// 		result--;
		
// 		mr++;
		
// 		if (mr == 65536) {
// 			mr = 0;
// 		}
		
// 		return result;
// 	}
	
// 	/**
// 	 * Generate a random integer
// 	 * <p>
// 	 * If called without the optional min, max arguments rand() returns a peudo-random integer between 0 and getrandmax().
// 	 * If you want a random number between 5 and 15, for example, (inclusive) use rand(5, 15)
// 	 * Parameter order is insignificant, the return will always be between the lowest and highest value.
// 	 * </p>
// 	 * @param min The lowest value to return (default: 0)
// 	 * @param max The highest value to return (default: getrandmax)
// 	 * @param excludes An Array of integers that will NOT be returned (default: null)
// 	 * @return A pseudo-random value between min (or 0) and max (or getrandmax, inclusive)
// 	 */
// 	public static int rand(float min, float max , ArrayList<Integer> excludes)
// 	{
// 		if ((min == -1)  && (max == -1)) {
// 			min = 0;
// 			max = getrandmax;
// 		}
		
// 		if (min == max)
// 			return (int) min;
		
// 		if (excludes != null) {
// 			Collections.sort(excludes);
// 			int result;
			
// 			do {
// 				// Reverse check
// 				if (min < max) {
// 					result = (int) (min + Math.floor(SpiG.random() * (max + 1 - min))); // Math.floor and adding 1 makes this inclusive
// 				} else {
// 					result = (int) (max + Math.floor(SpiG.random() * (min + 1 - max)));
// 				}
// 			}
// 			while (excludes.indexOf(result) >= 0);
// 			return result;
// 		} else {
// 			//	Reverse check
// 			if (min < max) {
// 				return (int) (min + Math.floor(SpiG.random() * (max + 1 - min))); // Math.floor and adding 1 makes this inclusive
// 			} else {
// 				return (int) (max + Math.floor(SpiG.random() * (min + 1 - max))); // Math.floor and adding 1 makes this inclusive
// 			}
// 		}
// 	}

// 	/**
// 	 * Generate a random integer
// 	 * <p>
// 	 * If called without the optional min, max arguments rand() returns a peudo-random integer between 0 and getrandmax().
// 	 * If you want a random number between 5 and 15, for example, (inclusive) use rand(5, 15)
// 	 * Parameter order is insignificant, the return will always be between the lowest and highest value.
// 	 * </p>
// 	 * @param min The lowest value to return (default: 0)
// 	 * @param max The highest value to return (default: getrandmax)
// 	 * @param excludes An int[] of integers that will NOT be returned (default: null)
// 	 * @return A pseudo-random value between min (or 0) and max (or getrandmax, inclusive)
// 	 */
// 	public static int rand(int min, int max, Array<Integer> excludes)
// 	{
// 		ArrayList<Integer> array = new ArrayList<Integer>(excludes.size);
// 		for(int i = 0; i < excludes.size; i++)
// 			array.add(excludes.get(i));

// 		return rand(min, max, array);
// 	}

// 	/**
// 	 * Generate a random integer
// 	 * <p>
// 	 * If called without the optional min, max arguments rand() returns a peudo-random integer between 0 and getrandmax().
// 	 * If you want a random number between 5 and 15, for example, (inclusive) use rand(5, 15)
// 	 * Parameter order is insignificant, the return will always be between the lowest and highest value.
// 	 * </p>
// 	 * @param min The lowest value to return (default: 0)
// 	 * @param max The highest value to return (default: getrandmax)
// 	 * @param excludes An int[] of integers that will NOT be returned (default: null)
// 	 * @return A pseudo-random value between min (or 0) and max (or getrandmax, inclusive)
// 	 */
// 	public static int rand(int min, int max, int[] excludes)
// 	{
// 		ArrayList<Integer> array = new ArrayList<Integer>(excludes.length);
// 		for(int i = 0; i < excludes.length; i++)
// 			array.add(excludes[i]);

// 		return rand(min, max, array);
// 	}

// 	/**
// 	 * Generate a random integer
// 	 * <p>
// 	 * If called without the optional min, max arguments rand() returns a peudo-random integer between 0 and getrandmax().
// 	 * If you want a random number between 5 and 15, for example, (inclusive) use rand(5, 15)
// 	 * Parameter order is insignificant, the return will always be between the lowest and highest value.
// 	 * </p>
// 	 * @param min The lowest value to return (default: 0)
// 	 * @param max The highest value to return (default: getrandmax)
// 	 * @return A pseudo-random value between min (or 0) and max (or getrandmax, inclusive)
// 	 */
// 	public static int rand(float min, float max)
// 	{
// 		return rand(min, max, null);
// 	}

// 	/**
// 	 * Generate a random integer
// 	 * <p>
// 	 * If called without the optional min, max arguments rand() returns a peudo-random integer between 0 and getrandmax().
// 	 * If you want a random number between 5 and 15, for example, (inclusive) use rand(5, 15)
// 	 * Parameter order is insignificant, the return will always be between the lowest and highest value.
// 	 * </p>
// 	 * @return A pseudo-random value between min (or 0) and max (or getrandmax, inclusive)
// 	 */
// 	public static int rand()
// 	{
// 		return rand(-1, -1);
// 	}

// 	/**
// 	 * Generate a random float (number)
// 	 * <p>
// 	 * If called without the optional min, max arguments rand() returns a peudo-random float between 0 and getrandmax().
// 	 * If you want a random number between 5 and 15, for example, (inclusive) use rand(5, 15)
// 	 * Parameter order is insignificant, the return will always be between the lowest and highest value.
// 	 * </p>
// 	 * @param min The lowest value to return (default: 0)
// 	 * @param max The highest value to return (default: getrandmax)
// 	 * @return A pseudo random value between min (or 0) and max (or getrandmax, inclusive)
// 	 */
// 	public static float randFloat(float min, float max)
// 	{
// 		if ((min == -1) && (max == -1)) {
// 			min = 0;
// 			max = getrandmax;
// 		}
		
// 		if (min == max) {
// 			return min;
// 		} else if (min < max) {
// 			return (float) (min + (Math.random() * (max - min + 1)));
// 		} else {
// 			return (float) (max + (Math.random() * (min - max + 1)));
// 		}
// 	}

// 	/**
// 	 * Generate a random float (number)
// 	 * <p>
// 	 * If called without the optional min, max arguments rand() returns a peudo-random float between 0 and getrandmax().
// 	 * If you want a random number between 5 and 15, for example, (inclusive) use rand(5, 15)
// 	 * Parameter order is insignificant, the return will always be between the lowest and highest value.
// 	 * </p>
// 	 * @return A pseudo random value between min (or 0) and max (or getrandmax, inclusive)
// 	 */
// 	public static float randFloat()
// 	{
// 		return randFloat(-1, -1);
// 	}

// 	/**
// 	 * Generate a random boolean result based on the chance value
// 	 * <p>
// 	 * Returns true or false based on the chance value (default 50%). For example if you wanted a player to have a 30% chance
// 	 * of getting a bonus, call chanceRoll(30) - true means the chance passed, false means it failed.
// 	 * </p>
// 	 * @param chance	The chance of receiving the value. Should be given as a uint between 0 and 100 (effectively 0% to 100%)
// 	 * @return true if the roll passed, or false
// 	 */
// 	public static boolean chanceRoll(int chance)
// 	{
// 		if (chance <= 0)
// 		{
// 			return false;
// 		} else if (chance >= 100) {
// 			return true;
// 		} else {
// 			if (Math.random() * 100 >= chance)
// 			{
// 				return false;
// 			} else {
// 				return true;
// 			}
// 		}
// 	}
// 	public static boolean chanceRoll()
// 	{
// 		return chanceRoll(50);
// 	}

// 	/**
// 	 * Adds the given amount to the value, but never lets the value go over the specified maximum.
// 	 * 
// 	 * @param value The value to add the amount to
// 	 * @param amount The amount to add to the value
// 	 * @param max The maximum the value is allowed to be
// 	 * @return The new value
// 	 */
// 	public static int maxAdd(int value, int amount, int max)
// 	{
// 		value += amount;
		
// 		if (value > max) {
// 			value = max;
// 		}
		
// 		return value;
// 	}

// 	/**
// 	 * subs the given amount to the value, but never lets the value go down the specified minimum.
// 	 * 
// 	 * @param value The value to add the amount to
// 	 * @param amount The amount to add to the value
// 	 * @param min The maximum the value is allowed to be
// 	 * @return The new value
// 	 */
// 	public static int minSub(int value, int amount, int min)
// 	{
// 		value -= amount;
		
// 		if (value < min) {
// 			value = min;
// 		}
		
// 		return value;
// 	}

	/**
	 * Adds value to amount and ensures that the result always stays between 0 and max, by wrapping the value around.
	 * <p>Values must be positive integers, and are passed through Math.abs</p>
	 * 
	 * @param value The value to add the amount to
	 * @param amount The amount to add to the value
	 * @param max The maximum the value is allowed to be
	 * @return The wrapped value
	 */
	public static function wrapValue(value:Float, amount:Float, max:Float):Int
	{
		var diff:Float;

		value = Math.abs(value);
		amount = Math.abs(amount);
		max = Math.abs(max);
		
		diff = (value + amount) % max;
		
		return Std.int(diff);
	}

	/**
	 * Finds the length of the given vector
	 * 
	 * @param	dx
	 * @param	dy
	 * 
	 * @return
	 */
    public static function vectorLength(dx:Float, dy:Float):Float
    {
    	return Math.sqrt(dx * dx + dy * dy);
    }

// 	/**
// 	 * Finds the dot product value of two vectors
// 	 * 
// 	 * @param	ax		Vector X
// 	 * @param	ay		Vector Y
// 	 * @param	bx		Vector X
// 	 * @param	by		Vector Y
// 	 * 
// 	 * @return	Dot product
// 	 */
//     public static float dotProduct(float ax, float ay, float bx, float by)
//     {
//         return ax * bx + ay * by;
//     }
   
// 	/**
// 	 * Randomly returns either a 1 or -1
// 	 * 
// 	 * @return	1 or -1
// 	 */
//     public static float randomSign()
//     {
//         return (Math.random() > 0.5) ? 1 : -1;
//     }

// 	/**
// 	 * Returns true if the number given is odd.
// 	 * 
// 	 * @param	n	The number to check
// 	 * 
// 	 * @return	True if the given number is odd. False if the given number is even.
// 	 */
// 	public static boolean isOdd(int n)
// 	{
// 		if ((n & 1) > 0) {
// 			return true;
// 		} else {
// 			return false;
// 		}
// 	}

// 	/**
// 	 * Returns true if the number given is even.
// 	 * 
// 	 * @param	n	The number to check
// 	 * 
// 	 * @return	True if the given number is even. False if the given number is odd.
// 	 */
// 	public static boolean isEven(int n)
// 	{
// 		if ((n & 1) > 0) {
// 			return false;
// 		} else {
// 			return true;
// 		}
// 	}
	
// 	/**
// 	 * Keeps an angle value between -180 and +180<br>
// 	 * Should be called whenever the angle is updated on the SpiSprite to stop it from going insane.
// 	 * 
// 	 * @param	angle	The angle value to check
// 	 * 
// 	 * @return	The new angle value, returns the same as the input angle if it was within bounds
// 	 */
// 	public static int wrapAngle(float angle)
// 	{
// 		int result = (int)(angle);
		
// 		if (angle > 180) {
// 			result = -180;
// 		} else if (angle < -180) {
// 			result = 180;
// 		}
		
// 		return result;
// 	}
	
// 	/**
// 	 * Keeps an angle value between the given min and max values
// 	 * 
// 	 * @param	angle	The angle value to check. Must be between -180 and +180
// 	 * @param	min		The minimum angle that is allowed (must be -180 or greater)
// 	 * @param	max		The maximum angle that is allowed (must be 180 or less)
// 	 * 
// 	 * @return	The new angle value, returns the same as the input angle if it was within bounds
// 	 */
// 	public static float angleLimit(float angle, float min, float max)
// 	{
// 		float result = angle;
		
// 		if (angle > max) {
// 			result = max;
// 		} else if (angle < min) {
// 			result = min;
// 		}
		
// 		return result;
// 	}
	
// 	/**
// 	 * Converts a Radian value into a Degree.
// 	 * 
// 	 * @param radians The value in radians
// 	 * @return Number Degrees
// 	 */
// 	public static float asDegrees(float radians)
// 	{
// 		return radians * RADTODEG;
// 	}
	
// 	/**
// 	 * Converts a Degrees value into a Radian.
// 	 * 
// 	 * @param degrees		The value in degrees
// 	 * @return Number		Radians
// 	 */
// 	public static float asRadians(float degrees)
// 	{
// 		return degrees * DEGTORAD;
// 	}

	/**
	 * Add the first vector the second one.
	 * 
	 * @param	v1	The SpiPoint in question
	 * @param	v2	The SpiPoint to be added to v1
	 */
	public static function add(v1:SpiPoint, v2:SpiPoint):Void
	{
		v1.x += v2.x;
		v1.y += v2.y;
	}

	/**
	 * Subtract the first vector the second one.
	 */
	public static function subtract(v1:SpiPoint, v2:SpiPoint):Void
	{
		v1.x -= v2.x;
		v1.y -= v2.y;
	}

	/**
	 * Multiplies the two vectors by a value.
	 * 
	 * @param v 		A SpiPoint instance.
	 * @param value 	The value to multiply the vector instance by.
	 */
	public static function multiplyByValue(v:SpiPoint, value:Float):Void
	{
		v.x *= value;
		v.y *= value;
	}

	/**
	 * Multiplies the two vectors by a value.
	 * 
	 * @param v1 		A SpiPoint instance.
	 * @param v2	 	Another SpiPoint instance.
	 */
	public static function multiply(v1:SpiPoint, v2:SpiPoint):Void
	{
		v1.x *= v2.x;
		v1.y *= v2.y;
	}

	/**
	 * Divides this vector by a value.
	 * 
	 * @param v			A SpiPoint instance.
	 * @param value 	The value to multiply the vector instance by.
	 */
	public static function divide(v:SpiPoint, value:Float):Void
	{
		v.x /= value;
		v.y /= value;
	}

	/**
	 * Brings the given vector's magnitude down to a 0-1 value so it can be used to constrain other vectors.
	 * 
	 * @param	v		A SpiPoint instance.
	 */
	public static function normalize(v:SpiPoint):Void
	{
		var vx:Float = v.x;
		var vy:Float = v.y;
		var len:Float = Math.sqrt((vx * vx) + (vy * vy));
		if (len > 0) {
			v.x /= len;
			v.y /= len;
		}
	}

// 	/**
// 	 * Ensures the length of the vector is no longer than the given value.
// 	 * 
// 	 * @param	v		A SpiPoint instance to truncate.
// 	 * @param	max		The maximum value this vector should be. If length is larger than max, it will be truncated to this value.
// 	 */
// 	public static void truncate(SpiPoint v, float max)
// 	{
// 		float vx = v.x;
// 		float vy = v.y;
// 		float cl = (float)Math.sqrt((vx * vx) + (vy * vy));
// 		float nl = Math.min(max, cl);
// 		float a = (float)Math.atan2(vy, vx);
// 		v.x = (float)Math.cos(a) * nl;
// 		v.y = (float)Math.sin(a) * nl;
// 	}

// 	/**
// 	 * Reverse the X and Y values of the point.
// 	 * 
// 	 * @param v			A SpiPoint instance to reverse.
// 	 */
// 	public static void reverse(SpiPoint v)
// 	{
// 		v.x = -v.x;
// 		v.y = -v.y;
// 	}

// 	/**
// 	 * Return the max of two floats.
// 	 * 
// 	 * @param a			The first float.
// 	 * @param b			The second float.
// 	 * @return			The maximum float.
// 	 */
// 	public static float max(final float a, final float b)
// 	{
// 		return a > b ? a : b;
// 	}

// 	/**
// 	 * Return the max of two integers.
// 	 * 
// 	 * @param a			The first integer.
// 	 * @param b			The second integer.
// 	 * @return			The maximum integer.
// 	 */
// 	public static int max(inline var a, inline var b)
// 	{
// 		return a > b ? a : b;
// 	}
	
	/**
	 * Calculate the distance between two points.
	 * 
	 * @param 	Point1		A SpiPoint object referring to the first location.
	 * @param 	Point2		A SpiPoint object referring to the second location.
	 * @return	The distance between the two points as a floating point Number object.
	 */
	public static function getDistance(Point1:SpiPoint, Point2:SpiPoint):Float
	{
		var dx:Float = Point1.x - Point2.x;
		var dy:Float = Point1.y - Point2.y;
		Point1.putWeak();
		Point2.putWeak();
		return vectorLength(dx, dy);
	}
	
// 	/**
// 	 * 
// 	 * @param a
// 	 * @param b
// 	 * @return
// 	 */
// 	public static Vector2 subtractVV(Vector2 a, Vector2 b)
// 	{
// 		return new Vector2(a.x - b.x, a.y - b.y);
// 	}

// 	/**
// 	 * Force a value into a range.
// 	 * 
// 	 * @param value		The desired value.
// 	 * @param min		The minimum value.
// 	 * @param max		The maximum value.
// 	 * @return			The value inside the range.
// 	 */
// 	public static float constrainRange(float value, float min, float max)
// 	{
// 		if (value > max) return max;
// 		else if (value < min) return min;
// 		else return value;
// 	}

/**
	 * Rotates a point in 2D space around another point by the given angle.
	 * 
	 * @param X The X coordinate of the point you want to rotate.
	 * @param Y The Y coordinate of the point you want to rotate.
	 * @param PivotX The X coordinate of the point you want to rotate around.
	 * @param PivotY The Y coordinate of the point you want to rotate around.
	 * @param Angle Rotate the point by this many degrees.
	 * @param Point Optional <code>SpiPoint</code> to store the results in.
	 * 
	 * @return A <code>SpiPoint</code> containing the coordinates of the rotated point.
	 */
	public static function rotatePoint(X:Float, Y:Float, PivotX:Float, PivotY:Float, Angle:Float, Point:SpiPoint = null):SpiPoint
	{
		var sin:Float = 0;
		var cos:Float = 0;
		var radians:Float = Angle * -0.017453293;
		while (radians < -3.14159265)
			radians += 6.28318531;
		while (radians > 3.14159265)
			radians = radians - 6.28318531;

		if (radians < 0) {
			sin = 1.27323954 * radians + 0.405284735 * radians * radians;
			if (sin < 0)
				sin = 0.225 * (sin * -sin - sin) + sin;
			else
				sin = 0.225 * (sin * sin - sin) + sin;
		} else {
			sin = 1.27323954 * radians - 0.405284735 * radians * radians;
			if (sin < 0)
				sin = 0.225 * (sin * -sin - sin) + sin;
			else
				sin = 0.225 * (sin * sin - sin) + sin;
		}

		radians += 1.57079632;
		if (radians > 3.14159265)
			radians = radians - 6.28318531;
		if (radians < 0) {
			cos = 1.27323954 * radians + 0.405284735 * radians * radians;
			if (cos < 0)
				cos = 0.225 * (cos * -cos - cos) + cos;
			else
				cos = 0.225 * (cos * cos - cos) + cos;
		} else {
			cos = 1.27323954 * radians - 0.405284735 * radians * radians;
			if (cos < 0)
				cos = 0.225 * (cos * -cos - cos) + cos;
			else
				cos = 0.225 * (cos * cos - cos) + cos;
		}

		var dx:Float = X - PivotX;
		var dy:Float = PivotY + Y; // Y axis is inverted in flash, normally this would be a subtract operation
		if (Point == null)
			Point = SpiPoint.get();
		Point.x = PivotX + cos * dx - sin * dy;
		Point.y = PivotY - sin * dx - cos * dy;
		return Point;
	}

	/**
	 * Calculates the angle between two points. 0 degrees points straight up.
	 * 
	 * @param Point1 The X coordinate of the point.
	 * @param Point2 The Y coordinate of the point.
	 * 
	 * @return The angle in degrees, between -180 and 180.
	 */
	public static function getAngle(Point1:SpiPoint, Point2:SpiPoint):Float
	{
		var x:Float = Point2.x - Point1.x;
		var y:Float = Point2.y - Point1.y;
		if ((x == 0) && (y == 0))
			return 0;
		var c1:Float = 3.14159265 * 0.25;
		var c2:Float = 3 * c1;
		var ay:Float = (y < 0) ? -y : y;
		var angle:Float = 0;
		if (x >= 0)
			angle = c1 - c1 * ((x - ay) / (x + ay));
		else
			angle = c2 - c1 * ((x + ay) / (ay - x));
		angle = ((y < 0) ? -angle : angle) * 57.2957796;
		if (angle > 90)
			angle = angle - 270;
		else
			angle += 90;
		return angle;
	}

	/**
	 * Calculate the absolute value of a number.
	 * 
	 * @param Value Any number.
	 * 
	 * @return The absolute value of that number.
	 */
	public static function abs(N:Float):Float
	{
		return (N >= 0.0) ? N : -N;
	}

	/**
	 * Round down to the next whole number. E.g. floor(1.7) == 1, and floor(-2.7) == -2.
	 * 
	 * @param Value Any number.
	 * 
	 * @return The rounded value of that number.
	 */
	public static function floor(N:Float):Int
	{
		var n:Int = Std.int(N);
		return (N > 0) ? (n) : ((n != N) ? (n - 1) : (n));
	}

	/**
	 * Round up to the next whole number. E.g. ceil(1.3) == 2, and ceil(-2.3) == -3.
	 * 
	 * @param Value Any number.
	 * 
	 * @return The rounded value of that number.
	 */
	public static function ceil(N:Float):Int
	{
		var n:Int = Std.int(N);
		return (N > 0) ? ((n != N) ? (n + 1) : (n)) : (n);
	}

	/**
	 * Round to the closest whole number. E.g. round(1.7) == 2, and round(-2.3) == -2.
	 * 
	 * @param Value Any number.
	 * 
	 * @return The rounded value of that number.
	 */
	public static function round(value:Float):Int
	{
		// If it is 0 we do not round.
		if (value == 0.0)
			return Std.int(value);

		return Std.int(value + ((value > 0) ? 0.5 : -0.5));
	}

	/**
	 * Figure out which number is smaller.
	 * 
	 * @param Number1 Any number.
	 * @param Number2 Any number.
	 * 
	 * @return The smaller of the two numbers.
	 */
	public static function min(Number1:Float, Number2:Float):Float
	{
		return (Number1 <= Number2) ? Number1 : Number2;
	}

	/**
	 * Figure out which number is larger.
	 * 
	 * @param Number1 Any number.
	 * @param Number2 Any number.
	 * 
	 * @return The larger of the two numbers.
	 */
	public static function max(Number1:Float, Number2):Float
	{
		return (Number1 >= Number2) ? Number1 : Number2;
	}
}