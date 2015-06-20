package spiller.system.time;

import spiller.SpiBasic;

/**
 * A simple manager for tracking and updating game timer objects.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 25/04/2013
 * @author ratalaika / Ratalaika Games
 * @author	Ka Wing Chin
 */
class SpiTimerManager extends SpiBasic
{
	/**
	 * An array with all the timers.
	 */
	private var _timers:Array<SpiTimer>;

	/**
	 * Instantiates a new timer manager.
	 */
	public function new()
	{
		super();
		_timers = new Array<SpiTimer>();
		visible = false; //don't call draw on this plugin
	}

	/**
	 * Overridden destroy method.
	 */
	override
	public function destroy():Void
	{
		clear();
		_timers = null;
		super.destroy();
	}

	/**
	 * Called by <code>SpiG.updatePlugins()</code> before the game state has been updated.
	 * Cycles through timers and calls <code>update()</code> on each one.
	 */
	override
	public function update():Void
	{
		var i:Int = _timers.length - 1;
		var timer:SpiTimer;
		while(i >= 0)
		{
			timer = _timers[i--];
			if((timer != null) && !timer.paused && !timer.finished && (timer.time > 0))
				timer.update();
		}
	}

	/**
	 * Add a new timer to the timer manager.
	 * Usually called automatically by <code>SpiTimer</code>'s constructor.
	 * 
	 * @param	Timer	The <code>SpiTimer</code> you want to add to the manager.
	 */
	public function add(Timer:SpiTimer):Void
	{
		_timers.push(Timer);
	}

	/**
	 * Remove a timer from the timer manager.
	 * Usually called automatically by <code>SpiTimer</code>'s <code>stop()</code> function.
	 * 
	 * @param	Timer	The <code>SpiTimer</code> you want to remove from the manager.
	 */
	public function remove(Timer:SpiTimer):Void
	{
		var index:Int = _timers.indexOf(Timer);
		if(index >= 0)
			_timers.splice(index, 1);
	}

	/**
	 * Removes all the timers from the timer manager.
	 */
	public function clear():Void
	{
		var i :Int = _timers.length - 1;
		var timer:SpiTimer;
		while(i >= 0)
		{
			timer = _timers[i--];
			if(timer != null)
				timer.destroy();
		}		
		_timers.splice(0, _timers.length);
	}
}
