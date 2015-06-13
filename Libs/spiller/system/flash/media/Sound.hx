package spiller.system.flash.media;

/**
 * This provides a single interface to libgdx's <code>Sound</code> and
 * <code>Music</code> classes.
 * 
 * v1.0 Initial version<br>
 * <br>
 * @version 1.0 - 11/09/2014
 * @author ratalaika / Ratalaika Games
 * @author Thomas Weston
 */
interface Sound
{
	/**
	 * Generates a new <code>SoundChannel</code> object to play back the sound.
	 * 
	 * @param startTime The initial position in milliseconds at which playback
	 *        should start.
	 * @param loops Defines the number of times a sound loops back to the
	 *        <code>startTime</code> value before the sound channel stops
	 *        playback.
	 * @param sndTransform The initial <code>SoundTransform</code> object
	 *        assigned to the sound channel.
	 * @return A <code>SoundChannel</code> object, which you use to control the
	 *         sound. This method returns null if you have no sound card or if
	 *         you run out of available sound channels. The maximum number of
	 *         sound channels available at once is 32.
	 */
	public function play(startTime:Float, loops:Int, sndTransform:SoundTransform):SoundChannel;
	/**
	 * Return the type of sound we have Music or Sound.
	 */
	public function getType():Int;
}
