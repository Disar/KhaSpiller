package spiller;

import spiller.SpiBasic;
import spiller.SpiBasic.SpiType;
import spiller.SpiObject;
import spiller.util.SpiArrayUtil;
import spiller.util.SpiFactory;

/**
 * This is an organizational class that can update and render a bunch of <code>SpiBasic</code>s. NOTE: Although <code>SpiGroup</code> extends <code>SpiBasic</code>, it will not
 * automatically add itself to the global collisions quad tree, it will only add its members.
 * 
 * v1.2 Updated reflection stuff
 * v1.1 Added parameterization to the class
 * v1.0 Initial version
 * 
 * @version 1.2 - 02/07/2013
 * @author ratalaika / Ratalaika Games
 * @author Ka Wing Chin
 */
class SpiGroup extends SpiBasic
{
	/**
	 * Use with <code>sort()</code> to sort in ascending order.
	 */
	public static inline var ASCENDING:Int = -1;
	/**
	 * Use with <code>sort()</code> to sort in descending order.
	 */
	public static inline var DESCENDING:Int = 1;
	/**
	 * Array of all the <code>T</code>s that exist in this group.
	 */
	public var members:Array<SpiBasic>;
	/**
	 * Internal tracker for the maximum capacity of the group. Default is 0, or no max capacity.
	 */
	private var _maxSize:Int;
	/**
	 * Internal helper variable for recycling objects a la <code>SpiEmitter</code>.
	 */
	private var _marker:Int;
	/**
	 * Helper for sort.
	 */
	private var _sortIndex:String;
	/**
	 * Helper for sort.
	 */
	private var _sortOrder:Int;
	/**
	 * The sort handler.
	 */
	private var sortHandler:Int->SpiBasic->SpiBasic->Int = byY; 

	/**
	 * Initialize a new group with the given size.
	 * 
	 * @param MaxSize		The maximum size of the group.
	 */
	public function new(MaxSize:Int = 0)
	{
		super();
		members = new Array<SpiBasic>();
		_maxSize = MaxSize;
		_marker = 0;
		_sortIndex = null;
		type = SpiType.GROUP;
	}

	/**
	 * Override this function to handle any deleting or "shutdown" type operations you might need, such as removing traditional Flash children like Sprite objects.
	 */
	override
	public function destroy():Void
	{
		if (members != null) {
			var basic:SpiBasic;
			for(i in 0 ... members.length) {
				basic = members[i];
				if (basic != null)
					basic.destroy();
			}
			members = null;
		}
		_sortIndex = null;
		super.destroy();
	}

	/**
	 * Just making sure we don't increment the active objects count.
	 */
	override
	public function preUpdate():Void
	{
	}

	/**
	 * Automatically goes through and calls update on everything you added.
	 */
	override
	public function update():Void
	{
		var basic:SpiBasic;
		var i:Int = 0;
		while (i < members.length) {
			basic = members[i++];
			if ((basic != null) && basic.exists && basic.active) {
				basic.preUpdate();
				basic.update();
				if (basic.hasTween()) {
					basic.updateTweens();
				}

				basic.postUpdate();
			}
		}

		if (hasTween()) {
			updateTweens();
		}
	}

	/**
	 * Destroy the dead objects.
	 * 
	 * @param splice Whether the object should be cut from the array entirely or not.
	 */
	public function destroyDead(splice:Bool = true):Void
	{
		if (members != null) {
			var basic:SpiBasic;
			for(i in 0 ... members.length) {
				basic = members[i];
				if (basic != null && !basic.alive) {
					remove(basic, splice);
					basic.destroy();
				}
			}
		}
	}

	/**
	 * Remove all instances of <code>T</code> subclass (SpiSprite, SpiBlock, etc) from the list. The secureClear() destroy() and kill() the objects!
	 */
	public function secureClear():Void
	{
		var basic:SpiBasic;
		var i:Int = 0;
		while (i < members.length) {
			basic = members[i++];
			if (basic != null) {
				if (basic.type == SpiType.GROUP) {
					cast(basic, SpiGroup).secureClear();
					cast(basic, SpiGroup).kill();
					cast(basic, SpiGroup).destroy();
				} else {
					basic.kill();
					basic.destroy();
				}
			}
		}
		members.splice(0, members.length);
	}

	/**
	 * Automatically goes through and calls render on everything you added.
	 */
	override
	public function draw():Void
	{
		var basic:SpiBasic;
		var i:Int = 0;
		while (i < members.length) {
			basic = members[i++];
			if ((basic != null) && basic.exists && basic.visible)
				basic.draw();
		}
	}

	/**
	 * The maximum capacity of this group. Default is 0, meaning no max capacity, and the group can just grow.
	 */
	public function getMaxSize():Int
	{
		return _maxSize;
	}

	/**
	 * @private
	 */
	public function setMaxSize(Size:Int):Void
	{
		_maxSize = Size;
		if (_marker >= _maxSize)
			_marker = 0;
		if ((_maxSize == 0) || (members == null) || (_maxSize >= members.length))
			return;

		// If the max size has shrunk, we need to get rid of some objects
		var basic:SpiBasic;
		var i:Int = _maxSize;
		var l:Int = members.length;
		while (i < l) {
			basic = members.pop();
			if (basic != null)
				basic.destroy();
			++i;
		}
		SpiArrayUtil.setLength(members, _maxSize);
	}

	/**
	 * Adds a new <code>T</code> subclass (SpiBasic , SpiSprite, Enemy, etc) to the group. SpiGroup will try to replace a null member of the array first. Failing that,
	 * SpiGroup will add it to the end of the member array, assuming there is room for it, and doubling the size of the array if necessary.
	 * 
	 * <p>
	 * WARNING: If the group has a maxSize that has already been met, the object will NOT be added to the group!
	 * </p>
	 * 
	 * @param Object The object you want to add to the group.
	 * 
	 * @return The same <code>T</code> object that was passed in.
	 */
	public function add(Object:SpiBasic):SpiBasic
	{
		// Don't bother adding an object twice.
		if (members.indexOf(Object) >= 0)
			return Object;

		// First, look for a null entry where we can add the object.
		var i:Int = 0;
		var l:Int = members.length;
		while (i < l) {
			if (members[i] == null) {
				members[i] = Object;
				return Object;
			}
			i++;
		}

		// Failing that, expand the array (if we can) and add the object.
		if (_maxSize > 0) {
			if (members.length >= _maxSize)
				return Object;
		}

		// If we made it this far, then we successfully grew the group,
		// and we can go ahead and add the object at the first open slot.
		members.push(Object);
		return Object;
	}

/**
	 * Recycling is designed to help you reuse game objects without always re-allocating or "newing" them.
	 * 
	 * <p>
	 * If you specified a maximum size for this group (like in SpiEmitter), then recycle will employ what we're calling "rotating" recycling. Recycle() will first check to see if
	 * the group is at capacity yet. If group is not yet at capacity, recycle() returns a new object. If the group IS at capacity, then recycle() just returns the next object in
	 * line.
	 * </p>
	 * 
	 * <p>
	 * If you did NOT specify a maximum size for this group, then recycle() will employ what we're calling "grow-style" recycling. Recycle() will return either the first object
	 * with exists == false, or, finding none, add a new object to the array, doubling the size of the array if necessary.
	 * </p>
	 * 
	 * <p>
	 * WARNING: If this function needs to create a new object, and no object class was provided, it will return null instead of a valid object!
	 * </p>
	 * 
	 * @param ObjectClass The class type you want to recycle (e.g. SpiSprite, EvilRobot, etc). Do NOT "new" the class in the parameter!
	 * 
	 * @return A reference to the object that was created. Don't forget to cast it back to the Class you want (e.g. myObject = myGroup.recycle(myObjectClass) as myObjectClass;).
	 */
	public function recycle(ObjectType:SpiType = SpiType.NONE):SpiBasic
	{
		var basic:SpiBasic;
		if (_maxSize > 0) {
			if (members.length < _maxSize) {
				if (ObjectType == SpiType.NONE)
					return null;
				return add(SpiFactory.create(ObjectType));
			} else {
				basic = members[_marker++];
				if (_marker >= _maxSize)
					_marker = 0;
				return basic;
			}
		} else {
			basic = getFirstAvailable(ObjectType);
			if (basic != null)
				return basic;
			if (ObjectType == SpiType.NONE)
				return null;
			return add(SpiFactory.create(ObjectType));
		}
	}

	#if SPI_REFLECTION
	/**
	 * Recycling is designed to help you reuse game objects without always re-allocating or "newing" them.
	 * 
	 * <p>
	 * If you specified a maximum size for this group (like in SpiEmitter), then recycle will employ what we're calling "rotating" recycling. Recycle() will first check to see if
	 * the group is at capacity yet. If group is not yet at capacity, recycle() returns a new object. If the group IS at capacity, then recycle() just returns the next object in
	 * line.
	 * </p>
	 * 
	 * <p>
	 * If you did NOT specify a maximum size for this group, then recycle() will employ what we're calling "grow-style" recycling. Recycle() will return either the first object
	 * with exists == false, or, finding none, add a new object to the array, doubling the size of the array if necessary.
	 * </p>
	 * 
	 * <p>
	 * WARNING: If this function needs to create a new object, and no object class was provided, it will return null instead of a valid object!
	 * </p>
	 * 
	 * @param ObjectClass The class type you want to recycle (e.g. SpiSprite, EvilRobot, etc). Do NOT "new" the class in the parameter!
	 * 
	 * @return A reference to the object that was created. Don't forget to cast it back to the Class you want (e.g. myObject = myGroup.recycle(myObjectClass) as myObjectClass;).
	 */
	public function recycleByClass(ObjectClass:Class<SpiBasic> = null):SpiBasic
	{
		var basic:SpiBasic;
		if (_maxSize > 0) {
			if (members.length < _maxSize) {
				if (ObjectClass == null)
					return null;
				return add(Type.createInstance(ObjectClass, []));
			} else {
				basic = members[_marker++];
				if (_marker >= _maxSize)
					_marker = 0;
				return basic;
			}
		} else {
			basic = getFirstAvailableByClass(ObjectClass);
			if (basic != null)
				return basic;
			if (ObjectClass == null)
				return null;
			return add(Type.createInstance(ObjectClass, []));
		}
	}
	#end

	/**
	 * Removes an object from the group.
	 * 
	 * @param Object The <code>T</code> you want to remove.
	 * @param Splice Whether the object should be cut from the array entirely or not.
	 * 
	 * @return The removed object.
	 */
	public function remove(Object:SpiBasic, Splice:Bool = false):SpiBasic
	{
		var index:Int = members.indexOf(Object);
		if ((index < 0) || (index >= members.length))
			return null;
		if (Splice) {
			members.splice(index, 1);
		} else
			members[index] = null;
		return Object;
	}

	/**
	 * Replaces an existing <code>T</code> with a new one.
	 * 
	 * @param OldObject The object you want to replace.
	 * @param NewObject The new object you want to use instead.
	 * 
	 * @return The new object.
	 */
	public function replace(OldObject:SpiBasic, NewObject:SpiBasic):SpiBasic
	{
		var index:Int = members.indexOf(OldObject);
		if ((index < 0) || (index >= members.length))
			return null;
		members[index] = NewObject;
		return NewObject;
	}

	/**
	 * Call this function to sort the group according to a particular value and order. For example, to sort game objects for Zelda-style overlaps you might call
	 * <code>myGroup.sort("y",ASCENDING)</code> at the bottom of your <code>SpiState.update()</code> override. To sort all existing objects after a big explosion or bomb attack,
	 * you might call <code>myGroup.sort("exists",DESCENDING)</code>.
	 * 
	 * @param Index The <code>String</code> name of the member variable you want to sort on. Default value is "y".
	 * @param Order A <code>SpiGroup</code> constant that defines the sort order. Possible values are <code>ASCENDING</code> and <code>DESCENDING</code>. Default value is
	 *            <code>ASCENDING</code>.
	 */
	public function sort(Index:String = "y", Order:Int = ASCENDING):Void
	{
		_sortIndex = Index;
		_sortOrder = Order;
		members.sort(sortHandler.bind(_sortOrder));
	}

	#if SPI_REFLECTION
	/**
	 * Go through and set the specified variable to the specified value on all members of the group.
	 * 
	 * @param VariableName The string representation of the variable name you want to modify, for example "visible" or "scrollFactor".
	 * @param Value The value you want to assign to that variable.
	 * @param Recurse Default value is true, meaning if <code>setAll()</code> encounters a member that is a group, it will call <code>setAll()</code> on that group rather than
	 *            modifying its variable.
	 */
	public function setAll(VariableName:String, Value:Dynamic, Recurse:Bool = true):Void
	{
		var basic:SpiBasic;
		var i:Int = 0;
		while (i < members.length) {
			basic = members[i++];
			if (basic != null) {
				if (Recurse && Std.is(basic, SpiGroup))
					cast(basic, SpiGroup).setAll(VariableName, Value, Recurse);
				else {
					Reflect.setProperty(basic, VariableName, Value);
				}
			}
		}
	}

	/**
	 * Go through and call the specified function on all members of the group. Currently only works on functions that have no required parameters.
	 * 
	 * @param FunctionName The string representation of the function you want to call on each object, for example "kill()" or "init()".
	 * @param Recurse Default value is true, meaning if <code>callAll()</code> encounters a member that is a group, it will call <code>callAll()</code> on that group rather than
	 *            calling the group's function.
	 */
	public function callAll(FunctionName:String, Recurse:Bool = true):Void
	{
		var basic:SpiBasic;
		var i:Int = 0;
		while (i < members.length) {
			basic = members[i++];
			if (basic != null) {
				if (Recurse && Std.is(basic, SpiGroup))
					cast(basic, SpiGroup).callAll(FunctionName, Recurse);
				else {
					Reflect.callMethod(basic, Reflect.field(basic, "FunctionName"), []);
				}
			}
		}
	}

	/**
	 * Call this function to retrieve the first object with exists == false in the group. This is handy for recycling in general, e.g. respawning enemies.
	 * 
	 * @param objectClass An optional parameter that lets you narrow the results to instances of this particular class.
	 * 
	 * @return A <code>T</code> currently flagged as not existing.
	 */
	public function getFirstAvailableByClass(objectClass:Class<SpiBasic> = null):SpiBasic
	{
		var basic:SpiBasic;
		var i:Int = 0;
		while (i < members.length) {
			basic = members[i++];
			if ((basic != null) && !basic.exists && ((objectClass == null) || (Std.is(basic, objectClass))))
				return basic;
		}
		return null;
	}
	#end

	/**
	 * Call this function to retrieve the first object with exists == false in the group. This is handy for recycling in general, e.g. respawning enemies.
	 * 
	 * @param objectClass An optional parameter that lets you narrow the results to instances of this particular class.
	 * 
	 * @return A <code>T</code> currently flagged as not existing.
	 */
	public function getFirstAvailable(objectType:SpiType = SpiType.NONE):SpiBasic
	{
		var basic:SpiBasic;
		var i:Int = 0;
		while (i < members.length) {
			basic = members[i++];
			if ((basic != null) && !basic.exists && ((objectType == SpiType.NONE) || (basic.type == objectType)))
				return basic;
		}
		return null;
	}

	/**
	 * Call this function to retrieve the first index set to 'null'. Returns -1 if no index stores a null object.
	 * 
	 * @return An <code>int</code> indicating the first null slot in the group.
	 */
	public function getFirstNull():Int
	{
		var i:Int = 0;
		var l:Int = members.length;
		while (i < l) {
			if (members[i] == null)
				return i;
			else
				i++;
		}
		return -1;
	}

	/**
	 * Call this function to retrieve the first object with exists == true in the group. This is handy for checking if everything's wiped out, or choosing a squad leader, etc.
	 * 
	 * @return A <code>T</code> currently flagged as existing.
	 */
	public function getFirstExtant():SpiBasic
	{
		var basic:SpiBasic;
		var i:Int = 0;
		while (i < members.length) {
			basic = members[i++];
			if ((basic != null) && basic.exists)
				return basic;
		}
		return null;
	}

	/**
	 * Call this function to retrieve the first object with dead == false in the group. This is handy for checking if everything's wiped out, or choosing a squad leader, etc.
	 * 
	 * @return A <code>T</code> currently flagged as not dead.
	 */
	public function getFirstAlive():SpiBasic
	{
		var basic:SpiBasic;
		var i:Int = 0;
		while (i < members.length) {
			basic = members[i++];
			if ((basic != null) && basic.exists && basic.alive)
				return basic;
		}
		return null;
	}
	
	/**
	 * Call this function to retrieve the first object with dead == true in the group. This is handy for checking if everything's wiped out, or choosing a squad leader, etc.
	 * 
	 * @return A <code>T</code> currently flagged as dead.
	 */
	public function getFirstDead(objectType:SpiType = SpiType.NONE):SpiBasic
	{
		var basic:SpiBasic;
		var i:Int = 0;
		while (i < members.length) {
			basic = members[i++];
			if ((basic != null) && !basic.alive && ((objectType == SpiType.NONE) || (basic.type == objectType)))
				return basic;
		}
		return null;
	}

	#if SPI_REFLECTION
	/**
	 * Call this function to retrieve the first object with dead == true in the group. This is handy for checking if everything's wiped out, or choosing a squad leader, etc.
	 * 
	 * @return A <code>T</code> currently flagged as dead.
	 */
	public function getFirstDeadByClass(objectClass:Class<SpiBasic> = null):SpiBasic
	{
		var basic:SpiBasic;
		var i:Int = 0;
		while (i < members.length) {
			basic = members[i++];
			if ((basic != null) && !basic.alive && ((objectClass == null) || (Std.is(basic, objectClass))))
				return basic;
		}
		return null;
	}
	#end

	/**
	 * Call this function to find out how many members of the group are not dead.
	 * 
	 * @return The number of <code>T</code>s flagged as not dead. Returns -1 if group is empty.
	 */
	public function countLiving():Int
	{
		var count:Int = -1;
		var basic:SpiBasic;
		var i:Int = 0;
		while (i < members.length) {
			basic = members[i++];
			if (basic != null) {
				if (basic.type == SpiType.GROUP) {
					if (count < 0)
						count = 0;
					count = count + cast(basic, SpiGroup).countLiving();
				} else {
					if (count < 0)
						count = 0;
					if (basic.exists && basic.alive)
						count++;
				}
			}
		}
		return count;
	}

	/**
	 * Call this function to find out how many members of the group are dead.
	 * 
	 * @return The number of <code>T</code>s flagged as dead. Returns -1 if group is empty.
	 */
	public function countDead():Int
	{
		var count:Int = -1;
		var basic:SpiBasic;
		var i:Int = 0;
		while (i < members.length) {
			basic = members[i++];
			if (basic != null) {
				if (basic.type == SpiType.GROUP) {
					if (count < 0)
						count = 0;
					count = count + cast(basic, SpiGroup).countDead();
				} else {
					if (count < 0)
						count = 0;
					if (!basic.alive)
						count++;
				}
			}
		}
		return count;
	}

	/**
	 * Returns a member at random from the group.
	 * 
	 * @param StartIndex Optional offset off the front of the array. Default value is 0, or the beginning of the array.
	 * @param length Optional restriction on the number of values you want to randomly select from.
	 * 
	 * @return A <code>T</code> from the members list.
	 */
	public function getRandom(StartIndex:Int = 0, length:Int = 0):SpiBasic
	{
		if (length == 0)
			length = members.length;
		return SpiG.random.getObject(members, StartIndex, length);
	}

	/**
	 * Remove all instances of <code>T</code> subclass (SpiSprite, SpiBlock, etc) from the list. WARNING: does not destroy() or kill() any of these objects!
	 */
	public function clear():Void
	{
		SpiArrayUtil.clearArray(members);
	}

	/**
	 * Calls kill on the group's members and then on the group itself.
	 */
	override
	public function kill():Void
	{
		var basic:SpiBasic;
		var i:Int = 0;
		while (i < members.length) {
			basic = members[i++];
			if ((basic != null) && basic.exists)
				basic.kill();
		}
		super.kill();
	}

	/**
	 * Returns the members.length of the group.
	 * 
	 * @return The members.length of the group.
	 */
	public function size():Int
	{
		return members.length;
	}

	/**
	 * Helper function for the sort process.
	 * 
	 * @param Obj1 The first object being sorted.
	 * @param Obj2 The second object being sorted.
	 * 
	 * @return An integer value: -1 (Obj1 before Obj2), 0 (same), or 1 (Obj1 after Obj2).
	/**
	 * You can use this function in SpiGroup.sort() to sort SpiObjects by their y values.
	 */
 	public static inline function byY(Order:Int, Obj1:SpiBasic, Obj2:SpiBasic):Int
	{
		if(Obj1.type == SpiType.OBJECT && Obj2.type == SpiType.OBJECT)
			return byValues(Order, cast(Obj1, SpiObject).y, cast(Obj2, SpiObject).y);
		return 0;
	}
	
	/**
	 * You can use this function as a backend to write a custom sorting function (see byY() for an example).
	 */
	public static inline function byValues(Order:Int, Value1:Float, Value2:Float):Int
	{
		var result:Int = 0;
		
		if (Value1 < Value2)
		{
			result = Order;
		}
		else if (Value1 > Value2)
		{
			result = -Order;
		}
		
		return result;
	}

}