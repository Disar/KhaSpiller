package spiller;

/**
 * This is the basic game "state" object - e.g. in a simple game
 * you might have a menu state and a play state.<br>
 * It is for all intents and purpose a fancy SpiGroup.<br>
 * And really, it's not even that fancy.<br>
 * <br>
 * v1.0 Initial version
 * 
 * @version 1.0 - 17/07/2013
 * @author ratalaika / Ratalaika Games
 * @author Ka Wing Chin
 */
class SpiState extends SpiGroup
{
	/**
	 * Creates a new <code>SpiState</code> object.
	 */
	public function new()
	{
		super();
	}

	/**
	 * Override this function to set up your game state.
	 * This is where you create your groups and game objects and all that good stuff.
	 */
	public function create():Void
	{
		// Nothing to create initially
	}

	/**
	 * Override this function to do special pre-processing FX like motion blur.
	 * You can use scaling or blending modes or whatever you want against
	 * <code>SpiState.screen</code> to achieve all sorts of cool FX.
	 */
	public function preProcess():Void
	{
		// Nothing to pre-process initially.
	}

	/**
	 * This function collides <code>defaultGroup</code> against <code>defaultGroup</code>
	 * (basically everything you added to this state).
	 */
	public function collide()
	{
		SpiG.collide(this);
	}

	/**
	 * Override this function to do special post-processing FX like light bloom.
	 * You can use scaling or blending modes or whatever you want against
	 * <code>SpiState.screen</code> to achieve all sorts of cool FX.
	 */
	public function postProcess():Void
	{
		// Nothing to post process initially
	}
}