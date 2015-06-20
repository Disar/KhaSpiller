package spiller.sound;

import spiller.system.flash.events.Event;
import spiller.system.flash.events.Listener;
import spiller.system.flash.media.Sound;
import spiller.system.flash.media.SoundChannel;
import spiller.system.flash.media.SoundTransform;

// import spiller.system.gdx.GdxMusic;
// import spiller.system.gdx.GdxSound;
import spiller.math.SpiPoint;
import spiller.math.SpiMath;
import spiller.util.SpiDestroyUtil;

/**
 * This is the universal spiller sound object, used for streaming, music, and sound effects.<br>
 * <br>
 * v1.0 Initial version
 * 
 * @version 1.0 - 26/04/2013
 * @author ratalaika / Ratalaika Games
 * @author Ka Wing Chin
 * @author Thomas Weston
 */
class SpiSound extends SpiBasic
{
	/**
	 * The ALL ID.
	 */
	public static inline var ALL:Int = 0;
	/**
	 * Automatically determine the type of file.
	 */
	static public inline var AUTO:Int = 0;
	/**
	 * A short audio clip.
	 */
	static public inline var SFX:Int = 1;
	/**
	 * A large music file.
	 */
	static public inline var MUSIC:Int = 2;

	/**
	 * The X position of this sound in world coordinates. Only really matters if
	 * you are doing proximity/panning stuff.
	 */
	public var x:Float;
	/**
	 * The Y position of this sound in world coordinates. Only really matters if
	 * you are doing proximity/panning stuff.
	 */
	public var y:Float;
	/**
	 * Whether or not this sound should be automatically destroyed when you
	 * switch states.
	 */
	public var survive:Bool;
	/**
	 * The ID3 song name. Defaults to null. Currently only works for streamed
	 * sounds.
	 */
	public var name:String;
	/**
	 * The ID3 artist name. Defaults to null. Currently only works for streamed
	 * sounds.
	 */
	public var artist:String;
	/**
	 * Stores the average wave amplitude of both stereo channels
	 */
	public var amplitude:Float;
	/**
	 * Just the amplitude of the left stereo channel
	 */
	public var amplitudeLeft:Float;
	/**
	 * Just the amplitude of the left stereo channel
	 */
	public var amplitudeRight:Float;
	/**
	 * Whether to call destroy() when the sound has finished.
	 */
	public var autoDestroy:Bool;

	/**
	 * Internal tracker for a Flash sound object.
	 */
	private var _sound:Sound;
	/**
	 * Internal tracker for a Flash sound channel object.
	 */
	private var _channel:SoundChannel;
	/**
	 * Internal tracker for a Flash sound transform object.
	 */
	private var _transform:SoundTransform;
	/**
	 * Internal tracker for the position in runtime of the music playback.
	 */
	private var _position:Int;
	/**
	 * Internal tracker for how loud the sound is.
	 */
	private var _volume:Float;
	/**
	 * Internal tracker for total volume adjustment.
	 */
	private var _volumeAdjust:Float;
	/**
	 * Internal tracker for how fast or how slow the sound is.
	 */
	private var _pitch:Float;
	/**
	 * Internal tracker for whether the sound is looping or not.
	 */
	private var _looped:Bool;
	/**
	 * Internal tracker for whether the sound is paused by focus lost.
	 */
	private var _isPausedOnFocusLost:Bool;
	/**
	 * Internal tracker for the sound's "target" (for proximity and panning).
	 */
	private var _target:SpiObject;
	/**
	 * Internal tracker for the maximum effective radius of this sound (for
	 * proximity and panning).
	 */
	private var _radius:Float;
	/**
	 * Internal tracker for whether to pan the sound left and right. Default is
	 * false.
	 */
	private var _pan:Bool;
	/**
	 * Internal timer used to keep track of requests to fade out the sound
	 * playback.
	 */
	private var _fadeOutTimer:Float;
	/**
	 * Internal helper for fading out sounds.
	 */
	private var _fadeOutTotal:Float;
	/**
	 * Internal flag for whether to pause or stop the sound when it's done
	 * fading out.
	 */
	private var _pauseOnFadeOut:Bool;
	/**
	 * Internal timer for fading in the sound playback.
	 */
	private var _fadeInTimer:Float;
	/**
	 * Internal helper for fading in sounds.
	 */
	private var _fadeInTotal:Float;
	/**
	 * Internal, cache for distance based volume.
	 */
	private var _radial:Float;
	/**
	 * Internal, cache for fade out the sound.
	 */
	private var _fade:Float;
	/**
	 * Internal, calculates the distance-based volume control for this first
	 * point.
	 */
	private var _distance1:SpiPoint;
	/**
	 * Internal, calculates the distance-based volume control for the second
	 * point.
	 */
	private var _distance2:SpiPoint;

	/**
	 * The SpiSound constructor gets all the variables initialized, but NOT
	 * ready to play a sound yet.
	 */
	public function new()
	{
		super();
		createSound();
	}

	/**
	 * An internal function for clearing all the variables used by sounds.
	 */
	private function createSound():Void
	{
		destroy();
		x = 0;
		y = 0;
		if(_transform == null)
			_transform = new SoundTransform();
		_transform.pan = 0;
		_sound = null;
		_position = 0;
		_volume = 1.0;
		_volumeAdjust = 1.0;
		_pitch = 1.0;
		_looped = false;
		_target = null;
		_radius = 0;
		_pan = false;
		_fadeOutTimer = 0;
		_fadeOutTotal = 0;
		_pauseOnFadeOut = false;
		_fadeInTimer = 0;
		_fadeInTotal = 0;
		exists = false;
		active = false;
		visible = false;
		name = null;
		artist = null;
		amplitude = 0;
		amplitudeLeft = 0;
		amplitudeRight = 0;
		autoDestroy = false;
		survive = false;
		_distance1 = SpiPoint.get();
		_distance2 = SpiPoint.get();
	}

	/**
	 * Clean up memory.
	 */
	override
	public function destroy():Void
	{
		kill();

		_transform = null;
		_sound = null;
		_channel = null;
		_target = null;
		name = null;
		artist = null;
		_distance1 = SpiDestroyUtil.put(_distance1);
		_distance2 = SpiDestroyUtil.put(_distance2);
		super.destroy();
	}

	/**
	 * Handles fade out, fade in, panning, proximity, and amplitude operations
	 * each frame.
	 */
	override
	public function update():Void
	{
		_radial = 1.0;
		_fade = 1.0;

		// Distance-based volume control
		if(_target != null)
		{
			_radial = 1 - SpiMath.getDistance(_distance1.make(_target.x, _target.y), _distance2.make(x, y)) / _radius;
			if(_radial < 0)
				_radial = 0;
			if(_radial > 1)
				_radial = 1;

			if(_pan)
			{
				var d:Float = (x - _target.x) / _radius;
				if(d < -1)
					d = -1;
				else if(d > 1)
					d = 1;
				_transform.pan = d;
			}
		}

		// Cross-fading volume control
		if(_fadeOutTimer > 0)
		{
			_fadeOutTimer -= SpiG.elapsed;
			if(_fadeOutTimer <= 0)
			{
				if(_pauseOnFadeOut)
					pause();
				else
					stop();
			}
			_fade = _fadeOutTimer / _fadeOutTotal;
			if(_fade < 0)
				_fade = 0;
		}
		else if(_fadeInTimer > 0)
		{
			_fadeInTimer -= SpiG.elapsed;
			_fade = _fadeInTimer / _fadeInTotal;
			if(_fade < 0)
				_fade = 0;
			_fade = 1 - _fade;
		}

		_volumeAdjust = _radial * _fade;
		updateTransform();

		// TODO: Amplitude data
		// if(_transform.volume > 0)
		// {
		// amplitudeLeft = _channel.leftPeak/_transform.volume;
		// amplitudeRight = _channel.rightPeak/_transform.volume;
		// amplitude = (amplitudeLeft+amplitudeRight)*0.5;
		// }
	}

	override
	public function kill():Void
	{
		super.kill();
		if(_channel != null)
			stop();
	}

	/**
	 * One of two main setup functions for sounds, this function loads a sound
	 * from an embedded MP3.
	 * 
	 * @param EmbeddedSound An embedded Class object representing an MP3 file.
	 * @param Looped Whether or not this sound should loop endlessly.
	 * @param AutoDestroy Whether or not this <code>SpiSound</code> instance
	 *        should be destroyed when the sound finishes playing. Default value
	 *        is false, but SpiG.play() and SpiG.stream() will set it to true by
	 *        default.
	 * @param Type Whether this sound is a sound effect or a music track.
	 * 
	 * @return This <code>SpiSound</code> instance (nice for chaining stuff
	 *         together, if you're into that).
	 */
	public function loadEmbedded(EmbeddedSound:String, Looped:Bool, AutoDestroy:Bool, Type:Int):SpiSound
	{
		stop();
		createSound();

		switch(Type)
		{
			case SFX:
	// 			_sound = new GdxSound(EmbeddedSound);

			case MUSIC:
	// 			_sound = new GdxMusic(EmbeddedSound);

			case AUTO:
	// 			// If the type is not specified, make a guess based on the file
	// 			// size.
	// 			int fileSize = 24576;
				
	// 			if(Gdx.app.getType() == ApplicationType.iOS)
	// 				fileSize = 256000;
			
	// 			FileHandle file = Gdx.files.internal(EmbeddedSound);
	// 			Type = file.length() < fileSize ? SFX : MUSIC;
	// 			return loadEmbedded(EmbeddedSound, Looped, AutoDestroy, Type);
		}

	// 	// NOTE: can't pull ID3 info from embedded sound currently
		_looped = Looped;
		autoDestroy = AutoDestroy;
		updateTransform();
		exists = true;
		return this;
	}

	// /**
	//  * One of two main setup functions for sounds, this function loads a sound
	//  * from an embedded MP3. If the file is larger than 24 KB, the type will be
	//  * MUSIC.
	//  * 
	//  * @param EmbeddedSound An embedded Class object representing an MP3 file.
	//  * 
	//  * @return This <code>SpiSound</code> instance (nice for chaining stuff
	//  *         together, if you're into that).
	//  */
	// public SpiSound loadEmbedded(String EmbeddedSound)
	// {
	// 	return loadEmbedded(EmbeddedSound, false, false, AUTO);
	// }

	/**
	 * One of two main setup functions for sounds, this function loads a sound
	 * from a URL.
	 * 
	 * @param SoundURL A string representing the URL of the MP3 file you want to
	 *        play.
	 * @param Looped Whether or not this sound should loop endlessly.
	 * @param AutoDestroy Whether or not this <code>SpiSound</code> instance
	 *        should be destroyed when the sound finishes playing. Default value
	 *        is false, but SpiG.play() and SpiG.stream() will set it to true by
	 *        default.
	 * 
	 * @return This <code>SpiSound</code> instance (nice for chaining stuff
	 *         together, if you're into that).
	 */
	// TODO: Load a sound from an URL
	public function loadStream(SoundURL:String, Looped:Bool = false, AutoDestroy:Bool = false):SpiSound
	{
		stop();
		createSound();
		// _sound = new Sound();
		// _sound.addEventListener(Event.ID3, gotID3);
		// _sound.load(new URLRequest(SoundURL));
		// _looped = Looped;
		// autoDestroy = AutoDestroy;
		// updateTransform();

		exists = true;
		return this;
	}

	/**
	 * Call this function if you want this sound's volume to change based on
	 * distance from a particular SpiCore object.
	 * 
	 * @param X The X position of the sound.
	 * @param Y The Y position of the sound.
	 * @param Object The object you want to track.
	 * @param Radius The maximum distance this sound can travel.
	 * @param Pan Whether the sound should pan in addition to the volume changes
	 *        (default: true).
	 * 
	 * @return This SpiSound instance (nice for chaining stuff together, if
	 *         you're into that).
	 */
	public function proximity(X:Float, Y:Float, Object:SpiObject, Radius:Float, Pan:Bool = false):SpiSound
	{
		x = X;
		y = Y;
		_target = Object;
		_radius = Radius;
		_pan = Pan;
		return this;
	}

	/**
	 * Call this function to play the sound - also works on paused sounds.
	 * 
	 * @param ForceRestart Whether to start the sound over or not. Default value
	 *        is false, meaning if the sound is already playing or was paused
	 *        when you call <code>play()</code>, it will continue playing from
	 *        its current position, NOT start again from the beginning.
	 */
	public function play(ForceRestart:Bool = false)
	{
		// Do not play if we are on mute
		if (SpiG.volumeHandler.mute)
			return;

		// Do not play if the volume if 0.0
		if (_sound != null && _sound.getType() == SFX && SpiG.volumeHandler.soundVolume == 0.0)
			return;

		// Do not play if the volume if 0.0
		if (_sound != null && _sound.getType() == MUSIC && SpiG.volumeHandler.musicVolume == 0.0)
			return;
		
		if(_position < 0)
			return;

		if(ForceRestart) {
			var oldAutoDestroy:Bool = autoDestroy;
			autoDestroy = false;
			stop();
			autoDestroy = oldAutoDestroy;
		}

		if(_looped) {
			if(_position == 0) {
				if(_channel == null)
					_channel = _sound.play(0, 9999, _transform);
				if(_channel == null)
					exists = false;
				else
					_channel.addEventListener(Event.SOUND_COMPLETE, stoppedListener);
			} else
				_channel.resume();
		} else {
			if(_position == 0) {
				if(_channel == null) {
					_channel = _sound.play(0, 0, _transform);
					if(_channel == null)
						exists = false;
					else
						_channel.addEventListener(Event.SOUND_COMPLETE, stoppedListener);
				}
			}
			else
				_channel.resume();
		}

		active = (_channel != null);
		_position = 0;
	}

	/**
	 * Unpause a sound. Only works on sounds that have been paused.
	 */
	public function resume():Void
	{
		if(_position <= 0)
			return;

		_channel.resume();

		active = (_channel != null);
	}

	/**
	 * Call this function to pause this sound.
	 */
	public function pause():Void
	{
		if(_channel == null) {
			_position = -1;
			return;
		}
		_position = 1;
		_channel.pause();
		active = false;
	}

	/**
	 * Call this function to stop this sound.
	 */
	public function stop():Void
	{
		_position = 0;
		if(_channel != null)
		{
			_channel.stop();
			stopped();
		}
	}

	/**
	 * Call this function to make this sound fade out over a certain time
	 * interval.
	 * 
	 * @param Seconds The amount of time the fade out operation should take.
	 * @param PauseInstead Tells the sound to pause on fadeout, instead of
	 *        stopping.
	 */
	public function fadeOut(Seconds:Float, PauseInstead:Bool = false):Void
	{
		_pauseOnFadeOut = PauseInstead;
		_fadeInTimer = 0;
		_fadeOutTimer = Seconds;
		_fadeOutTotal = _fadeOutTimer;
	}

	/**
	 * Call this function to make a sound fade in over a certain time interval
	 * (calls <code>play()</code> automatically).
	 * 
	 * @param Seconds The amount of time the fade-in operation should take.
	 */
	public function fadeIn(Seconds:Float):Void
	{
		_fadeOutTimer = 0;
		_fadeInTimer = Seconds;
		_fadeInTotal = _fadeInTimer;
		play();
	}

	/**
	 * Set <code>volume</code> to a value between 0 and 1 to change how this
	 * sound is.
	 */
	public function getVolume():Float
	{
		return _volume;
	}

	/**
	 * Set <code>volume</code> to a value between 0 and 1 to change how this
	 * sound is.
	 * 
	 * @param Volume The volume of the sound.
	 */
	public function setVolume(Volume:Float):Void
	{
		_volume = Volume;
		if(_volume < 0)
			_volume = 0;
		else if(_volume > 1)
			_volume = 1;
		updateTransform();
	}

	/**
	 * Returns the currently selected "real" volume of the sound (takes fades
	 * and proximity into account).
	 * 
	 * @return The adjusted volume of the sound.
	 */
	public function getActualVolume():Float
	{
		return _volume * _volumeAdjust;
	}

	/**
	 * Set the pitch multiplier, 1 == default, >1 == faster, <1 == slower, the
	 * value has to be between 0.5 and 2.0.
	 * 
	 * @param Pitch
	 */
	public function setPitch(Pitch:Float):Void
	{
		_pitch = Pitch;
		if(_pitch < 0)
			_pitch = 0;
		else if(_pitch > 2)
			_pitch = 2;
		updateTransform();
	}

	/**
	 * Returns the current ptich of the sound.
	 * 
	 * @return The ptich of the sound.
	 */
	public function getPitch():Float
	{
		return _pitch;
	}

	/**
	 * Call after adjusting the volume to update the sound channel's settings.
	 */
	private function updateTransform():Void
	{
		var volume:Float = 1;
		
		// Get the values
		if(_sound != null && _sound.getType() == SFX) {
			volume = SpiG.getSoundVolume();
		} else if(_sound != null && _sound.getType() == MUSIC) {
			volume = SpiG.getMusicVolume();
		}
		
		_transform.volume = (SpiG.getMute() ? 0 : 1) * volume * _volume * _volumeAdjust;
		_transform.pitch = _pitch;
		if(_channel != null)
			_channel.setSoundTransform(_transform);
	}

	/**
	 * An internal helper function used to help Flash clean up and re-use
	 * finished sounds.
	 */
	private function stopped():Void
	{
		_channel.removeEventListener(Event.SOUND_COMPLETE, stoppedListener);
		_channel = null;
		active = false;
		_isPausedOnFocusLost = false;
		if(autoDestroy)
			destroy();
	}

	/**
	 * Internal event handler for ID3 info (i.e. fetching the song name).
	 */
	// TODO: ID3 info
	private function gotID3():Void
	{
		/*
		 * SpiG.log("got ID3 info!"); if(_sound.id3.songName.length > 0) name =
		 * _sound.id3.songName; if(_sound.id3.artist.length > 0) artist =
		 * _sound.id3.artist; _sound.removeEventListener(Event.ID3, gotID3);
		 */
	}

	/**
	 * Internal event listener.
	 */
	private function stoppedListener(e:Event):Void
	{
		stopped();
	}

}