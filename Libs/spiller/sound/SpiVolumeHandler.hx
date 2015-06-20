package spiller.sound;

/**
 * This class manages all the volume stuff of the spiller.
 * It could be use internally or extend it in order to create your own crazy hacks.
 *
 * v1.0 Initial version
 * 
 * @version 1.0 - 25/04/2013
 * @author ratalaika / Ratalaika Games
 */
class SpiVolumeHandler
{
	/**
	 * The volume of the music
	 */
	public var musicVolume:Float;
	/**
	 * The volume of the sounds
	 */
	public var soundVolume:Float;
	/**
	 * If we are muted or not
	 */
	public var mute:Bool;

	/**
	 * Class constructor.
	 */
	public function new()
	{
		musicVolume = 0.5;
		soundVolume = 0.5;
		mute = false;
	}
}