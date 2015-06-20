package spiller.effects;

/**
 * This is a simple particle class that extends the default behavior<br>
 * of <code>SpiSprite</code> to have slightly more specialized behavior<br>
 * common to many game scenarios.  You can override and extend this class<br>
 * just like you would <code>SpiSprite</code>. While <code>SpiEmitter</code><br>
 * used to work with just any old sprite, it now requires a<br>
 * <code>SpiParticle</code> based class.<br>
 * <br>
 * v1.0 Initial version
 * 
 * @version 1.0 - 17/07/2013
 * @author ratalaika / Ratalaika Games
 * @author Ka Wing Chin
 */
class SpiParticle extends SpiSprite
{
	/**
	 * How long this particle lives before it disappears.
	 * NOTE: this is a maximum, not a minimum; the object
	 * could get recycled before its lifespan is up.
	 */
	public var lifespan:Float;
	/**
	 * Determines how quickly the particles come to rest on the ground.
	 * Only used if the particle has gravity-like acceleration applied.
	 * @default 500
	 */
	public var friction:Float;

	/**
	 * Instantiate a new particle.  Like <code>SpiSprite</code>, all meaningful creation
	 * happens during <code>loadGraphic()</code> or <code>makeGraphic()</code> or whatever.
	 */
	public function new()
	{
		super();
		lifespan = 0;
		friction = 500;
	}
	
	/**
	 * The particle's main update logic.  Basically it checks to see if it should
	 * be dead yet, and then has some special bounce behavior if there is some gravity on it.
	 */
	override
	public function update():Void
	{
		// Lifespan behavior
		if(lifespan <= 0)
			return;
		lifespan -= SpiG.elapsed;
		if(lifespan <= 0)
			kill();
		
		// Simpler bounce/spin behavior for now
		if(touching > 0) {
			if(angularVelocity != 0)
				angularVelocity = -angularVelocity;
		}
		
		// Special behavior for particles with gravity
		if(acceleration.y > 0) {
			if((touching & SpiObject.FLOOR) > 0) {
				drag.x = friction;
				
				if(!((touchingLastFrame & SpiObject.FLOOR) > 0)) {
					if(velocity.y < -elasticity*10) {
						if(angularVelocity != 0)
							angularVelocity *= -elasticity;
					} else {
						velocity.y = 0;
						angularVelocity = 0;
					}
				}
			} else
				drag.x = 0;
		}
	}
	
	/**
	 * Triggered whenever this object is launched by a <code>SpiEmitter</code>.
	 * You can override this to add custom behavior like a sound or AI or something.
	 */
	public function onEmit():Void
	{
	}
}
