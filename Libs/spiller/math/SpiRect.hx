package spiller.math;

import kha.Rectangle;

/**
 * Stores a rectangle.<br>
 * <br>
 * v1.0 Initial version
 * 
 * @version 1.0 - 17/07/2013
 * @author ratalaika / Ratalaika Games
 * @author	Ka Wing Chin
 */
class SpiRect
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
	 * The width of the rectangle.
	 */
	public var width:Float;
	/**
	 * The height of the rectangle.
	 */
	public var height:Float;

	/**
	 * Instantiate a new rectangle.
	 * 
	 * @param	X		The X-coordinate of the point in space.
	 * @param	Y		The Y-coordinate of the point in space.
	 * @param	Width	Desired width of the rectangle.
	 * @param	Height	Desired height of the rectangle.
	 */
	public function new(X:Float = 0, Y:Float = 0, Width:Float = 0, Height:Float = 0)
	{
		x = X;
		y = Y;
		width = Width;
		height = Height;
	}

	/**
	 * The X coordinate of the left side of the rectangle.  Read-only.
	 */
	public function getLeft():Float
	{
		return x;
	}
	
	/**
	 * The X coordinate of the right side of the rectangle.  Read-only.
	 */
	public function getRight():Float
	{
		return x + width;
	}
	
	/**
	 * The Y coordinate of the top of the rectangle.  Read-only.
	 */
	public function getTop():Float
	{
		return y;
	}
	
	/**
	 * The Y coordinate of the bottom of the rectangle.  Read-only.
	 */
	public function getBottom():Float
	{
		return y + height;
	}

	/**
	 * Instantiate a new rectangle.
	 * 
	 * @param	X		The X-coordinate of the point in space.
	 * @param	Y		The Y-coordinate of the point in space.
	 * @param	Width	Desired width of the rectangle.
	 * @param	Height	Desired height of the rectangle.
	 * 
	 * @return	A reference to itself.
	 */
	public function make(X:Float = 0, Y:Float = 0, Width:Float = 0, Height:Float = 0):SpiRect
	{
		x = X;
		y = Y;
		width = Width;
		height = Height;
		return this;
	}

	/**
	 * Helper function, just copies the values from the specified rectangle.
	 * 
	 * @param	Rect	Any <code>SpiRect</code>.
	 * 
	 * @return	A reference to itself.
	 */
	public function copyFrom(Rect:SpiRect):SpiRect
	{
		x = Rect.x;
		y = Rect.y;
		width = Rect.width;
		height = Rect.height;
		return this;
	}

	/**
	 * Helper function, just copies the values from this rectangle to the specified rectangle.
	 * 
	 * @param	Point	Any <code>SpiRect</code>.
	 * 
	 * @return	A reference to the altered rectangle parameter.
	 */
	public function copyTo(Rect:SpiRect):SpiRect
	{
		Rect.x = x;
		Rect.y = y;
		Rect.width = width;
		Rect.height = height;
		return Rect;
	}
	
	/**
	 * Helper function, just copies the values from the specified libgdx rectangle.
	 * 
	 * @param	FlashRect	Any <code>Rectangle</code>.
	 * 
	 * @return	A reference to itself.
	 */
	public function copyFromFlash(FlashRect:Rectangle):SpiRect
	{
		x = FlashRect.x;
		y = FlashRect.y;
		width = FlashRect.width;
		height = FlashRect.height;
		return this;
	}
	
	/**
	 * Helper function, just copies the values from this rectangle to the specified libgdx rectangle.
	 * 
	 * @param	Point	Any <code>Rectangle</code>.
	 * 
	 * @return	A reference to the altered rectangle parameter.
	 */
	public function copyToFlash(FlashRect:Rectangle):Rectangle
	{
		FlashRect.x = x;
		FlashRect.y = y;
		FlashRect.width = width;
		FlashRect.height = height;
		return FlashRect;
	}
	
	/**
	 * Checks to see if some <code>SpiRect</code> object overlaps this <code>SpiRect</code> object.
	 * 
	 * @param	Rect	The rectangle being tested.
	 * 
	 * @return	Whether or not the two rectangles overlap.
	 */
	public function overlaps(Rect:SpiRect):Bool
	{
		return (Rect.x + Rect.width > x) && 
				(Rect.x < x+width) && 
				(Rect.y + Rect.height > y) && 
				(Rect.y < y+height);
	}

	/**
	 * Check if the given coordinates are contained in the rectangle.
	 * 
	 * @param x			The X coordinate.
	 * @param y			The Y coordinate.
	 */
	public function contains(x:Float, y:Float):Bool
	{
		return (x > this.x) && (x < this.x + width) && (y > this.y) && (y < this.y + height);
	}

	/**
	 * Check if the given coordinates are contained in the rectangle.
	 * 
	 * @param point			The point with the coordinates.
	 */
	public function containsPoint(point:SpiPoint):Bool
	{
		return contains(point.x, point.y);
	}

	/**
	 * Check if the given rectangle is contained in the rectangle.
	 * 
	 * @param rect			The rectangle.
	 */
	public function containsRect(rect:SpiRect):Bool
	{
		return contains(rect.x, rect.y) && contains(rect.x + rect.width, rect.y + rect.height);
	}

	/**
	 * Returns the intersection of two rectangles.
	 * 
	 * @param toIntersect
	 * @return
	 */
	public function intersection(toIntersect:SpiRect):SpiRect
	{
		var containsTopLeft:Bool = containsPoint(SpiPoint.get(toIntersect.x, toIntersect.y));
		var containsBottomRight:Bool = containsPoint(SpiPoint.get(toIntersect.getRight(), toIntersect.getBottom()));

		if(containsTopLeft && containsBottomRight) {
			return new SpiRect().copyFrom(toIntersect);
		} else if(containsTopLeft) {
			return new SpiRect(x, y, getRight() - x, getBottom() - y);
		} else if(containsBottomRight) {
			return new SpiRect(x, y, getRight() - x, getBottom() - y);
		} else {
			return new SpiRect();
		}
	}

	/**
	 * Check if two rectangles intersect.
	 * 
	 * @param toIntersect
	 * @return
	 */
	public function intersects(toIntersect:SpiRect):Bool
	{
		return containsPoint(SpiPoint.get(toIntersect.x, toIntersect.y)) || containsPoint(SpiPoint.get(toIntersect.getRight(), toIntersect.getBottom()));
	}

	/**
	 * Check if the rectangle is empty.
	 * @return
	 */
	public function isEmpty():Bool
	{
		return width == 0.0 && height == 0.0;
	}

	/**
	 * Returns the values in a printable format.
	 * @return
	 */
	public function print():String
	{
		return ("(x: " + x +  ", y:" + y + ", w: " + width +  ", h:" + height + ")");
	}

	/**
	 * Adjusts the location of the rectangle object.
	 * 
	 * @param dx
	 * @param dy
	 */
	public function offset(dx:Float, dy:Float):Void
	{
		x += dx;
		y += dy;
	}
}