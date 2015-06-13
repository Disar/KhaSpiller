package spiller.system.flash.media;

import spiller.system.flash.events.IEventDispatcher;

/**
 * A single interface for sound channels.
 * 
 * v1.0 Initial version<br>
 * <br>
 * @version 1.0 - 11/09/2014
 * @author ratalaika / Ratalaika Games
 * @author Thomas Weston
 */
interface SoundChannel extends IEventDispatcher
{
	/**
	 * The <code>SoundTransform</code> object assigned to the sound channel. A
	 * <code>SoundTransform</code> object includes properties for setting
	 * volume, panning, left speaker assignment, and right speaker assignment.
	 * 
	 * @param soundTransform The <code>SoundTransform</code> to set.
	 */
	public function setSoundTransform(soundTransform:SoundTransform):Void;

	/**
	 * The <code>SoundTransform</code> object assigned to the sound channel. A
	 * <code>SoundTransform</code> object includes properties for setting
	 * volume, panning, left speaker assignment, and right speaker assignment.
	 * 
	 * @return The <SoundTransform</code> object assigned to the sound channel.
	 */
	public function getSoundTransform():SoundTransform;

	/**
	 * Stops the sound playing in the channel.
	 */
	public function stop():Void;

	/**
	 * Pauses the sound playing in the channel.
	 */
	public function pause():Void;

	/**
	 * Resumes playing the sound in the channel.
	 */
	public function resume():Void;
}