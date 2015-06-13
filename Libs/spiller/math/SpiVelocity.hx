package spiller.math;

import spiller.SpiG;
import spiller.SpiObject;

/**
 * Sweet class to work with speed, points and angles!
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 25/04/2013
 * @author ratalaika / Ratalaika Games
 * @author Richard Davey / Photon Storm
 */
class SpiVelocity 
{
	// /**
	//  * Sets the source SpiSprite x/y velocity so it will move directly towards the destination SpiSprite at the speed given (in pixels per second)<br>
	//  * If you specify a maxTime then it will adjust the speed (over-writing what you set) so it arrives at the destination in that number of seconds.<br>
	//  * Timings are approximate due to the way Android timers work, and irrespective of SWF frame rate. Allow for a variance of +- 50ms.<br>
	//  * The source object doesn't stop moving automatically should it ever reach the destination coordinates.<br>
	//  * If you need the object to accelerate, see accelerateTowardsObject() instead
	//  * Note: Doesn't take into account acceleration, maxVelocity or drag (if you set drag or acceleration too high this object may not move at all)
	//  * 
	//  * @param	source		The SpiSprite on which the velocity will be set
	//  * @param	dest		The SpiSprite where the source object will move to
	//  * @param	speed		The speed it will move, in pixels per second (default is 60 pixels/sec)
	//  * @param	maxTime		Time given in milliseconds (1000 = 1 sec). If set the speed is adjusted so the source will arrive at destination in the given number of ms
	//  */
	// public static void moveTowardsObject(SpiSprite source, SpiSprite dest, float speed, float maxTime)
	// {
	// 	float a = angleBetween(source, dest);
		
	// 	if (maxTime > 0)
	// 	{
	// 		int d = distanceBetween(source, dest);
			
	// 		//	We know how many pixels we need to move, but how fast?
	// 		speed = d / (maxTime / 1000f);
	// 	}
		
	// 	source.velocity.x = (float) (Math.cos(a) * speed);
	// 	source.velocity.y = (float) (Math.sin(a) * speed);
	// }

	// /**
	//  * Sets the source SpiSprite x/y velocity so it will move directly towards the destination SpiSprite at the speed given (in pixels per second)<br>
	//  * If you specify a maxTime then it will adjust the speed (over-writing what you set) so it arrives at the destination in that number of seconds.<br>
	//  * Timings are approximate due to the way Android timers work, and irrespective of SWF frame rate. Allow for a variance of +- 50ms.<br>
	//  * The source object doesn't stop moving automatically should it ever reach the destination coordinates.<br>
	//  * If you need the object to accelerate, see accelerateTowardsObject() instead
	//  * Note: Doesn't take into account acceleration, maxVelocity or drag (if you set drag or acceleration too high this object may not move at all)
	//  * 
	//  * @param	source		The SpiSprite on which the velocity will be set
	//  * @param	dest		The SpiSprite where the source object will move to
	//  * @param	speed		The speed it will move, in pixels per second (default is 60 pixels/sec)
	//  */
	// public static void moveTowardsObject(SpiSprite source, SpiSprite dest, float speed)
	// {
	// 	moveTowardsObject(source, dest, speed, 0);
	// }

	// /**
	//  * Sets the source SpiSprite x/y velocity so it will move directly towards the destination SpiSprite at the speed given (in pixels per second)<br>
	//  * If you specify a maxTime then it will adjust the speed (over-writing what you set) so it arrives at the destination in that number of seconds.<br>
	//  * Timings are approximate due to the way Android timers work, and irrespective of SWF frame rate. Allow for a variance of +- 50ms.<br>
	//  * The source object doesn't stop moving automatically should it ever reach the destination coordinates.<br>
	//  * If you need the object to accelerate, see accelerateTowardsObject() instead
	//  * Note: Doesn't take into account acceleration, maxVelocity or drag (if you set drag or acceleration too high this object may not move at all)
	//  * 
	//  * @param	source		The SpiSprite on which the velocity will be set
	//  * @param	dest		The SpiSprite where the source object will move to
	//  */
	// public static void moveTowardsObject(SpiSprite source, SpiSprite dest)
	// {
	// 	moveTowardsObject(source, dest, 60, 0);
	// }
	
	// /**
	//  * Sets the x/y acceleration on the source SpiSprite so it will move towards the destination SpiSprite at the speed given (in pixels per second)<br>
	//  * You must give a maximum speed value, beyond which the SpiSprite won't go any faster.<br>
	//  * If you don't need acceleration look at moveTowardsObject() instead.
	//  * 
	//  * @param	source			The SpiSprite on which the acceleration will be set
	//  * @param	dest			The SpiSprite where the source object will move towards
	//  * @param	speed			The speed it will accelerate in pixels per second
	//  * @param	xSpeedMax		The maximum speed in pixels per second in which the sprite can move horizontally
	//  * @param	ySpeedMax		The maximum speed in pixels per second in which the sprite can move vertically
	//  */
	// public static void accelerateTowardsObject(SpiSprite source, SpiSprite dest, float speed, int xSpeedMax, int ySpeedMax)
	// {
	// 	float a = angleBetween(source, dest);
		
	// 	source.velocity.x = 0;
	// 	source.velocity.y = 0;
		
	// 	source.acceleration.x = (int)(Math.cos(a) * speed);
	// 	source.acceleration.y = (int)(Math.sin(a) * speed);
		
	// 	source.maxVelocity.x = xSpeedMax;
	// 	source.maxVelocity.y = ySpeedMax;
	// }
	
	// /**
	//  * Move the given SpiSprite towards the mouse pointer coordinates at a steady velocity
	//  * If you specify a maxTime then it will adjust the speed (over-writing what you set) so it arrives at the destination in that number of seconds.<br>
	//  * Timings are approximate due to the way Android timers work, and irrespective of SWF frame rate. Allow for a variance of +- 50ms.<br>
	//  * The source object doesn't stop moving automatically should it ever reach the destination coordinates.<br>
	//  * 
	//  * @param	source		The SpiSprite to move
	//  * @param	speed		The speed it will move, in pixels per second (default is 60 pixels/sec)
	//  * @param	maxTime		Time given in milliseconds (1000 = 1 sec). If set the speed is adjusted so the source will arrive at destination in the given number of ms
	//  */
	// public static void moveTowardsMouse(SpiSprite source, float speed, float maxTime)
	// {
	// 	float a = angleBetweenMouse(source);
		
	// 	if (maxTime > 0)
	// 	{
	// 		int d = distanceToTouch(source);
			
	// 		//	We know how many pixels we need to move, but how fast?
	// 		speed = d / (maxTime / 1000f);
	// 	}
		
	// 	source.velocity.x = (float) (Math.cos(a) * speed);
	// 	source.velocity.y = (float) (Math.sin(a) * speed);
	// }

	// /**
	//  * Move the given SpiSprite towards the mouse pointer coordinates at a steady velocity
	//  * If you specify a maxTime then it will adjust the speed (over-writing what you set) so it arrives at the destination in that number of seconds.<br>
	//  * Timings are approximate due to the way Android timers work, and irrespective of SWF frame rate. Allow for a variance of +- 50ms.<br>
	//  * The source object doesn't stop moving automatically should it ever reach the destination coordinates.<br>
	//  * 
	//  * @param	source		The SpiSprite to move
	//  * @param	speed		The speed it will move, in pixels per second (default is 60 pixels/sec)
	//  */
	// public static void moveTowardsMouse(SpiSprite source, float speed)
	// {
	// 	moveTowardsMouse(source, speed, 0);
	// }

	// /**
	//  * Move the given SpiSprite towards the mouse pointer coordinates at a steady velocity
	//  * If you specify a maxTime then it will adjust the speed (over-writing what you set) so it arrives at the destination in that number of seconds.<br>
	//  * Timings are approximate due to the way Android timers work, and irrespective of SWF frame rate. Allow for a variance of +- 50ms.<br>
	//  * The source object doesn't stop moving automatically should it ever reach the destination coordinates.<br>
	//  * 
	//  * @param	source		The SpiSprite to move
	//  */
	// public static void moveTowardsMouse(SpiSprite source)
	// {
	// 	moveTowardsMouse(source, 60, 0);
	// }
	
	// /**
	//  * Sets the x/y acceleration on the source SpiSprite so it will move towards the mouse coordinates at the speed given (in pixels per second)<br>
	//  * You must give a maximum speed value, beyond which the SpiSprite won't go any faster.<br>
	//  * If you don't need acceleration look at moveTowardsMouse() instead.
	//  * 
	//  * @param	source			The SpiSprite on which the acceleration will be set
	//  * @param	speed			The speed it will accelerate in pixels per second
	//  * @param	xSpeedMax		The maximum speed in pixels per second in which the sprite can move horizontally
	//  * @param	ySpeedMax		The maximum speed in pixels per second in which the sprite can move vertically
	//  */
	// public static void accelerateTowardsMouse(SpiSprite source, int speed, int xSpeedMax, int ySpeedMax)
	// {
	// 	float a = angleBetweenMouse(source);
		
	// 	source.velocity.x = 0;
	// 	source.velocity.y = 0;
		
	// 	source.acceleration.x = (int)(Math.cos(a) * speed);
	// 	source.acceleration.y = (int)(Math.sin(a) * speed);
		
	// 	source.maxVelocity.x = xSpeedMax;
	// 	source.maxVelocity.y = ySpeedMax;
	// }
	
	// /**
	//  * Sets the x/y velocity on the source SpiSprite so it will move towards the target coordinates at the speed given (in pixels per second)<br>
	//  * If you specify a maxTime then it will adjust the speed (over-writing what you set) so it arrives at the destination in that number of seconds.<br>
	//  * Timings are approximate due to the way Android timers work, and irrespective of SWF frame rate. Allow for a variance of +- 50ms.<br>
	//  * The source object doesn't stop moving automatically should it ever reach the destination coordinates.<br>
	//  * 
	//  * @param	source		The SpiSprite to move
	//  * @param	target		The SpiPoint coordinates to move the source SpiSprite towards
	//  * @param	speed		The speed it will move, in pixels per second (default is 60 pixels/sec)
	//  * @param	maxTime		Time given in milliseconds (1000 = 1 sec). If set the speed is adjusted so the source will arrive at destination in the given number of ms
	//  */
	// public static void moveTowardsPoint(SpiSprite source, SpiPoint target, float speed, float maxTime)
	// {
	// 	float a = angleBetweenPoint(source, target);
		
	// 	if (maxTime > 0)
	// 	{
	// 		int d = distanceToPoint(source, target);
			
	// 		//	We know how many pixels we need to move, but how fast?
	// 		speed = d / (maxTime / 1000f);
	// 	}
		
	// 	source.velocity.x = (float) (Math.cos(a) * speed);
	// 	source.velocity.y = (float) (Math.sin(a) * speed);
		
	// 	target.putWeak();
	// }

	// *
	//  * Sets the x/y velocity on the source SpiSprite so it will move towards the target coordinates at the speed given (in pixels per second)<br>
	//  * If you specify a maxTime then it will adjust the speed (over-writing what you set) so it arrives at the destination in that number of seconds.<br>
	//  * Timings are approximate due to the way Android timers work, and irrespective of SWF frame rate. Allow for a variance of +- 50ms.<br>
	//  * The source object doesn't stop moving automatically should it ever reach the destination coordinates.<br>
	//  * 
	//  * @param	source		The SpiSprite to move
	//  * @param	target		The SpiPoint coordinates to move the source SpiSprite towards
	//  * @param	speed		The speed it will move, in pixels per second (default is 60 pixels/sec)
	 
	// public static void moveTowardsPoint(SpiSprite source, SpiPoint target, float speed)
	// {
	// 	moveTowardsPoint(source, target, speed, 0);
	// }

	// /**
	//  * Sets the x/y velocity on the source SpiSprite so it will move towards the target coordinates at the speed given (in pixels per second)<br>
	//  * If you specify a maxTime then it will adjust the speed (over-writing what you set) so it arrives at the destination in that number of seconds.<br>
	//  * Timings are approximate due to the way Android timers work, and irrespective of SWF frame rate. Allow for a variance of +- 50ms.<br>
	//  * The source object doesn't stop moving automatically should it ever reach the destination coordinates.<br>
	//  * 
	//  * @param	source		The SpiSprite to move
	//  * @param	target		The SpiPoint coordinates to move the source SpiSprite towards
	//  */
	// public static void moveTowardsPoint(SpiSprite source, SpiPoint target)
	// {
	// 	moveTowardsPoint(source, target, 60, 0);
	// }
	
	// /**
	//  * Sets the x/y acceleration on the source SpiSprite so it will move towards the target coordinates at the speed given (in pixels per second)<br>
	//  * You must give a maximum speed value, beyond which the SpiSprite won't go any faster.<br>
	//  * If you don't need acceleration look at moveTowardsPoint() instead.
	//  * 
	//  * @param	source			The SpiSprite on which the acceleration will be set
	//  * @param	target			The SpiPoint coordinates to move the source SpiSprite towards
	//  * @param	speed			The speed it will accelerate in pixels per second
	//  * @param	xSpeedMax		The maximum speed in pixels per second in which the sprite can move horizontally
	//  * @param	ySpeedMax		The maximum speed in pixels per second in which the sprite can move vertically
	//  */
	// public static void accelerateTowardsPoint(SpiSprite source, SpiPoint target, int speed, int xSpeedMax, int ySpeedMax)
	// {
	// 	float a = angleBetweenPoint(source, target);
		
	// 	source.velocity.x = 0;
	// 	source.velocity.y = 0;
		
	// 	source.acceleration.x = (int)(Math.cos(a) * speed);
	// 	source.acceleration.y = (int)(Math.sin(a) * speed);
		
	// 	source.maxVelocity.x = xSpeedMax;
	// 	source.maxVelocity.y = ySpeedMax;
		
	// 	target.putWeak();
	// }
	
	// /**
	//  * Find the distance (in pixels, rounded) between two SpiSprites, taking their origin into account
	//  * 
	//  * @param	a	The first SpiSprite
	//  * @param	b	The second SpiSprite
	//  * @return	int	Distance (in pixels)
	//  */
	// public static int distanceBetween(SpiSprite a, SpiSprite b)
	// {
	// 	float dx = (a.x + a.origin.x) - (b.x + b.origin.x);
	// 	float dy = (a.y + a.origin.y) - (b.y + b.origin.y);
		
	// 	return (int)(SpiMath.vectorLength(dx, dy));
	// }
	
	// /**
	//  * Find the distance (in pixels, rounded) from an SpiSprite to the given SpiPoint, taking the source origin into account
	//  * 
	//  * @param	a		The first SpiSprite
	//  * @param	target	The SpiPoint
	//  * @return	int		Distance (in pixels)
	//  */
	// public static int distanceToPoint(SpiSprite a, SpiPoint target)
	// {
	// 	float dx = (a.x + a.origin.x) - (target.x);
	// 	float dy = (a.y + a.origin.y) - (target.y);
		
	// 	return (int)(SpiMath.vectorLength(dx, dy));
	// }
	
	// /**
	//  * Find the distance (in pixels, rounded) from the object x/y and the mouse x/y
	//  * 
	//  * @param	a	The SpiSprite to test against
	//  * @return	int	The distance between the given sprite and the mouse coordinates
	//  */
	// public static int distanceToTouch(SpiSprite a)
	// {
	// 	float dx = (a.x + a.origin.x) - SpiG.touch.x;
	// 	float dy = (a.y + a.origin.y) - SpiG.touch.y;
		
	// 	return (int)(SpiMath.vectorLength(dx, dy));
	// }
	
	// /**
	//  * Find the angle (in radians) between an SpiSprite and an SpiPoint. The source sprite takes its x/y and origin into account.
	//  * The angle is calculated in clockwise positive direction (down = 90 degrees positive, right = 0 degrees positive, up = 90 degrees negative)
	//  * 
	//  * @param	a			The SpiSprite to test from
	//  * @param	target		The SpiPoint to angle the SpiSprite towards
	//  * @param	asDegrees	If you need the value in degrees instead of radians, set to true
	//  * 
	//  * @return	Number The angle (in radians unless asDegrees is true)
	//  */
	// public static float angleBetweenPoint(SpiSprite a, SpiPoint target, boolean asDegrees)
 //    {
	// 	float dx = (target.x) - (a.x + a.origin.x);
	// 	float dy = (target.y) - (a.y + a.origin.y);
		
	// 	if (asDegrees) {
	// 		return SpiMath.asDegrees((float)Math.atan2(dy, dx));
	// 	} else {
	// 		return (float) Math.atan2(dy, dx);
	// 	}
 //    }

	// /**
	//  * Find the angle (in radians) between an SpiSprite and an SpiPoint. The source sprite takes its x/y and origin into account.
	//  * The angle is calculated in clockwise positive direction (down = 90 degrees positive, right = 0 degrees positive, up = 90 degrees negative)
	//  * 
	//  * @param	a			The SpiSprite to test from
	//  * @param	target		The SpiPoint to angle the SpiSprite towards
	//  * 
	//  * @return	Number The angle (in radians unless asDegrees is true)
	//  */
	// public static float angleBetweenPoint(SpiSprite a, SpiPoint target)
	// {
	// 	return angleBetweenPoint(a, target, false);
	// }
	
	// /**
	//  * Find the angle (in radians) between the two SpiSprite, taking their x/y and origin into account.
	//  * The angle is calculated in clockwise positive direction (down = 90 degrees positive, right = 0 degrees positive, up = 90 degrees negative)
	//  * 
	//  * @param	a			The SpiSprite to test from
	//  * @param	b			The SpiSprite to test to
	//  * @param	asDegrees	If you need the value in degrees instead of radians, set to true
	//  * 
	//  * @return	Number The angle (in radians unless asDegrees is true)
	//  */
	// public static float angleBetween(SpiSprite a, SpiSprite b, boolean asDegrees)
 //    {
	// 	float dx = (b.x + b.origin.x) - (a.x + a.origin.x);
	// 	float dy = (b.y + b.origin.y) - (a.y + a.origin.y);
		
	// 	if (asDegrees) {
	// 		return SpiMath.asDegrees((float)Math.atan2(dy, dx));
	// 	} else {
	// 		return (float) Math.atan2(dy, dx);
	// 	}
 //    }

	// /**
	//  * Find the angle (in radians) between the two SpiSprite, taking their x/y and origin into account.
	//  * The angle is calculated in clockwise positive direction (down = 90 degrees positive, right = 0 degrees positive, up = 90 degrees negative)
	//  * 
	//  * @param	a			The SpiSprite to test from
	//  * @param	b			The SpiSprite to test to
	//  * 
	//  * @return	Number The angle in radians.
	//  */
	// public static float angleBetween(SpiSprite a, SpiSprite b)
	// {
	// 	return angleBetween(a, b, false);
	// }
	
	// /**
	//  * Given the angle and speed calculate the velocity and return it as an SpiPoint
	//  * 
	//  * @param	angle	The angle (in degrees) calculated in clockwise positive direction (down = 90 degrees positive, right = 0 degrees positive, up = 90 degrees negative)
	//  * @param	speed	The speed it will move, in pixels per second sq
	//  * 
	//  * @return	An SpiPoint where SpiPoint.x contains the velocity x value and SpiPoint.y contains the velocity y value
	//  */
	// public static SpiPoint velocityFromAngle(float angle, int speed)
	// {
	// 	float a = SpiMath.asRadians(angle);
		
	// 	SpiPoint result = SpiPoint.get();
		
	// 	result.x = (int)(Math.cos(a) * speed);
	// 	result.y = (int)(Math.sin(a) * speed);
		
	// 	return result;
	// }
	
	// /**
	//  * Given the SpiSprite and speed calculate the velocity and return it as an ApiPoint based on the direction the sprite is facing
	//  * 
	//  * @param	parent	The SpiSprite to get the facing value from
	//  * @param	speed	The speed it will move, in pixels per second sq
	//  * 
	//  * @return	An SpiPoint where SpiPoint.x contains the velocity x value and SpiPoint.y contains the velocity y value
	//  */
	// public static SpiPoint velocityFromFacing(SpiSprite parent, int speed)
	// {
	// 	float a = 0.0f;
		
	// 	if (parent.getFacing() == SpiObject.LEFT)
	// 	{
	// 		a = SpiMath.asRadians(180);
	// 	} else if (parent.getFacing() == SpiObject.RIGHT) {
	// 		a = SpiMath.asRadians(0);
	// 	} else if (parent.getFacing() == SpiObject.UP) {
	// 		a = SpiMath.asRadians( -90);
	// 	} else if (parent.getFacing() == SpiObject.DOWN) {
	// 		a = SpiMath.asRadians(90);
	// 	}
		
	// 	SpiPoint result = SpiPoint.get();
		
	// 	result.x = (int)(Math.cos(a) * speed);
	// 	result.y = (int)(Math.sin(a) * speed);
		
	// 	return result;
	// }
	
	// /**
	//  * Find the angle (in radians) between an SpiSprite and the mouse, taking their x/y and origin into account.
	//  * The angle is calculated in clockwise positive direction (down = 90 degrees positive, right = 0 degrees positive, up = 90 degrees negative)
	//  * 
	//  * @param	a			The SpiObject to test from
	//  * @param	asDegrees	If you need the value in degrees instead of radians, set to true
	//  * 
	//  * @return	Number The angle (in radians unless asDegrees is true)
	//  */
	// public static float angleBetweenTouch(SpiSprite a, boolean asDegrees)
	// {
	// 	//	In order to get the angle between the object and mouse, we need the objects screen coordinates (rather than world coordinates)
	// 	SpiPoint p = a.getScreenXY();
		
	// 	float dx = SpiG.touch.x - p.x;
	// 	float dy = SpiG.touch.y - p.y;
		
	// 	if (asDegrees)
	// 	{
	// 		return SpiMath.asDegrees((float)Math.atan2(dy, dx));
	// 	} else 	{
	// 		return (float) Math.atan2(dy, dx);
	// 	}
	// }

	// /**
	//  * Find the angle (in radians) between an SpiSprite and the mouse, taking their x/y and origin into account.
	//  * The angle is calculated in clockwise positive direction (down = 90 degrees positive, right = 0 degrees positive, up = 90 degrees negative)
	//  * 
	//  * @param	a			The SpiObject to test from
	//  * 
	//  * @return	Number The angle (in radians unless asDegrees is true)
	//  */
	// public static float angleBetweenMouse(SpiSprite a)
	// {
	// 	return angleBetweenTouch(a, false);
	// }

	/**
	 * A tween-like function that takes a starting velocity and some other factors and returns an altered velocity.
	 * 
	 * @param Velocity Any component of velocity (e.g. 20).
	 * @param Acceleration Rate at which the velocity is changing.
	 * @param Drag Really kind of a deceleration, this is how much the velocity changes if Acceleration is not set.
	 * @param Max An absolute value cap for the velocity.
	 * @param elapsed The elapsed time in seconds that happen.
	 * 
	 * @return The altered Velocity value.
	 */
	public static function computeVelocity(Velocity : Float, Acceleration : Float = 0, Drag : Float = 0, Max : Float = 10000, elapsed : Float = -1):Float
	{
		if(elapsed == -1)
			elapsed = SpiG.elapsed;


		if (Acceleration != 0)
			Velocity += Acceleration * elapsed;
		else if (Drag != 0) {
			var drag:Float = Drag * elapsed;
			if (Velocity - drag > 0)
				Velocity -= drag;
			else if (Velocity + drag < 0)
				Velocity += drag;
			else
				Velocity = 0;
		}

		// Control the maximum and minimum speed
		if ((Velocity != 0) && (Max != 0)) {
			if (Velocity > Max)
				Velocity = Max;
			else if (Velocity < -Max)
				Velocity = -Max;
		}
		return Velocity;
	}
}
