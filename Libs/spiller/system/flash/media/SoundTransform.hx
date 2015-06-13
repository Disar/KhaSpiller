package spiller.system.flash.media;

/**
 * The <code>SoundTransform</code> class contains properties for volume and
 * panning.
 * 
 * v1.0 Initial version<br>
 * <br>
 * @version 1.0 - 11/09/2014
 * @author ratalaika / Ratalaika Games
 * @author Thomas Weston
 */
class SoundTransform
{
	/**
	 * The left-to-right panning of the sound, ranging from -1 (full pan left)
	 * to 1 (full pan right). A value of 0 represents no panning (balanced
	 * center between right and left)
	 */
	public var pan:Float;
	/**
	 * The volume, ranging from 0 (silent) to 1 (full volume).
	 */
	public var volume:Float;
	/**
	 * The pitch multiplier, 1 == default, >1 == faster, <1 == slower, the value
	 * has to be between 0.5 and 2.0.
	 */
	public var pitch:Float;

	/**
	 * Creates a <code>SoundTransform</code> object.
	 * 
	 * @param vol			The volume, ranging from 0 (silent) to 1 (full volume).
	 * @param panning		The left-to-right panning of the sound, ranging from -1 (full pan left) to 1 (full pan right).
	 * 						A value of 0 represents no panning (balanced center between right and left).
	 * @param pitching		The pitch multiplier, 1 == default, >1 == faster, <1 == slower,
	 * 						the value has to be between 0.5and 2.0.
	 */
	public function new(vol:Float = 1, panning:Float = 0, pitching:Float = 1)
	{
		volume = vol;
		pan = panning;
		pitch = pitching;
	}
}
