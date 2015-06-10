package spiller.math;

import kha.math.Vector2;
import spiller.math.SpiMath;
import spiller.util.SpiPool;
import spiller.util.interfaces.ISpiPoolable;
import spiller.SpiObject;

/**
 * Stores a 2D floating point coordinate.<br>
 * <br>
 * v1.2 Added new equals methods<br>
 * v1.1 Fixed the point ration<br>
 * v1.0 Initial version<br>
 * <br>
 * @version 1.2 - 28/03/2013
 * @author ratalaika / ratalaikaGames
 * @author Ka Wing Chin
 */
class SpiPoint implements ISpiPoolable
{
	/**
	 * Constant to convert degree angles into radial angles.
	 */
	public static var TO_RADIANS:Float = (1 / 180.0) * Math.PI;
	/**
	 * Constant to convert radial angles into degree angles.
	 */
	public static var TO_DEGREES:Float = (1 / Math.PI) * 180;
	/**
	 * The pool.
	 */
	private static var _pool:SpiPointPool = new SpiPointPool();

	/**
	 * Recycle or create a new SpiPoint. 
	 * Be sure to put() them back into the pool after you're done with them!
	 * 
	 * @param	X		The X-coordinate of the point in space.
	 * @param	Y		The Y-coordinate of the point in space.
	 * @return	This point.
	 */
	public static function get(X:Float = 0, Y:Float = 0):SpiPoint
	{
		var point:SpiPoint = _pool.getNew().set(X, Y);
		point._inPool = false;
		return point;
	}
	
	/**
	 * Recycle or create a new SpiPoint which will automatically be released 
	 * to the pool when passed into a spiller function.
	 * 
	 * @param	X		The X-coordinate of the point in space.
	 * @param	Y		The Y-coordinate of the point in space.
	 * @return	This point.
	 */
	public static function weak(X:Float = 0, Y:Float = 0):SpiPoint
	{
		var point:SpiPoint = get(X, Y);
		point._weak = true;
		return point;
	}
	
	/**
	 * The X coordinate of the point.
	 */
	public var x:Float;
	/**
	 * The Y coordinate of the point.
	 */
	public var y:Float;
	/**
	 * If the point is a weak reference.
	 */
	private var _weak:Bool = false;
	/**
	 * If the point is on the pool.
	 */
	private var _inPool:Bool = false;

	/**
	 * Instantiate a new point object.
	 * 
	 * @param X The X-coordinate of the point in space.
	 * @param Y The Y-coordinate of the point in space.
	 */
	private function new(X:Float = 0, Y:Float = 0)
	{
		x = X;
		y = Y;
	}

	/**
	 * Add this SpiPoint to the recycling pool.
	 */
	public function put():Void
	{
		if (!_inPool) {
			_inPool = true;
			_weak = false;
			_pool.dispose(this);
		}
	}
	
	/**
	 * Add this SpiPoint to the recycling pool if it's a weak reference (allocated via weak()).
	 */
	public function putWeak():Void
	{
		if (_weak) {
			put();
		}
	}
	
	/**
	 * Instantiate a new point object.
	 * 
	 * @param X The X-coordinate of the point in space.
	 * @param Y The Y-coordinate of the point in space.
	 */
	public function make(X:Float = 0, Y:Float = 0):SpiPoint
	{
		x = X;
		y = Y;
		return this;
	}
	
	/**
	 * Helper function, just copies the values from the specified point.
	 * 
	 * @param Point Any <code>SpiPoint</code>.
	 * 
	 * @return A reference to itself.
	 */
	public function copyFrom(point:SpiPoint):SpiPoint
	{
		if(point != null) {
			x = point.x;
			y = point.y;
		}
		return this;
	}

	/**
	 * Helper function, just copies the values from this point to the specified point.
	 * 
	 * @param Point Any <code>SpiPoint</code>.
	 * 
	 * @return A reference to the altered point parameter.
	 */
	public function copyTo(point:SpiPoint):SpiPoint
	{
		if (point == null) {
			point = SpiPoint.get();
		}
		
		point.x = x;
		point.y = y;
		return point;
	}

	/**
	 * Helper function, just copies the values from the specified libgdx vector.
	 * 
	 * @param Point Any <code>Point</code>.
	 * 
	 * @return A reference to itself.
	 */
	public function copyFromFlash(FlashPoint:Vector2):SpiPoint
	{
		x = FlashPoint.x;
		y = FlashPoint.y;
		return this;
	}

	/**
	 * Helper function, just copies the values from this point to the specified libgdx vector.
	 * 
	 * @param Point Any <code>Point</code>.
	 * 
	 * @return A reference to the altered point parameter.
	 */
	public function copyToFlash(FlashPoint:Vector2):Vector2
	{
		FlashPoint.x = x;
		FlashPoint.y = y;
		return FlashPoint;
	}

	/**
	 * This method add to its coordinates the X and Y values passed.
	 * 
	 * @param x The X coordinate.
	 * @param y The Y coordinate.
	 * @return The vector itself.
	 */
	public function add(x:Float, y:Float):SpiPoint
	{
		this.x += x;
		this.y += y;
		return this;
	}

	/**
	 * This method add to its coordinates the vector passed coordinates.
	 * 
	 * @param other The vector to add with.
	 * @return The vector itself.
	 */
	public function addPoint(other:SpiPoint):SpiPoint
	{
		x += other.x;
		y += other.y;
		other.putWeak();
		return this;
	}

	/**
	 * This method sub to its coordinates the X and Y values passed.
	 * 
	 * @param x The X coordinate.
	 * @param y The Y coordinate.
	 * @return The vector itself.
	 */
	public function subtract(x:Float, y:Float):SpiPoint
	{
		this.x -= x;
		this.y -= y;
		return this;
	}

	/**
	 * This method sub to its coordinates the vector passed coordinates.
	 * 
	 * @param other The vector to sub with.
	 * @return The vector itself.
	 */
	public function subtractPoint(other:SpiPoint):SpiPoint
	{
		x -= other.x;
		y -= other.y;
		other.putWeak();
		return this;
	}

	/**
	 * This method multiply a vector for a scalar value.
	 * 
	 * @param scalar The scalar number we want to multiply with.
	 * @return The vector itself.
	 */
	public function mul(scalar:Float):SpiPoint
	{
		x *= scalar;
		y *= scalar;
		return this;
	}

	/**
	 * This method calculates the length of the vector.
	 * 
	 * @return The length of the vector.
	 */
	public function length():Float
	{
		return Math.sqrt(x * x + y * y);
	}

	/**
	 * This method calculates the length of the vector squared.
	 * 
	 * @return The length of the vector.
	 */
	public function lengthSquared():Float
	{
		return x * x + y * y;
	}
	
	/**
	 * This method normalizes the vector to unit length.
	 * 
	 * @return The vector itself.
	 */
	public function normalize():SpiPoint
	{
		var length:Float = length();
		if (length != 0) {
			x /= length;
			y /= length;
		}
		return this;
	}

	/**
	 * This method normalizes the vector to unit length.
	 * 
	 * @param length The length to normalize with.
	 * @return The vector itself.
	 */
	public function normalizeWithScale(scale:Float):SpiPoint
	{
		var length:Float = length();

		if (0.0 != length) {
			x = x / length * scale;
			y = y / length * scale;
		}

		return this;
	}

	/**
	 * This method calculates the angle between the X and Y coordinates.
	 * 
	 * @return The angle between X and Y.
	 */
	public function angle():Float
	{
		var angle:Float = Math.atan2(y, x) * TO_DEGREES;
		if (angle < 0)
			angle += 360;
		return angle;
	}

	/**
	 * This method calculates the angle between the vector and the given vector.
	 * 
	 * @return The angle between X and Y.
	 */
	public function anglePoint(other:SpiPoint):Float
	{
		var aux:SpiPoint = copyFrom(this);
		aux.subtractPoint(other);
		return aux.angle();
	}

	/**
	 * This method rotates the vector X coordinate by a given amount of angles.
	 * 
	 * @param angle The amount we want to rotate the angle.
	 * @return The vector itself.
	 */
	public function rotateX(angle:Float):SpiPoint
	{
		var rad:Float = angle * TO_RADIANS;
		var cos:Float = Math.cos(rad);
		var sin:Float = Math.sin(rad);
		var newX:Float = x * cos - y * sin;
		x = newX;
		return this;
	}

	/**
	 * This method rotates the vector Y coordinate by a given amount of angles.
	 * 
	 * @param angle The amount we want to rotate the angle.
	 * @return The vector itself.
	 */
	public function rotateY(angle:Float):SpiPoint
	{
		var rad:Float = angle * TO_RADIANS;
		var cos:Float = Math.cos(rad);
		var sin:Float = Math.sin(rad);
		var newY:Float = x * sin + y * cos;
		y = newY;
		return this;
	}

	/**
	 * This method rotates the vector by a given amount of angles.
	 * 
	 * @param angle The amount we want to rotate the angle.
	 * @return The vector itself.
	 */
	public function rotate(angle:Float):SpiPoint
	{
		var rad:Float = angle * TO_RADIANS;
		var cos:Float = Math.cos(rad);
		var sin:Float = Math.sin(rad);
		make(x * cos - y * sin, x * sin + y * cos);
		return this;
	}

	/**
	 * This method calculates the distance between the vector and the given vector.
	 * 
	 * @param other The vector to calculate the distance with.
	 * @return The distance.
	 */
	public function distToPoint(other:SpiPoint):Float
	{
		var distX:Float = x - other.x;
		var distY:Float = y - other.y;
		return Math.sqrt(distX * distX + distY * distY);
	}

	/**
	 * This method calculates the distance between the vector and (0, 0).
	 * 
	 * @return The distance.
	 */
	@:access(spiller.SpiObject)
	public function distToZero():Float
	{
		return distToPoint(SpiObject._pZero);
	}

	/**
	 * This method calculates the distance between the vector and the given coordinates.
	 * 
	 * @param x The X coordinate.
	 * @param y The Y coordinate.
	 * @return The distance.
	 */
	public function dist(X:Float, Y:Float):Float
	{
		var distX:Float = x - X;
		var distY:Float = y - Y;
		return Math.sqrt(distX * distX + distY * distY);
	}

	/**
	 * This method calculates the distance between the vector and other vector. This method returns the distance Squared.
	 * 
	 * @param other The vector to calculate the distance with.
	 * @return The distance squared.
	 */
	public function distSquaredToPoint(other:SpiPoint):Float
	{
		var distX:Float = x - other.x;
		var distY:Float = y - other.y;
		return distX * distX + distY * distY;
	}

	/**
	 * This method calculates the distance between the vector and the given X and Y coordinates. This method returns the distance Squared.
	 * 
	 * @param x The X coordinate.
	 * @param y The Y coordinate.
	 * @return The distance squared.
	 */
	public function distSquared(X:Float, Y:Float):Float
	{
		var distX:Float = x - X;
		var distY = y - Y;
		return distX * distX + distY * distY;
	}

	/**
	 * Handy method to redirect the set to the copy method.
	 */
	public function setFromPoint(localPoint:SpiPoint):SpiPoint
	{
		return copyFrom(localPoint);
	}

	/**
	 * Handy method to redirect the set to the make method.
	 */
	public function set(X:Float, Y:Float):SpiPoint
	{
		return make(X, Y);
	}
	
	/**
	 * Returns true if this point is within the given rectangular block
	 * 
	 * @param	RectX		The X value of the region to test within
	 * @param	RectY		The Y value of the region to test within
	 * @param	RectWidth	The width of the region to test within
	 * @param	RectHeight	The height of the region to test within
	 * @return	True if the point is within the region, otherwise false
	 */
	public function inCoords(RectX:Float, RectY:Float, RectWidth:Float, RectHeight:Float):Bool
	{
		return SpiMath.pointInCoordinates(x, y, RectX, RectY, RectWidth, RectHeight);
	}
	
	/**
	 * Returns true if this point is within the given rectangular block
	 * 
	 * @param	Rect	The SpiRect to test within
	 * @return	True if pointX/pointY is within the SpiRect, otherwise false
	 */
	public function inSpiRect(Rect:SpiRect):Bool
	{
		return SpiMath.pointInSpiRect(x, y, Rect);
	}
	
	/**
	 * Calculate the distance to another point.
	 * 
	 * @param 	AnotherPoint	A SpiPoint object to calculate the distance to.
	 * @return	The distance between the two points as a Float.
	 */
	public function distanceTo(AnotherPoint:SpiPoint):Float
	{
		return SpiMath.getDistance(this, AnotherPoint);
	}
	
	/**
	 * Rounds x and y using Math.floor()
	 */
	public function floor():SpiPoint
	{
		x = Math.floor(x);
		y = Math.floor(y);
		return this;
	}
	
	/**
	 * Rounds x and y using Math.ceil()
	 */
	public function ceil():SpiPoint
	{
		x = Math.ceil(x);
		y = Math.ceil(y);
		return this;
	}
	
	/**
	 * Rounds x and y using Math.round()
	 */
	public function round():SpiPoint
	{
		x = Math.round(x);
		y = Math.round(y);
		return this;
	}

	/**
	 * Returns the values in a printable format.
	 * 
	 * @return
	 */
	public function print():String
	{
		return "(" + x + ", " + y + ")";
	}
	
	/**
	 * Returns the values in a printable format.
	 * 
	 * @return
	 */
	public function toString():String
	{
		return "(" + x + ", " + y + ")";
	}

	/**
	 * Equals method for points.
	 */
	public function equalsToPoint(point:SpiPoint):Bool
	{
		return (point.x == x && point.y == y);
	}

	/**
	 * Equals method for points.
	 */
	public function equals(X:Float, Y:Float):Bool
	{
		return (X == x && Y == y);
	}

	/**
	 * Linear interpolation.
	 * 
	 * @param target		Target point.
	 * @param alpha			The alpha value.
	 * @return				This point.
	 */
	public function lerp(target:SpiPoint, alpha:Float):SpiPoint
	{
		var invAlpha:Float = 1.0 - alpha;
		this.x = (x * invAlpha) + (target.x * alpha);
		this.y = (y * invAlpha) + (target.y * alpha);
		return this;
	}

	/**
	 * {@inheritDoc}
	 */
	public function destroy():Void
	{
		// Do nothing
	}

	/**
	 * Return the pool status.
	 */
	public static function poolStatus():String
	{
	//	if(_pool == null)
			return "No Pool";
		//else
		//TOODO	return "Available: " + _pool.getAvailableItemCount() + " | Unrecycled: " + _pool.getUnrecycledItemCount();
	}
}

@:access(spiller.math.SpiPoint.new)
class SpiPointPool extends SpiPool<SpiPoint>
{
	override
	public function create():SpiPoint
	{
		return new SpiPoint();
	}
}