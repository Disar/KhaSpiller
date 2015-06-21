package spiller;

import haxe.CallStack;

import kha.Configuration;
import kha.graphics2.Graphics;
import kha.graphics4.Program;
import kha.Image;

import kha.Scheduler;
import kha.Scheduler.TimeTask;
import spiller.math.SpiMath;
import spiller.math.SpiRandom;
import spiller.math.SpiPoint;
import spiller.math.SpiRect;
import spiller.physics.SpiQuadTree;
import spiller.system.flash.FlashGraphics;
import spiller.system.flash.SpiGameStage;
import spiller.system.input.SpiKeyboard;
import spiller.system.input.SpiMouse;
import spiller.sound.SpiSound;
import spiller.sound.SpiVolumeHandler;
import spiller.system.kha.graphics.atlas.AtlasRegion;
import spiller.system.kha.graphics.atlas.TextureAtlas;
import spiller.system.kha.graphics.SpiShaderProgram;
import spiller.system.SpiPause.PauseEvent;
import spiller.SpiBasic.SpiType;
import spiller.system.store.SpiSave;
import spiller.system.SpiAssetManager;
import spiller.effects.lighting.SpiLightning;
import spiller.util.SpiColor;
import spiller.system.time.SpiTimerManager;

#if SPI_RECORD_REPLAY
import spiller.system.replay.SpiReplay;
#end

/**
 * This is a global helper class full of useful methods for audio,<br>
 * input, basic info, and the camera system among other things.<br>
 * Utilities for maths and color and things can be found in <code>SpiU</code>.<br>
 * <code>SpiG</code> is specifically for spiller-specific properties.<br>
 * <br>
 * v1.3 Updated reflection stuff.<br>
 * v1.2 Added the tween method and the inOUYA method.<br>
 * v1.1 Ported to Java.<br>
 * v1.0 Initial version (?).<br>
 * 
 * @version 1.4 - 02/07/2013
 * @author ratalaika / Ratalaika Games
 */
@:allow(spiller)
@:access(kha.Scheduler)
@:access(kha.Configuration)
class SpiG
{
	// /**
	//  * If you build and maintain your own version of spiller,
	//  * you can give it your own name here.
	//  */
	// public static String LIBRARY_NAME = "spiller";
	// /**
	//  * Assign a major version to your library.
	//  * Appears before the decimal in the console.
	//  */
	// public static int LIBRARY_MAJOR_VERSION = 2;
	// /**
	//  * Assign a minor version to your library.
	//  * Appears after the decimal in the console.
	//  */
	// public static int LIBRARY_MINOR_VERSION = 3;
	// /**
	//  * Debugger overlay layout preset: Wide but low windows at the bottom of the screen.
	//  */
	// public static inline var DEBUGGER_STANDARD = 0;
	// /**
	//  * Debugger overlay layout preset: Tiny windows in the screen corners.
	//  */
	// public static inline var DEBUGGER_MICRO = 1;
	// /**
	//  * Debugger overlay layout preset: Large windows taking up bottom half of screen.
	//  */
	// public static inline var DEBUGGER_BIG = 2;
	// /**
	//  * Debugger overlay layout preset: Wide but low windows at the top of the screen.
	//  */
	// public static inline var DEBUGGER_TOP = 3;
	// /**
	//  * Debugger overlay layout preset: Large windows taking up left third of screen.
	//  */
	// public static inline var DEBUGGER_LEFT = 4;
	// /**
	//  * Debugger overlay layout preset: Large windows taking up right third of screen.
	//  */
	// public static inline var DEBUGGER_RIGHT = 5;
	// /**
	//  * Our editor ID for the Admob
	//  */
	// public static String UID;
	// /**
	//  * The Android ID.
	//  */
	// public static String DEVICE_ID;
	/**
	 * Internal tracker for game object.
	 */
	private static var _game:SpiGame;
	/**
	 * Handy shared variable for implementing your own pause behavior.
	 */
	public static var paused:Bool;
	/**
	 * Whether you are running in Debug or Release mode.
	 * Set automatically by <code>SpiPreloader</code> during startup.
	 */
	public static var debug:Bool;
	/**
	 * Whether we show the FPS or not.
	 */
	public static var showFPS:Bool;
	/**
	 * Handy shared variable to check if the pause is on or off.
	 */
	private static var _disablePause:Bool;
	/**
	 * WARNING: Changing this can lead to issues with physics<br>
	 * and the recording system.<br>
	 * Setting this to false might lead to smoother animations<br>
	 * (even at lower fps) at the cost of physics accuracy.
	 */
	public static var fixedTimestep:Bool = true;
	/**
	 * Useful when the timestep is NOT fixed (i.e. variable),<br>
	 * to prevent jerky movement or erratic behavior at very low fps.<br>
	 * Essentially locks the framerate to a minimum value - any slower and<br>
	 * you'll get slowdown instead of frameskip; default is 1/10th of a second.
	 */
	public static var maxElapsed:Float = 0.1;
	/**
	 * Represents the amount of time in seconds that passed since last frame.
	 */
	public static var elapsed:Float;
	/**
	 * How fast or slow time should pass in the game; default is 1.0.
	 */
	public static var timeScale:Float;
	/**
	 * The width of the screen in game pixels.
	 */
	public static var width:Int;
	/**
	 * The height of the screen in game pixels.
	 */
	public static var height:Int;
	/**
	 * The dimensions of the game world, used by the quad tree for collisions and overlap checks.
	 */
	public static var worldBounds:SpiRect;
	/**
	 * How many times the quad tree should divide the world on each axis.
	 * Generally, sparse collisions can have fewer divisons,
	 * while denser collision activity usually profits from more.
	 * Default value is 6.
	 */
	public static var worldDivisions:Int;
	/**
	 * The width in pixels of the display surface.
	 */
	public static var screenWidth:Int; 
	/**
	 * The height in pixels of the display surface.
	 */
	public static var screenHeight:Int;
	/**
	 * Whether to show visual debug displays or not.
	 * Default = false.
	 */
	public static var visualDebug:Bool;
	/**
	 * Setting this to true will disable/skip stuff that isn't necessary for mobile platforms like Android. [BETA]
	 */
	public static var mobile:Bool;
	/**
	 * All the levels you have completed.
	 */
	public static var levels:Array<Dynamic>;
	/**
	 * The current level.
	 */
	public static var level:Int;
	/**
	 * The scores accomplished each level.
	 */
	public static var scores:Array<Int>;
	/**
	 * The current score.
	 */
	public static var score:Int;
	/**
	 * <code>saves</code> is a generic bucket for storing
	 * SpiSaves so you can access them whenever you want.
	 */
	public static var saves:Array<SpiSave>;
	/**
	 * The current save.
	 */
	public static var save:Int;
	/**
	 * A reference to a <code>SpiMouse</code> object.  Important for input!
	 * Referenced also as touch for code reading.
	 */
	public static var mouse:SpiMouse;
	public static var touch:SpiMouse;
	/**
	 * A reference to a <code>SpiKeyboard</code> object.  Important for input!
	 */
	public static var keys:SpiKeyboard;
	/**
	 * If we fire an event after each key down event.<br>
	 * This could be handy to configuring player specific keys.<br>
	 * Default = false<br>
	 */
	public static var fireEvent:Bool = false;
	// /**
	//  * A reference to a <code>SpiAccelerometer</code> object. Important for input!
	//  */
	// public static SpiAccelerometer accelerometer;
	// /**
	//  * A reference to any <code>SpiExternalInput</code> objects. Important for input!
	//  */
	// public static SpiExternalInput externals;
	/**
	 * A handy container for a background music object.
	 */
	public static var music:SpiSound;
	/**
	 * A list of all the sounds being played in the game.
	 */
	public static var sounds:SpiGroup;
	/**
	 * Internal volume level, used for global sound control.
	 */
	private static var volumeHandler:SpiVolumeHandler;
	/**
	 * An array of <code>SpiCamera</code> objects that are used to draw stuff.
	 * By default spiller creates one camera the size of the screen.
	 */
	public static var cameras:Array<SpiCamera>;
	/**
	 * Internal, keeps track of all the cameras that would have been added
	 * to the stage in Flash.
	 */
	public static var displayList:Array<SpiCamera>;
	/**
	 * By default this just refers to the first entry in the cameras array
	 * declared above, but you can do what you like with it.
	 */
	public static var camera:SpiCamera;
	/**
	 * An array container for <code>ShaderProgram</code>s.
	 */
	public static var shaders:Map<String, SpiShaderProgram>;
	/**
	 * This <code>ShaderProgram</code> will be used for
	 * <code>SpriteBatch.setShader()</code> only.
	 */
	public static var batchShader:Program;
	/**
	 * An array container for plugins.
	 * By default spiller uses a couple of plugins:
	 * SpiDebugPathDisplay, and SpiTimerManager.
	 */
	public static var plugins:Array<SpiBasic>;
	/**
	 * Useful helper objects for doing Flash-specific rendering.
	 * Primarily used for "debug visuals" like drawing bounding boxes directly to the screen buffer.
	 */
	public static var flashGfx:FlashGraphics;
	/**
	 * Internal storage system to prevent assets from being used repeatedly in memory.
	 */
	public static var _cache:SpiAssetManager;
	/**
	 * Global <code>SpriteBatch</code> for rendering sprites to the screen.
	 */
	public static var batch:Graphics;
	// /**
	//  * Internal reference to OpenGL.
	//  */
	// public static GL20 gl;
	/**
	 * The camera currently being drawn.
	 */
	private static var activeCamera:SpiCamera;
	/**
	 * The sprite lightning plugin.
	 */
	public static var spriteLightning:SpiLightning;
	// /**
	//  * Internal, a pre-allocated array to prevent <code>new</code> calls.
	//  */
	// private static float[] _floatArray;
	/**
	 * Global tweener for tweening between multiple worlds
	 */
	public static var tweener:SpiBasic = new SpiBasic();
	/**
	 * Helper to refer a (1, 1) SpiPoint.
	 */
	public static var basicPoint:SpiPoint = SpiPoint.get(1, 1);

	/**
	 * A SpiRandom object used internally by flixel to generate random numbers.
	 */
	public static var random(default, null):SpiRandom = new SpiRandom();

	// //==========================================================================//
	// //							INTERFACED PLUGINS								//
	// //==========================================================================//
	// /**
	//  * If we have to check the license or not (Use for general licensing).
	//  */
	// public static boolean checkLicense;
	// /**
	//  * If we have Admob or not (Use for Google Admob).
	//  */
	// public static boolean withAds;
	// /**
	//  * The Ad manager instance (Admob in mobile).
	//  */
	// public static SpiAdManager adManager;
	// /**
	//  * The rotation manager. (ONLY WORKS ON ANDROID)
	//  */
	// public static SpiRotation rotationManager;
	// /**
	//  * The machine model (Android Mode for example).
	//  */
	// public static String model = "";
	// /**
	//  * The OS system name.
	//  */
	// public static String systemName = "";
	// /**
	//  * Indicates if the Internet connection was active or not at
	//  * the time the game was launched.
	//  */
	// public static boolean isInternetActive;
	// /**
	//  * If we are on an amazon device. Trolololo bad code... XD
	//  */
	// public static boolean isAmazon = false;
	// /**
	//  * If we are on an OUYA supported hardware device.
	//  */
	// public static boolean inOuya = false;
	// /**
	//  * The google games interface.
	//  */
	// public static SpiSocialGames socialGames;
	// /**
	//  * The Open More games interface.
	//  */
	// public static SpiMoreGames openMoreGames;
	// /**
	//  * The alert manager.
	//  */
	// public static SpiAlertManager alertManager;
	// /**
	//  * The push notifications manager.
	//  */
	// public static SpiPNManager pnManager;
	// /**
	//  * The In App manager.
	//  */
	// public static SpiInAppManager inAppManager;
	// /**
	//  * Update the FPS.
	//  */
	// public static SpiUpdateFPS updateFPS;

	// /**
	//  * Returns the library name.
	//  */
	// public static String getLibraryName()
	// {
	// 	return LIBRARY_NAME + " v" + LIBRARY_MAJOR_VERSION + "." + LIBRARY_MINOR_VERSION;
	// }
	
	/**
	 * Log data to the debugger.
	 * 
	 * @param tag					The tag you want to show in the console or cat log.
	 * @param data					Anything you want to log to the console.
	 * @param showThreadName		If the log prints the Thread name or not.
	 */
	public static function log(tag:String = "spiller", data = null, showThreadName:Bool = false):Void
	{
		if(data != null) {
				trace(tag + ": " + data.toString());
		} else {
				trace(tag + ": Spiller Log: data -> null");
		}
	}

	/**
	 * Get the current stack trace.
	 */
	public static function getStackTrace():String
	{
		return CallStack.toString(CallStack.callStack());
	}

	/**
	 * Disable the pause system.
	 * 
	 * @param Pause		If we disable the pause system or not.
	 */
	public static function setDisablePause(Pause:Bool):Void
	{
		_disablePause = Pause;
	}

	/**
	 * Return the true if we disabled the pause system.
	 */
	public static function getDisablePause():Bool
	{
		return _disablePause;
	}


	/**
	 * Check if the game is paused or not.
	 */
	public static function getPause():Bool
	{
		return paused;
	}
	
	// /**
	//  * Check if the game is focused or not.
	//  */
	// public static boolean isFocus()
	// {
	// 	return !_game._lostFocus;
	// }

	/**
	 * Return the game instance (DANGEROUS!!!)
	 */
	public static function getGame():SpiGame
	{
		return _game;
	}

	/**
	 * This method pause/unpause the game. Only do something if the game was not in the pause/unpause state.
	 */
	public static function setPause(pause:Bool):Void
	{
		if(_disablePause) {
			var op:Bool = paused;
			paused = pause;
			if(paused != op) {
				if(paused) pauseAudio();
				else resumeAudio();
			}
			return;
		}

		var op:Bool = paused;
		paused = pause;
		if(paused != op) {
			if(paused) {
				pauseAudio();
				
				// Dispatch pause event
				if(SpiG.getStage() != null)
					SpiG.getStage().dispatchEvent(PauseEvent.getEvent(PauseEvent.PAUSE_IN));
			} else {
				resumeAudio();
				
				// Dispatch pause event
				if(SpiG.getStage() != null)
					SpiG.getStage().dispatchEvent(PauseEvent.getEvent(PauseEvent.PAUSE_OUT));
			}
		}
	}

	// /**
	//  * Add a variable to the watch list in the debugger.
	//  * This lets you see the value of the variable all the time.
	//  * 
	//  * @param	AnyObject		A reference to any object in your game, e.g. Player or Robot or this.
	//  * @param	VariableName	The name of the variable you want to watch, in quotes, as a string: e.g. "speed" or "health".
	//  * @param	DisplayName		Optional, display your own string instead of the class name + variable name: e.g. "enemy count".
	//  */
	// public static void watch(Object AnyObject,String VariableName,String DisplayName)
	// {
	// 	if((_game != null) && (_game.debugger != null))
	// 		_game.debugger.watch.add(AnyObject,VariableName,DisplayName);
	// }
	
// 	/**
// 	 * Add a variable to the watch list in the debugger.
// 	 * This lets you see the value of the variable all the time.
// 	 * 
// 	 * @param	AnyObject		A reference to any object in your game, e.g. Player or Robot or this.
// 	 * @param	VariableName	The name of the variable you want to watch, in quotes, as a string: e.g. "speed" or "health".
// 	 */
// 	public static void watch(Object AnyObject,String VariableName)
// 	{
// 		watch(AnyObject, VariableName, null);
// 	}
	
// 	/**
// 	 * Remove a variable from the watch list in the debugger.
// 	 * Don't pass a Variable Name to remove all watched variables for the specified object.
// 	 * 
// 	 * @param	AnyObject		A reference to any object in your game, e.g. Player or Robot or this.
// 	 * @param	VariableName	The name of the variable you want to watch, in quotes, as a string: e.g. "speed" or "health".
// 	 */
// 	public static void unwatch(Object AnyObject,String VariableName)
// 	{
// 		if((_game != null) && (_game.debugger != null))
// 			_game.debugger.watch.remove(AnyObject,VariableName);
// 	}
	
// 	/**
// 	 * Remove a variable from the watch list in the debugger.
// 	 * Don't pass a Variable Name to remove all watched variables for the specified object.
// 	 * 
// 	 * @param	AnyObject		A reference to any object in your game, e.g. Player or Robot or this.
// 	 */
// 	public static void unwatch(Object AnyObject)
// 	{
// 		unwatch(AnyObject, null);
// 	}
	
	/**
	 * How many times you want your game to update each second.
	 * More updates usually means better collisions and smoother motion.
	 * NOTE: This is NOT the same thing as the Flash Player framerate!
	 */
	public static inline function getFramerate():Int
	{
		return _game._gameFramerate;
	}
	
	/**
	 * @private
	 */
	public static function setFramerate(Framerate:Int):Void
	{
		_game._gameFramerate = Framerate;
		_game._step = Std.int(1000 / Framerate);
		if(_game.maxAccumulation < _game._step)
			_game.maxAccumulation = Std.int(_game._step);

		// Update the fps at runtime
		var timerTask:TimeTask = Scheduler.getTimeTask(Configuration.id);
		if(timerTask != null)
			timerTask.period = 1 / Framerate;
	}
	
	/**
	 * How many times you want your game to update each second.
	 * More updates usually means better collisions and smoother motion.
	 * NOTE: This is NOT the same thing as the Flash Player framerate!
	 */
	public static inline function getFlashFramerate():Int
	{
		return _game._flashFramerate;
	}

	/**
	 * 
	 */
	public static function setFlashFramerate(Framerate:Int):Void
	{
		_game._flashFramerate = Framerate;
		_game.maxAccumulation = Std.int(2000 / _game._flashFramerate - 1);
		if(_game.maxAccumulation < _game._step)
			_game.maxAccumulation = Std.int(_game._step);
	}

// 	/**
// 	 * Generates a random number.  Deterministic, meaning safe
// 	 * to use if you want to record replays in random environments.
// 	 * 
// 	 * @return	A <code>Number</code> between 0 and 1.
// 	 */
// 	public static float random()
// 	{
// 		return SpiU.srand(0);
// 	}
	
// 	/**
// 	 * Shuffles the entries in an array into a new random order.
// 	 * <code>shuffle()</code> is deterministic and safe for use with replays/recordings.
// 	 * HOWEVER, <code>SpiU.shuffle()</code> is NOT deterministic and unsafe for use with replays/recordings.
// 	 * 
// 	 * @param	A				A libgdx <code>Array</code> object containing...stuff.
// 	 * @param	HowManyTimes	How many swaps to perform during the shuffle operation.  Good rule of thumb is 2-4 times as many objects are in the list.
// 	 * 
// 	 * @return	The same libgdx <code>Array</code> object that you passed in in the first place.
// 	 */
// 	public static <T> Array<T> shuffle(Array<T> Objects,int HowManyTimes)
// 	{
// 		int i = 0;
// 		int index1;
// 		int index2;
// 		T object;
// 		while(i < HowManyTimes)
// 		{
// 			index1 = (int) (random()*Objects.size);
// 			index2 = (int) (random()*Objects.size);
// 			object = Objects.get(index2);
// 			Objects.set(index2, Objects.get(index1));
// 			Objects.set(index1, object);
// 			i++;
// 		}
// 		return Objects;
// 	}

// 	/**
// 	 * Shuffles the entries in an integer array into a new random order.
// 	 * <code>shuffle()</code> is deterministic and safe for use with replays/recordings.
// 	 * HOWEVER, <code>SpiU.shuffle()</code> is NOT deterministic and unsafe for use with replays/recordings.
// 	 * 
// 	 * @param	array			An integer array.
// 	 * @param	HowManyTimes	How many swaps to perform during the shuffle operation.  Good rule of thumb is 2-4 times as many objects are in the list.
// 	 * 
// 	 * @return	The same integer array object that you passed in in the first place.
// 	 */
// 	public static int[] shuffle(int[] array, int HowManyTimes)
// 	{
// 		int i = 0, index1, index2, item, itemAux;
// 		while(i < HowManyTimes)
// 		{
// 			index1 = (int) (random()*array.length);
// 			index2 = (int) (random()*array.length);
// 			itemAux = array[index1];
// 			item = array[index2];
// 			array[index2] = itemAux;
// 			array[index1] = item;
// 			i++;
// 		}
// 		return array;
// 	}
	
// 	/**
// 	 * Fetch a random entry from the given array.
// 	 * Will return null if random selection is missing, or array has no entries.
// 	 * <code>getRandom()</code> is deterministic and safe for use with replays/recordings.
// 	 * HOWEVER, <code>SpiU.getRandom()</code> is NOT deterministic and unsafe for use with replays/recordings.
// 	 * 
// 	 * @param	Objects		A libgdx array of objects.
// 	 * @param	StartIndex	Optional offset off the front of the array. Default value is 0, or the beginning of the array.
// 	 * @param	Length		Optional restriction on the number of values you want to randomly select from.
// 	 * 
// 	 * @return	The random object that was selected.
// 	 */
// 	public static <T> T getRandom(Array<T> Objects,int StartIndex,int Length)
// 	{
// 		if(Objects != null)
// 		{
// 			int l = Length;
// 			if((l == 0) || (l > Objects.size - StartIndex))
// 				l = Objects.size - StartIndex;
// 			if(l > 0)
// 				return Objects.get(StartIndex + (int)(random()*l));
// 		}
// 		return null;
// 	}
	
// 	/**
// 	 * Fetch a random entry from the given array.
// 	 * Will return null if random selection is missing, or array has no entries.
// 	 * <code>getRandom()</code> is deterministic and safe for use with replays/recordings.
// 	 * HOWEVER, <code>SpiU.getRandom()</code> is NOT deterministic and unsafe for use with replays/recordings.
// 	 * 
// 	 * @param	Objects		A libgdx array of objects.
// 	 * @param	StartIndex	Optional offset off the front of the array. Default value is 0, or the beginning of the array.
// 	 * 
// 	 * @return	The random object that was selected.
// 	 */
// 	public static <T> T getRandom(Array<T> Objects,int StartIndex)
// 	{
// 		return getRandom(Objects, StartIndex, 0);
// 	}
	
// 	/**
// 	 * Fetch a random entry from the given array.
// 	 * Will return null if random selection is missing, or array has no entries.
// 	 * <code>getRandom()</code> is deterministic and safe for use with replays/recordings.
// 	 * HOWEVER, <code>SpiU.getRandom()</code> is NOT deterministic and unsafe for use with replays/recordings.
// 	 * 
// 	 * @param	Objects		A libgdx array of objects.
// 	 * 
// 	 * @return	The random object that was selected.
// 	 */
// 	public static <T> T getRandom(Array<T> Objects)
// 	{
// 		return getRandom(Objects, 0, 0);
// 	}

	#if SPI_RECORD_REPLAY
// 	/**
// 	 * Load replay data from a string and play it back.
// 	 * 
// 	 * @param	Data		The replay that you want to load.
// 	 * @param	State		Optional parameter: if you recorded a state-specific demo or cutscene, pass a new instance of that state here.
// 	 * @param	CancelKeys	Optional parameter: an array of string names of keys (see SpiKeyboard) that can be pressed to cancel the playback, e.g. ["ESCAPE","ENTER"].  Also accepts 2 custom key names: "ANY" and "MOUSE" (fairly self-explanatory I hope!).
// 	 * @param	Timeout		Optional parameter: set a time limit for the replay.  CancelKeys will override this if pressed.
// 	 * @param	Callback	Optional parameter: if set, called when the replay finishes.  Running to the end, CancelKeys, and Timeout will all trigger Callback(), but only once, and CancelKeys and Timeout will NOT call stopReplay() if Callback is set!
// 	 */
// 	public static void loadReplay(String Data, SpiState State, String[] CancelKeys, float Timeout, ISpiReplay Callback)
// 	{
// 		_game._replay.load(Data);
// 		if(State == null)
// 			resetGame();
// 		else
// 			switchState(State);
		
// 		Array<String> cKeys = null;
		
// 		if(CancelKeys == null)
// 			cKeys = new Array<String>();
// 		else 
// 			cKeys = new Array<String>(CancelKeys);
		
// 		_game._replayCancelKeys = cKeys;
// 		_game._replayTimer = (int) (Timeout*1000);
// 		_game._replayCallback = Callback;
// 		_game._replayRequested = true;
// 	}
	
// 	/**
// 	 * Load replay data from a string and play it back.
// 	 * 
// 	 * @param	Data		The replay that you want to load.
// 	 * @param	State		Optional parameter: if you recorded a state-specific demo or cutscene, pass a new instance of that state here.
// 	 * @param	CancelKeys	Optional parameter: an array of string names of keys (see SpiKeyboard) that can be pressed to cancel the playback, e.g. ["ESCAPE","ENTER"].  Also accepts 2 custom key names: "ANY" and "MOUSE" (fairly self-explanatory I hope!).
// 	 * @param	Timeout		Optional parameter: set a time limit for the replay.  CancelKeys will override this if pressed.
// 	 */
// 	public static void loadReplay(String Data, SpiState State, String[] CancelKeys, float Timeout)
// 	{
// 		loadReplay(Data, State, CancelKeys, Timeout, null);
// 	}
	
// 	/**
// 	 * Load replay data from a string and play it back.
// 	 * 
// 	 * @param	Data		The replay that you want to load.
// 	 * @param	State		Optional parameter: if you recorded a state-specific demo or cutscene, pass a new instance of that state here.
// 	 * @param	CancelKeys	Optional parameter: an array of string names of keys (see SpiKeyboard) that can be pressed to cancel the playback, e.g. ["ESCAPE","ENTER"].  Also accepts 2 custom key names: "ANY" and "MOUSE" (fairly self-explanatory I hope!).
// 	 */
// 	public static void loadReplay(String Data, SpiState State, String[] CancelKeys)
// 	{
// 		loadReplay(Data, State, CancelKeys, 0, null);
// 	}
	
// 	/**
// 	 * Load replay data from a string and play it back.
// 	 * 
// 	 * @param	Data		The replay that you want to load.
// 	 * @param	State		Optional parameter: if you recorded a state-specific demo or cutscene, pass a new instance of that state here.
// 	 */
// 	public static void loadReplay(String Data, SpiState State)
// 	{
// 		loadReplay(Data, State, null, 0, null);
// 	}
	
// 	/**
// 	 * Load replay data from a string and play it back.
// 	 * 
// 	 * @param	Data		The replay that you want to load.
// 	 */
// 	public static void loadReplay(String Data)
// 	{
// 		loadReplay(Data, null, null, 0, null);
// 	}
	
// 	/**
// 	 * Verify that the string is a valid replay.
// 	 * 
// 	 * @param	data		The replay that you want to verify.
// 	 */
// 	public static boolean verifyReplay(String data)
// 	{
// 		boolean correct = true;

// 		// Try to load the replay
// 		try {
// 			SpiReplay replay = new SpiReplay();
// 			replay.load(data);
// 		} catch(Exception ex) {
// 			ex.printStackTrace();
// 			correct = false;
// 		}
		
// 		return correct;
// 	}
	
	/**
	 * Returns true if we are replaying the game.
	 */
	public static function isReplaying():Bool
	{
		return _game._replaying;
	}

// 	/**
// 	 * Resets the game or state and replay requested flag.
// 	 * 
// 	 * @param	StandardMode	If true, reload entire game, else just reload current game state.
// 	 */
// 	public static void reloadReplay(boolean StandardMode = true)
// 	{
// 		if(StandardMode)
// 			resetGame();
// 		else
// 			resetState();
// 		if(_game._replay.frameCount > 0)
// 			_game._replayRequested = true;
// 	}
	
	/**
	 * Stops the current replay.
	 */
	public static function stopReplay():Void
	{
		_game._replaying = false;

		#if SPI_DEBUG
		if(_game.debugger != null)
			_game.debugger.vcr.stopped();
		#end

		resetInput();
	}
	
// 	/**
// 	 * Resets the game or state and requests a new recording.
// 	 * 
// 	 * @param	StandardMode	If true, reset the entire game, else just reset the current state.
// 	 */
// 	public static void recordReplay(boolean StandardMode)
// 	{
// 		if(StandardMode)
// 			resetGame();
// 		else
// 			resetState();
// 		_game._recordingRequested = true;
// 	}
	
// 	/**
// 	 * Resets the game or state and requests a new recording.
// 	 * 
// 	 * @param	StandardMode	If true, reset the entire game, else just reset the current state.
// 	 */
// 	public static void recordReplay()
// 	{
// 		recordReplay(true);
// 	}
	
// 	/**
// 	 * Stop recording the current replay and return the replay data.
// 	 * 
// 	 * @return	The replay data in simple ASCII format (see <code>SpiReplay.save()</code>).
// 	 */
// 	public static String stopRecording()
// 	{
// 		_game._recording = false;
// 		if(_game.debugger != null)
// 			_game.debugger.vcr.stopped();
// 		return _game._replay.save();
// 	}
	#end

// 	/**
// 	 * Request a reset of the current game state.
// 	 */
// 	public static void resetState()
// 	{		
// 		try {
// 			_game.requestedState = ClassReflection.newInstance(_game._state.getClass());
// 		} catch (Exception e)  {
// 			throw new RuntimeException(e);
// 		}
// 	}
	
// 	/**
// 	 * Like hitting the reset button on a game console, this will re-launch the game as if it just started.
// 	 */
// 	public static void resetGame()
// 	{
// 		_game._requestedReset = true;
// 	}
	
	/**
	 * Reset the input helper objects (useful when changing screens or states)
	 */
	public static function resetInput():Void
	{
		// keys.reset();
		// mouse.reset();
		// externals.reset();
		// accelerometer.reset();
	}
	
// 	/**
// 	 * Set up and play a looping background soundtrack.
// 	 * 
// 	 * @param Music The sound file you want to loop in the background.
// 	 * @param Volume How loud the sound should be, from 0 to 1.
// 	 */
// 	public static void playMusic(String Music, float Volume, boolean Looped, boolean AutoDestroy)
// 	{
// 		if(music == null)
// 			music = new SpiSound();
// 		if(music.active)
// 			music.stop();
// 		music.loadEmbedded(Music, Looped, AutoDestroy, SpiSound.MUSIC); 
// 		music.setVolume(Volume);
// 		music.survive = true;
// 		music.play();
// 	}

  
// 	/**
// 	 * Set up and play a looping background soundtrack.
// 	 * 
// 	 * @param Music The sound file you want to loop in the background.
// 	 * @param Volume How loud the sound should be, from 0 to 1.
// 	 * @param Looped Whether to loop this sound.
// 	 */
// 	public static void playMusic(String Music, float Volume, boolean Looped)
// 	{
// 		playMusic(Music, Volume, Looped, false);
// 	}
  
// 	/**
// 	 * Set up and play a looping background soundtrack.
// 	 * 
// 	 * @param Music The sound file you want to loop in the background.
// 	 * @param Volume How loud the sound should be, from 0 to 1.
// 	 */
// 	public static void playMusic(String Music, float Volume)
// 	{
// 		playMusic(Music, Volume, true, false);
// 	}

// 	/**
// 	 * Set up and play a looping background soundtrack.
// 	 * 
// 	 * @param Music The sound file you want to loop in the background.
// 	 */
// 	public static void playMusic(String Music)
// 	{
// 		playMusic(Music, 1.0f, true, false);
// 	}
	
// 	/**
// 	 * Creates a new sound object.
// 	 * 
// 	 * @param	EmbeddedSound	The embedded sound resource you want to play.  To stream, use the optional URL parameter instead.
// 	 * @param	Volume			How loud to play it (0 to 1).
// 	 * @param	Looped			Whether to loop this sound.
// 	 * @param	AutoDestroy		Whether to destroy this sound when it finishes playing.  Leave this value set to "false" if you want to re-use this <code>SpiSound</code> instance.
// 	 * @param	AutoPlay		Whether to play the sound.
// 	 * @param	URL				Load a sound from an external web resource instead.  Only used if EmbeddedSound = null.
// 	 * @param	Survive			If the sound should survive or not.
// 	 * 
// 	 * @return	A <code>SpiSound</code> object.
// 	 */
// 	public static SpiSound loadSound(String EmbeddedSound,float Volume,boolean Looped,boolean AutoDestroy,boolean AutoPlay,String URL,boolean Survive)
// 	{
// 		if((EmbeddedSound == null) && (URL == null))
// 		{
// //			log("WARNING: loadSound() requires either\nan embedded sound or a URL to work.");
// 			return null;
// 		}
// 		SpiSound sound = (SpiSound) sounds.recycle(SpiSound.class);
// 		if(EmbeddedSound != null)
// 			sound.loadEmbedded(EmbeddedSound,Looped,AutoDestroy);
// 		else
// 			sound.loadStream(URL,Looped,AutoDestroy);
// 		if(volumeHandler.mute)
// 			sound.setVolume(0);
// 		else
// 			sound.setVolume(Volume);
// 		if(AutoPlay)
// 			sound.play();
		
// 		if(Survive)
// 			sound.survive = true;
		
// 		return sound;
// 	}
	
// 	/**
// 	 * Creates a new sound object.
// 	 * 
// 	 * @param	EmbeddedSound	The embedded sound resource you want to play.  To stream, use the optional URL parameter instead.
// 	 * @param	Volume			How loud to play it (0 to 1).
// 	 * @param	Looped			Whether to loop this sound.
// 	 * @param	AutoDestroy		Whether to destroy this sound when it finishes playing.  Leave this value set to "false" if you want to re-use this <code>SpiSound</code> instance.
// 	 * @param	AutoPlay		Whether to play the sound.
// 	 * @param	URL				Load a sound from an external web resource instead.  Only used if EmbeddedSound = null.
// 	 * 
// 	 * @return	A <code>SpiSound</code> object.
// 	 */
// 	public static SpiSound loadSound(String EmbeddedSound,float Volume,boolean Looped,boolean AutoDestroy,boolean AutoPlay,String URL)
// 	{
// 		return loadSound(EmbeddedSound, Volume, Looped, AutoDestroy, AutoPlay, URL, false);
// 	}
	

// 	/**
// 	 * Creates a new sound object.
// 	 * 
// 	 * @param	EmbeddedSound	The embedded sound resource you want to play.  To stream, use the optional URL parameter instead.
// 	 * @param	Volume			How loud to play it (0 to 1).
// 	 * @param	Looped			Whether to loop this sound.
// 	 * @param	AutoDestroy		Whether to destroy this sound when it finishes playing.  Leave this value set to "false" if you want to re-use this <code>SpiSound</code> instance.
// 	 * @param	AutoPlay		Whether to play the sound.
// 	 * 
// 	 * @return	A <code>SpiSound</code> object.
// 	 */
// 	public static SpiSound loadSound(String EmbeddedSound,float Volume,boolean Looped,boolean AutoDestroy,boolean AutoPlay)
// 	{
// 		return loadSound(EmbeddedSound, Volume, Looped, AutoDestroy, AutoPlay, null);
// 	}
	
// 	/**
// 	 * Creates a new sound object.
// 	 * 
// 	 * @param	EmbeddedSound	The embedded sound resource you want to play.  To stream, use the optional URL parameter instead.
// 	 * @param	Volume			How loud to play it (0 to 1).
// 	 * @param	Looped			Whether to loop this sound.
// 	 * @param	AutoDestroy		Whether to destroy this sound when it finishes playing.  Leave this value set to "false" if you want to re-use this <code>SpiSound</code> instance.
// 	 * 
// 	 * @return	A <code>SpiSound</code> object.
// 	 */
// 	public static SpiSound loadSound(String EmbeddedSound, float Volume, boolean Looped, boolean AutoDestroy)
// 	{
// 		return loadSound(EmbeddedSound, Volume, Looped, AutoDestroy, false, null);
// 	}
	
// 	/**
// 	 * Creates a new sound object.
// 	 * 
// 	 * @param	EmbeddedSound	The embedded sound resource you want to play.  To stream, use the optional URL parameter instead.
// 	 * @param	Volume			How loud to play it (0 to 1).
// 	 * @param	Looped			Whether to loop this sound.
// 	 * 
// 	 * @return	A <code>SpiSound</code> object.
// 	 */
// 	public static SpiSound loadSound(String EmbeddedSound, float Volume, boolean Looped)
// 	{
// 		return loadSound(EmbeddedSound, Volume, Looped, false, false, null);
// 	}
	
// 	/**
// 	 * Creates a new sound object.
// 	 * 
// 	 * @param	EmbeddedSound	The embedded sound resource you want to play.  To stream, use the optional URL parameter instead.
// 	 * @param	Volume			How loud to play it (0 to 1).
// 	 * 
// 	 * @return	A <code>SpiSound</code> object.
// 	 */
// 	public static SpiSound loadSound(String EmbeddedSound, float Volume)
// 	{
// 		return loadSound(EmbeddedSound, Volume, false, false, false, null);
// 	}
	
// 	/**
// 	 * Creates a new sound object.
// 	 * 
// 	 * @param	EmbeddedSound	The embedded sound resource you want to play.  To stream, use the optional URL parameter instead.
// 	 * 
// 	 * @return	A <code>SpiSound</code> object.
// 	 */
// 	public static SpiSound loadSound(String EmbeddedSound)
// 	{
// 		return loadSound(EmbeddedSound, 1.0f, false, false, false, null);
// 	}
	
// 	/**
// 	 * Creates a new sound object from an embedded <code>Class</code> object.
// 	 * NOTE: Just calls loadSound() with AutoPlay == true.
// 	 * 
// 	 * @param	EmbeddedSound	The sound you want to play.
// 	 * @param	Volume			How loud to play it (0 to 1).
// 	 * @param	Looped			Whether to loop this sound.
// 	 * @param	AutoDestroy		Whether to destroy this sound when it finishes playing.  Leave this value set to "false" if you want to re-use this <code>SpiSound</code> instance.
// 	 * 
// 	 * @return	A <code>SpiSound</code> object.
// 	 */
// 	public static SpiSound play(String EmbeddedSound, float Volume, boolean Looped, boolean AutoDestroy)
// 	{
// 		return loadSound(EmbeddedSound, Volume, Looped, AutoDestroy, true);
// 	}

// 	/**
// 	 * Creates a new sound object from an embedded <code>Class</code> object.
// 	 * NOTE: Just calls loadSound() with AutoPlay == true.
// 	 * 
// 	 * @param	EmbeddedSound	The sound you want to play.
// 	 * @param	Volume			How loud to play it (0 to 1).
// 	 * @param	Looped			Whether to loop this sound.
// 	 * 
// 	 * @return	A <code>SpiSound</code> object.
// 	 */
// 	public static SpiSound play(String EmbeddedSound, float Volume, boolean Looped)
// 	{
// 		return play(EmbeddedSound, Volume, Looped, true);
// 	}
	
// 	/**
// 	 * Creates a new sound object from an embedded <code>Class</code> object.
// 	 * NOTE: Just calls loadSound() with AutoPlay == true.
// 	 * 
// 	 * @param	EmbeddedSound	The sound you want to play.
// 	 * @param	Volume			How loud to play it (0 to 1).
// 	 * 
// 	 * @return	A <code>SpiSound</code> object.
// 	 */
// 	public static SpiSound play(String EmbeddedSound, float Volume)
// 	{
// 		return play(EmbeddedSound,Volume,false,true);
// 	}

// 	/**
// 	 * Creates a new sound object from an embedded <code>Class</code> object.
// 	 * NOTE: Just calls loadSound() with AutoPlay == true.
// 	 * 
// 	 * @param	EmbeddedSound	The sound you want to play.
// 	 * @param	Looped			Whether to loop this sound.
// 	 * 
// 	 * @return	A <code>SpiSound</code> object.
// 	 */
// 	public static SpiSound play(String EmbeddedSound, boolean Looped)
// 	{
// 		return play(EmbeddedSound, 1.0f, Looped, true);
// 	}

// 	/**
// 	 * Creates a new sound object from an embedded <code>Class</code> object.
// 	 * NOTE: Just calls loadSound() with AutoPlay == true.
// 	 * 
// 	 * @param	EmbeddedSound	The sound you want to play.
// 	 * 
// 	 * @return	A <code>SpiSound</code> object.
// 	 */
// 	public static SpiSound play(String EmbeddedSound)
// 	{
// 		return play(EmbeddedSound, 1.0f, false, true);
// 	}
	
// 	/**
// 	 * Creates a new sound object from a URL.
// 	 * NOTE: Just calls loadSound() with AutoPlay == true.
// 	 * 
// 	 * @param	URL		The URL of the sound you want to play.
// 	 * @param	Volume	How loud to play it (0 to 1).
// 	 * @param	Looped	Whether or not to loop this sound.
// 	 * @param	AutoDestroy		Whether to destroy this sound when it finishes playing.  Leave this value set to "false" if you want to re-use this <code>SpiSound</code> instance.
// 	 * 
// 	 * @return	A SpiSound object.
// 	 */
// 	public static SpiSound stream(String URL,float Volume,boolean Looped,boolean AutoDestroy)
// 	{
// 		return loadSound(null,Volume,Looped,AutoDestroy,true,URL);
// 	}
	
// 	/**
// 	 * Creates a new sound object from a URL.
// 	 * NOTE: Just calls loadSound() with AutoPlay == true.
// 	 * 
// 	 * @param	URL		The URL of the sound you want to play.
// 	 * @param	Volume	How loud to play it (0 to 1).
// 	 * @param	Looped	Whether or not to loop this sound.
// 	 * 
// 	 * @return	A SpiSound object.
// 	 */
// 	public static SpiSound stream(String URL,float Volume,boolean Looped)
// 	{
// 		return stream(URL, Volume, Looped, true);
// 	}
	
// 	/**
// 	 * Creates a new sound object from a URL.
// 	 * NOTE: Just calls loadSound() with AutoPlay == true.
// 	 * 
// 	 * @param	URL		The URL of the sound you want to play.
// 	 * @param	Volume	How loud to play it (0 to 1).
// 	 * 
// 	 * @return	A SpiSound object.
// 	 */
// 	public static SpiSound stream(String URL,float Volume)
// 	{
// 		return stream(URL, Volume, false, true);
// 	}
	
// 	/**
// 	 * Creates a new sound object from a URL.
// 	 * NOTE: Just calls loadSound() with AutoPlay == true.
// 	 * 
// 	 * @param	URL		The URL of the sound you want to play.
// 	 * 
// 	 * @return	A SpiSound object.
// 	 */
// 	public static SpiSound stream(String URL)
// 	{
// 		return stream(URL, 1.0f, false, true);
// 	}
	
	/**
	 * Get the music volume.
	 */
	public static function getMusicVolume():Float
	{
		 return volumeHandler.musicVolume;
	}

	/**
	 * Get the sound volume.
	 */
	public static function getSoundVolume():Float
	{
		 return volumeHandler.soundVolume;
	}
	 
	/**
	 * Sets the music volume
	 */
	public static function setMusicVolume(volume:Float):Void
	{
		if(volume < 0)
			volume = 0;
		else if(volume > 1)
			volume = 1;

		volumeHandler.musicVolume = volume;
		if(volumeCallback != null)
			volumeCallback(volumeHandler.mute ? 0 : volume, SpiSound.MUSIC);
	}

	/**
	 * Sets the sound volume
	 */
	public static function setSoundVolume(volume:Float):Void
	{
		if(volume < 0)
			volume = 0;
		else if(volume > 1)
			volume = 1;

		volumeHandler.soundVolume = volume;
		if(volumeCallback != null)
			volumeCallback(volumeHandler.mute ? 0 : volume, SpiSound.SFX);
	}
	
	/**
	 * Get the mute state
	 */
	public static function getMute():Bool
	{
		return volumeHandler.mute;
	}

	/**
	 * Sets the mute state
	 */
	public static function setMute(mute:Bool):Void
	{
		volumeHandler.mute = mute;
		if(mute) {
			if(volumeCallback != null)
				volumeCallback(0, SpiSound.ALL);
		} else {
			if(volumeCallback != null) {
				volumeCallback(volumeHandler.musicVolume, SpiSound.MUSIC);
				volumeCallback(volumeHandler.soundVolume, SpiSound.SFX);
			}
		}
	}
	
	/**
	 * Called by SpiGame on state changes to stop and destroy sounds.
	 * 
	 * @param	ForceDestroy		Kill sounds even if they're flagged <code>survive</code>.
	 */
	static function destroySounds(ForceDestroy:Bool = false):Void
	{
		if((music != null) && (ForceDestroy || !music.survive))
		{
			music.destroy();
			music = null;
		}
		var i:Int = 0;
		var sound:SpiSound;
		var l:Int = sounds.size();
		while(i < l)
		{
			sound = cast(sounds.members[i], SpiSound);
			if((sound != null) && (ForceDestroy || !sound.survive))
				sound.destroy(); 
			i++;
		}
		sounds.clear();
	}
	
	/**
	 * Called by the game loop to make sure the sounds get updated each frame.
	 */
	public static function updateSounds():Void
	{
		if((music != null) && music.active)
			music.update();
		if((sounds != null) && sounds.active)
			sounds.update();
	}
	
	/**
	 * Pause all sounds currently playing.
	 */
	public static function pauseAudio():Void
	{
		// Pause the music.
		if((music != null) && music.exists)
			music.pause();

		// Pause all the sounds.
		var i:Int = 0;
		var sound:SpiSound;
		if(sounds != null) {
			var l:Int = sounds.size();
			while(i < l)
			{
				sound = cast (sounds.members[i++], SpiSound);
				if((sound != null) && sound.exists)
					sound.pause();
			}
		}
	}
	
	/**
	 * Resume playing existing sounds.
	 */
	public static function resumeAudio():Void
	{
		// Resume the music.
		if((music != null) && music.exists)
			music.play();
		
		// Resume all the sounds.
		var i:Int = 0;
		var sound:SpiSound;
		var l:Int = sounds.size();
		while(i < l)
		{
			sound = cast (sounds.members[i++], SpiSound);
			if((sound != null) && sound.exists)
				sound.resume();
		}
	}
	
	/**
	 * Free memory by disposing a sound file and removing it from the cache.
	 * 
	 * @param Path The path to the sound file.
	 */
	public static function disposeSound(Path:String):Void
	{
		_cache.unload(Path, SOUND);
	}

	/**
	 * Check the local cache to see if an asset with this key has been loaded
	 * already.
	 * 
	 * @param Key The string key identifying the asset.
	 * 
	 * @return Whether or not this file can be found in the cache.
	 */
	public static function checkCache(Key:String):Bool
	{
		return _cache.containsAsset(Key, ANY);
	}
	
	/**
	 * Check the local bitmap cache to see if a bitmap with this key has been
	 * loaded already.
	 * 
	 * @param Key The string key identifying the bitmap.
	 * 
	 * @return Whether or not this file can be found in the cache.
	 */
	public static function checkBitmapCache(Key:String):Bool
	{
		return _cache.containsAsset(Key, IMAGE) || _cache.containsAsset(Key, ATLAS);
	}
	
	/**
	 * Generates a new <code>TextureRegion</code> object (a colored square) and caches it.
	 * 
	 * @param Width 	How wide the square should be.
	 * @param Height 	How high the square should be.
	 * @param Color 	What color the square should be (0xAARRGGBB)
	 * @param Unique	Ensures that the <code>TextureRegion</code> uses a new slot in the cache.
	 * @param Key		Force the cache to use a specific Key to index the <code>TextureRegion</code>.
	 * 
	 * @return The <code>AtlasRegion</code> we just created.
	 */
	public static function createBitmap(Width:Int, Height:Int, Color:SpiColor, Unique:Bool = false, Key:String = null):AtlasRegion
	{		
		if(Key == null)
		{
			Key = Width+"x"+Height+":"+Color;
			if(Unique && checkBitmapCache(Key))
			{
				// Generate a unique key
				var inc:Int = 0;
				var ukey:String;
				do {
					ukey = Key + inc++;
				} while(checkBitmapCache(ukey));
				Key = ukey;
			}
		}
		
		if(!checkBitmapCache(Key))
		{
			if (Width == 0 || Height == 0) {
				throw "A bitmaps width and height must be greater than zero.";
			}

			var pixmap:Image = Image.create(SpiMath.ceilPowerOfTwo(Width), SpiMath.ceilPowerOfTwo(Height));
			pixmap.g2.color = Color.toKhaColor();
			pixmap.g2.fillRect(0, 0, Width, Height);
			pixmap.g2.color = SpiColor.WHITE.toKhaColor();
			_cache.addRuntimeTexture(Key, pixmap);
		}
		return _cache.get(Key, ATLAS);
	}
	
	/**
	 * Loads a <code>TextureRegion</code> from a file and caches it.
	 * 
	 * @param	Graphic		The image file that you want to load.
	 * @param	Reverse		Whether to generate a flipped version. Not used.
	 * @param	Unique		Ensures that the <code>TextureRegion</code> uses a new slot in the cache.
	 * @param	Key			Force the cache to use a specific Key to index the <code>TextureRegion</code>.
	 * 
	 * @return	The <code>AtlasRegion</code> we just created.
	 */
	public static function addBitmap(Graphic:String, Reverse:Bool = false, Unique:Bool = false, Key:String = null):AtlasRegion
	{
		if(Key != null) {
			Unique = true;
		} else {
			Key = Graphic/*+(Reverse?"_REVERSE_":"")*/;
			if(Unique && checkBitmapCache(Key)) {
				var inc:Int = 0;
				var ukey:String;
				do {
					ukey = Key + inc++;
				} while(checkBitmapCache(ukey));
				Key = ukey;
			}
		}
		
		var atlasRegion:AtlasRegion = null;
		var split:Array<String> = Graphic.split(":");

		// If no region has been specified, load as standard texture 
		if (split.length == 1) {
			var texture:Image = _cache.getImage(Graphic);
			atlasRegion = new AtlasRegion(texture, 0, 0, texture.width, texture.height);
		// Otherwise, load as TextureAtlas 
		} else if (split.length == 2) {
			var fileName:String = split[0];
			var regionName:String = split[1];
		
			atlasRegion = loadTextureAtlas(fileName).findRegion(regionName);
		
			if (atlasRegion == null)
				throw "Could not find region " + regionName + " in " + fileName;
		} else {
			throw "Invalid path: " + Graphic + ".";
		}
		
		if (Unique) {
			if(!checkBitmapCache(Key)) {
				var rx:Int = atlasRegion.getRegionX();
				var ry:Int = atlasRegion.getRegionY();
				var rw:Int = atlasRegion.getRegionWidth();
				var rh:Int = atlasRegion.getRegionHeight();
				
				var newPixmap:Image = Image.create(SpiMath.ceilPowerOfTwo(rw), SpiMath.ceilPowerOfTwo(rh));
				newPixmap.g2.drawSubImage(atlasRegion.getTexture(), 0, 0, rx, ry, rw, rh);
				_cache.addRuntimeTexture(Key, newPixmap);
			}
			atlasRegion = _cache.get(Key, ATLAS);
		}

		return atlasRegion;
	}
	
	/**
	 * Loads a <code>TextureAtlas</code> from a file and caches it.
	 * 
	 * @param Path The path to the atlas file you want to load.
	 * 
	 * @return The <code>TextureAtlas</code>.
	 */
	public static function loadTextureAtlas(Path:String):TextureAtlas
	{
		return _cache.get(Path, ATLAS);
	}

	/**
	 * Free memory by disposing a <code>TextureAtlas</code> and removing it from
	 * the cache.
	 * 
	 * @param Path The path to the atlas file.
	 */
	public static function disposeTextureAtlas(Path:String):Void
	{
		_cache.unload(Path, ATLAS);
	}
	
	/**
	 * Dumps the cache's image references.
	 */
	public static function clearBitmapCache():Void
	{
		_cache.disposeRunTimeTextures();
	}

	/**
	 * Dispose the asset manager and all assets it contains.
	 */
	public static function disposeAssetManager():Void
	{
		if(_cache != null)
			_cache.dispose();
	}
	
	/**
	 * The number of assets currently loaded. Useful for debugging.
	 * 
	 * @return The number of assets.
	 */
	public static function getNumberOfAssets():Int
	{
		return _cache.getNumberOfAssets();
	}

	/**
	 * Loads an external text file.
	 * 
	 * @param FileName	The path to the text file.
	 * 
	 * @return	The contents of the file.
	 */
	public static function loadString(FileName:String):String
	{
		return SpiAssetManager.getFileHandle(FileName).readString();
	}
	
	// /**
	//  * Loads a font from a file and caches it.
	//  * 
	//  * @param Path The path to the font file.
	//  * @param Size The size of the font.
	//  * @param Parameter The parameter that will be used for the
	//  *        <code>BitmapFont</code>
	//  * @return The font.
	//  */
	// public static BitmapFont loadFont(String Path, int Size, BitmapFontParameter Parameter)
	// {
	// 	String bitmapFontExtension = ".fnt";

	// 	if(Path.endsWith(bitmapFontExtension)) {
	// 		Path = Path.substring(0, Path.length() - bitmapFontExtension.length()) + Size + bitmapFontExtension;
	// 		return _cache.load(Path, BitmapFont.class, Parameter);
	// 	}
	// 	else
	// 		return _cache.load(Size + ":" + Path, BitmapFont.class, Parameter);
	// }

	// /**
	//  * Loads a font from a file and caches it.
	//  * 
	//  * @param Path The path to the font file.
	//  * @param Size The size of the font.
	//  * @return The font.
	//  */
	// public static BitmapFont loadFont(String Path, int Size)
	// {
	// 	BitmapFontParameter parameter = new BitmapFontParameter();
	// 	parameter.flip = true;
	// 	return loadFont(Path, Size, parameter);
	// }

	// /**
	//  * Free memory by disposing a font and removing it from the cache.
	//  * 
	//  * @param Path The path to the font file.
	//  * @param Size The size of the font.
	//  */
	// public static void disposeFont(String Path, int Size)
	// {
	// 	String bitmapFontExtension = ".fnt";

	// 	if(Path.endsWith(bitmapFontExtension)) {
	// 		Path = Path.substring(0, Path.length() - bitmapFontExtension.length()) + Size + bitmapFontExtension;
	// 		_cache.unload(Path);
	// 	}
	// 	else
	// 		_cache.unload(Size + ":" + Path);
	// }
	
	/**
	 * Read-only: retrieves the Flash stage object (required for event listeners)
	 * Will be null if it's not safe/useful yet.
	 */
	public static function getStage():SpiGameStage
	{
		return _game.stage;
	}
	
	/**
	 * Read-only: access the current game state from anywhere.
	 */
	public static function getState():SpiState
	{
		return _game._state;
	}
	
	/**
	 * Read-only: gets the current SpiCamera.
	 */
	public static function getActiveCamera():SpiCamera
	{
		return activeCamera;
	}

	/**
	 * Switch from the current game state to the one specified here.
	 * Saving the current in the stack.
	 * 
	 * @param state 	The new state.
	 */
	public static function switchState(state:SpiState):Void
	{
		_game.requestedState = state;
	}
	
	// /**
	//  * Change the way the debugger's windows are laid out.
	//  * 
	//  * @param	Layout		See the presets above (e.g. <code>DEBUGGER_MICRO</code>, etc).
	//  */
	// public static void setDebuggerLayout(int Layout)
	// {
	// 	if(_game.debugger != null)
	// 		_game.debugger.setLayout(Layout);
	// }

	// /**
	//  * Just resets the debugger windows to whatever the last selected layout was (<code>DEBUGGER_STANDARD</code> by default).
	//  */
	// public static void resetDebuggerLayout()
	// {
	// 	if(_game.debugger != null)
	// 		_game.debugger.resetLayout();
	// }
	
	/**
	 * Add a new camera object to the game.
	 * Handy for PiP, split-screen, etc.
	 * 
	 * @param	NewCamera		The camera you want to add.
	 * @param	addToCameras	If we add the camera to the global list of cameras.
	 * 
	 * @return	This <code>SpiCamera</code> instance.
	 */
	public static function addCamera(NewCamera:SpiCamera, addToCameras:Bool = true):SpiCamera
	{
		displayList.push(NewCamera);
		
		if(addToCameras)
			cameras.push(NewCamera);

		return NewCamera;
	}
	
	/**
	 * Remove a camera from the game.
	 * 
	 * @param	Camera	The camera you want to remove.
	 * @param	Destroy	Whether to call destroy() on the camera, default value is true.
	 */
	public static function removeCamera(Camera:SpiCamera, Destroy:Bool = true):Void
	{
		if(!displayList.remove(Camera))
			log("Error removing camera, not part of game.");
		cameras.remove(Camera);
		if(Destroy)
			Camera.destroy();
	}

	/**
	 * Dumps all the current cameras and resets to just one camera.
	 * Handy for doing split-screen especially.
	 * 
	 * @param	NewCamera	Optional; specify a specific camera object to be the new main camera.
	 */
	public static function resetCameras(NewCamera:SpiCamera = null):Void
	{
		var cam:SpiCamera;
		var i:Int = 0;
		var l:Int = displayList.length;
		while(i < l)
		{
			cam = displayList[i++];
			cam.destroy();
		}
		displayList.splice(0, displayList.length);
		cameras.splice(0, cameras.length);

		if(NewCamera == null)
			NewCamera = new SpiCamera(0, 0, width, height);
		camera = addCamera(NewCamera);
	}
	
	// /**
	//  * All screens are filled with this color and gradually return to normal.
	//  * 
	//  * @param	Color		The color you want to use.
	//  * @param	Duration	How long it takes for the flash to fade.
	//  * @param	OnComplete	A method you want to run when the flash finishes.
	//  * @param	Force		Force the effect to reset.
	//  */
	// public static void flash(int Color, float Duration, ISpiCamera OnComplete, boolean Force)
	// {
	// 	int i = 0;
	// 	int l = cameras.size;
	// 	while(i < l)
	// 		cameras.get(i++).flash(Color,Duration,OnComplete,Force);
	// }
	
	// /**
	//  * All screens are filled with this color and gradually return to normal.
	//  * 
	//  * @param	Color		The color you want to use.
	//  * @param	Duration	How long it takes for the flash to fade.
	//  * @param	OnComplete	A method you want to run when the flash finishes.
	//  */
	// public static void flash(int Color, float Duration, ISpiCamera OnComplete)
	// {
	// 	flash(Color, Duration, OnComplete, false);
	// }
	
	// /**
	//  * All screens are filled with this color and gradually return to normal.
	//  * 
	//  * @param	Color		The color you want to use.
	//  * @param	Duration	How long it takes for the flash to fade.
	//  */
	// public static void flash(int Color, float Duration)
	// {
	// 	flash(Color, Duration, null, false);
	// }
	
	// /**
	//  * All screens are filled with this color and gradually return to normal.
	//  * 
	//  * @param	Color		The color you want to use.
	//  */
	// public static void flash(int Color)
	// {
	// 	flash(Color, 1, null, false);
	// }
	
	// /**
	//  * All screens are filled with this color and gradually return to normal.
	//  */
	// public static void flash()
	// {
	// 	flash(0xFFFFFFFF, 1, null, false);
	// }
	
	// /**
	//  * The screen is gradually filled with this color.
	//  * 
	//  * @param	Color		The color you want to use.
	//  * @param	Duration	How long it takes for the fade to finish.
	//  * @param   FadeIn      True fades from a color, false fades to it.
	//  * @param	OnComplete	A method you want to run when the fade finishes.
	//  * @param	Force		Force the effect to reset.
	//  */
	// public static void fade(int Color, float Duration, boolean FadeIn, ISpiCamera OnComplete, boolean Force)
	// {
	// 	int i = 0;
	// 	int l = cameras.size;
	// 	while(i < l)
	// 		cameras.get(i++).fade(Color, Duration, FadeIn, OnComplete,Force);
	// }

	// /**
	//  * The screen is gradually filled with this color.
	//  * 
	//  * @param	Color		The color you want to use.
	//  * @param	Duration	How long it takes for the fade to finish.
	//  * @param	OnComplete	A method you want to run when the fade finishes.
	//  */
	// public static void fade(int Color, float Duration, ISpiCamera OnComplete)
	// {
	// 	fade(Color, Duration, false, OnComplete, false);
	// }

	// /**
	//  * The screen is gradually filled with this color.
	//  * 
	//  * @param	Color		The color you want to use.
	//  * @param	Duration	How long it takes for the fade to finish.
	//  * @param   FadeIn      True fades from a color, false fades to it.
	//  * @param	OnComplete	A method you want to run when the fade finishes.
	//  */
	// public static void fade(int Color, float Duration, boolean FadeIn, ISpiCamera OnComplete)
	// {
	// 	fade(Color, Duration, FadeIn, OnComplete, false);
	// }

	// /**
	//  * The screen is gradually filled with this color.
	//  * 
	//  * @param	Color		The color you want to use.
	//  * @param	Duration	How long it takes for the fade to finish.
	//  * @param   FadeIn      True fades from a color, false fades to it.
	//  */
	// public static void fade(int Color, float Duration, boolean FadeIn)
	// {
	// 	fade(Color, Duration, FadeIn, null, false);
	// }
	
	// /**
	//  * The screen is gradually filled with this color.
	//  * 
	//  * @param	Color		The color you want to use.
	//  * @param	Duration	How long it takes for the fade to finish.
	//  */
	// public static void fade(int Color, float Duration)
	// {
	// 	fade(Color, Duration, false, null, false);
	// }
	
	// /**
	//  * The screen is gradually filled with this color.
	//  * 
	//  * @param	Color		The color you want to use.
	//  */
	// public static void fade(int Color)
	// {
	// 	fade(Color, 1, false, null, false);
	// }
	
	// /**
	//  * The screen is gradually filled with this color.
	//  */
	// public static void fade()
	// {
	// 	fade(0xFF000000, 1, false, null, false);
	// }
	
	// /**
	//  * A simple screen-shake effect.
	//  * 
	//  * @param	Intensity	Percentage of screen size representing the maximum distance that the screen can move while shaking.
	//  * @param	Duration	The length in seconds that the shaking effect should last.
	//  * @param	OnComplete	A method you want to run when the shake effect finishes.
	//  * @param	Force		Force the effect to reset (default = true, unlike flash() and fade()!).
	//  * @param	Direction	Whether to shake on both axes, just up and down, or just side to side (use class constants SHAKE_BOTH_AXES, SHAKE_VERTICAL_ONLY, or SHAKE_HORIZONTAL_ONLY).  Default value is SHAKE_BOTH_AXES (0).
	//  */
	// public static void shake(float Intensity, float Duration, ISpiCamera OnComplete, boolean Force, int Direction)
	// {
	// 	int i = 0;
	// 	int l = cameras.size;
	// 	while(i < l)
	// 		cameras.get(i++).shake(Intensity, Duration, OnComplete, Force, Direction);
	// }
	
	// /**
	//  * A simple screen-shake effect.
	//  * 
	//  * @param	Intensity	Percentage of screen size representing the maximum distance that the screen can move while shaking.
	//  * @param	Duration	The length in seconds that the shaking effect should last.
	//  * @param	OnComplete	A method you want to run when the shake effect finishes.
	//  * @param	Force		Force the effect to reset (default = true, unlike flash() and fade()!).
	//  */
	// public static void shake(float Intensity, float Duration, ISpiCamera OnComplete, boolean Force)
	// {
	// 	shake(Intensity, Duration, OnComplete, Force, 0);
	// }
	
	// /**
	//  * A simple screen-shake effect.
	//  * 
	//  * @param	Intensity	Percentage of screen size representing the maximum distance that the screen can move while shaking.
	//  * @param	Duration	The length in seconds that the shaking effect should last.
	//  * @param	OnComplete	A method you want to run when the shake effect finishes.
	//  */
	// public static void shake(float Intensity, float Duration, ISpiCamera OnComplete)
	// {
	// 	shake(Intensity, Duration, OnComplete, true, 0);
	// }
	
	// /**
	//  * A simple screen-shake effect.
	//  * 
	//  * @param	Intensity	Percentage of screen size representing the maximum distance that the screen can move while shaking.
	//  * @param	Duration	The length in seconds that the shaking effect should last.
	//  */
	// public static void shake(float Intensity, float Duration)
	// {
	// 	shake(Intensity,Duration,null,true,0);
	// }
	
	// /**
	//  * A simple screen-shake effect.
	//  * 
	//  * @param	Intensity	Percentage of screen size representing the maximum distance that the screen can move while shaking.
	//  */
	// public static void shake(float Intensity)
	// {
	// 	shake(Intensity,0.5f,null,true,0);
	// }
	
	// /**
	//  * A simple screen-shake effect.
	//  */
	// public static void shake()
	// {
	// 	shake(0.05f,0.5f,null,true,0);
	// }
	
	/**
	 * Get and set the background color of the game.
	 * Is equivalent to camera.bgColor.
	 */
	public static function getBgColor():Int
	{
		if(camera == null)
			return 0xff000000;
		else
			return camera.bgColor;
	}

	/**
	 * Set the background color of all the game cameras.
	 */
	public static function setBgColor(Color:Int):Void
	{
		var i:Int = 0;
		var l:Int = cameras.length;
		while(i < l)
			cameras[i++].bgColor = Color;
	}
	
	// /**
	//  * Call this method to see if one <code>SpiObject</code> overlaps another.
	//  * Can be called with one object and one group, or two groups, or two objects,
	//  * whatever floats your boat! For maximum performance try bundling a lot of objects
	//  * together using a <code>SpiGroup</code> (or even bundling groups together!).
	//  * 
	//  * <p>NOTE: does NOT take objects' scrollfactor into account, all overlaps are checked in world space.</p>
	//  * 
	//  * @param	ObjectOrGroup1	The first object or group you want to check.
	//  * @param	ObjectOrGroup2	The second object or group you want to check.  If it is the same as the first, spiller knows to just do a comparison within that group.
	//  * @param	NotifyCallback	A method with two <code>SpiObject</code> parameters - e.g. <code>myOverlapFunction(Object1:SpiObject,Object2:SpiObject)</code> - that is called if those two objects overlap.
	//  * @param	ProcessCallback	A method with two <code>SpiObject</code> parameters - e.g. <code>myOverlapFunction(Object1:SpiObject,Object2:SpiObject)</code> - that is called if those two objects overlap.  If a ProcessCallback is provided, then NotifyCallback will only be called if ProcessCallback returns true for those objects!
	//  * 
	//  * @return	Whether any overlaps were detected.
	//  */
	// public static boolean overlap(SpiBasic ObjectOrGroup1, SpiBasic ObjectOrGroup2, ISpiCollision NotifyCallback, ISpiObject ProcessCallback)
	// {
	// 	if(ObjectOrGroup1 == null)
	// 		ObjectOrGroup1 = getState();
	// 	if(ObjectOrGroup2 == ObjectOrGroup1)
	// 		ObjectOrGroup2 = null;
	// 	SpiQuadTree.divisions = worldDivisions;
	// 	SpiQuadTree quadTree = SpiQuadTree.getNew(worldBounds.x, worldBounds.y, worldBounds.width, worldBounds.height, null);
	// 	quadTree.load(ObjectOrGroup1, ObjectOrGroup2, NotifyCallback, ProcessCallback);
	// 	boolean result = quadTree.execute();
	// 	quadTree.destroy();
	// 	return result;
	// }
	
	// /**
	//  * Call this method to see if one <code>SpiObject</code> overlaps another.
	//  * Can be called with one object and one group, or two groups, or two objects,
	//  * whatever floats your boat! For maximum performance try bundling a lot of objects
	//  * together using a <code>SpiGroup</code> (or even bundling groups together!).
	//  *    
	//  * <p>NOTE: does NOT take objects' scrollfactor into account, all overlaps are checked in world space.</p>
	//  * 
	//  * @param	ObjectOrGroup1	The first object or group you want to check.
	//  * @param	ObjectOrGroup2	The second object or group you want to check.  If it is the same as the first, spiller knows to just do a comparison within that group.
	//  * @param	NotifyCallback	A method with two <code>SpiObject</code> parameters - e.g. <code>myOverlapFunction(Object1:SpiObject,Object2:SpiObject)</code> - that is called if those two objects overlap.
	//  * 
	//  * @return	Whether any oevrlaps were detected.
	//  */
	// public static boolean overlap(SpiBasic ObjectOrGroup1, SpiBasic ObjectOrGroup2, ISpiCollision NotifyCallback)
	// {
	// 	return overlap(ObjectOrGroup1, ObjectOrGroup2, NotifyCallback, null);
	// }
	
	// /**
	//  * Call this method to see if one <code>SpiObject</code> overlaps another.
	//  * Can be called with one object and one group, or two groups, or two objects,
	//  * whatever floats your boat! For maximum performance try bundling a lot of objects
	//  * together using a <code>SpiGroup</code> (or even bundling groups together!).
	//  * 
	//  * <p>NOTE: does NOT take objects' scrollfactor into account, all overlaps are checked in world space.</p>
	//  * 
	//  * @param	ObjectOrGroup1	The first object or group you want to check.
	//  * @param	ObjectOrGroup2	The second object or group you want to check.  If it is the same as the first, spiller knows to just do a comparison within that group.
	//  * 
	//  * @return	Whether any oevrlaps were detected.
	//  */
	// public static boolean overlap(SpiBasic ObjectOrGroup1, SpiBasic ObjectOrGroup2)
	// {
	// 	return overlap(ObjectOrGroup1, ObjectOrGroup2, null, null);
	// }
	
	// /**
	//  * Call this method to see if one <code>SpiObject</code> overlaps another.
	//  * Can be called with one object and one group, or two groups, or two objects,
	//  * whatever floats your boat! For maximum performance try bundling a lot of objects
	//  * together using a <code>SpiGroup</code> (or even bundling groups together!).
	//  * 
	//  * <p>NOTE: does NOT take objects' scrollfactor into account, all overlaps are checked in world space.</p>
	//  * 
	//  * @param	ObjectOrGroup1	The first object or group you want to check.
	//  * 
	//  * @return	Whether any oevrlaps were detected.
	//  */
	// public static boolean overlap(SpiBasic ObjectOrGroup1)
	// {
	// 	return overlap(ObjectOrGroup1, null, null, null);
	// }
	
	// /**
	//  * Call this method to see if one <code>SpiObject</code> overlaps another.
	//  * Can be called with one object and one group, or two groups, or two objects,
	//  * whatever floats your boat! For maximum performance try bundling a lot of objects
	//  * together using a <code>SpiGroup</code> (or even bundling groups together!).
	//  * 
	//  * <p>NOTE: does NOT take objects' scrollfactor into account, all overlaps are checked in world space.</p>
	//  * 
	//  * @return	Whether any overlaps were detected.
	//  */
	// public static boolean overlap()
	// {
	// 	return overlap(null, null, null, null);
	// }
	
	/**
	 * Call this method to see if one <code>SpiObject</code> collides with another.
	 * Can be called with one object and one group, or two groups, or two objects,
	 * whatever floats your boat! For maximum performance try bundling a lot of objects
	 * together using a <code>SpiGroup</code> (or even bundling groups together!).
	 * 
	 * <p>This method just calls overlap and presets the ProcessCallback parameter to SpiObject.separate.
	 * To create your own collision logic, write your own ProcessCallback and use overlap to set it up.</p>
	 * 
	 * <p>NOTE: does NOT take objects' scrollfactor into account, all overlaps are checked in world space.</p>
	 * 
	 * @param	ObjectOrGroup1	The first object or group you want to check.
	 * @param	ObjectOrGroup2	The second object or group you want to check.  If it is the same as the first, spiller knows to just do a comparison within that group.
	 * @param	NotifyCallback	A method with two <code>SpiObject</code> parameters - e.g. <code>myOverlapFunction(Object1:SpiObject,Object2:SpiObject)</code> - that is called if those two objects overlap.
	 * 
	 * @return	Whether any objects were successfully collided/separated.
	 */
	public static function collide(?ObjectOrGroup1:SpiBasic = null, ?ObjectOrGroup2:SpiBasic = null, ?NotifyCallback:SpiObject->SpiObject->Void = null):Bool
	{	
		return false;	
	//TODO	return overlap(ObjectOrGroup1, ObjectOrGroup2, NotifyCallback, separate);
	}
	
	/**
	 * Adds a new plugin to the global plugin array.
	 * 
	 * @param	Plugin	Any object that extends SpiBasic. Useful for managers and other things.  See spiller.plugin for some examples!
	 * 
	 * @return	The same <code>SpiBasic</code>-based plugin you passed in.
	 */
	public static function addPlugin(Plugin:SpiBasic):SpiBasic
	{
		// Don't add repeats
		var pluginList:Array<SpiBasic> = plugins;
		var i:Int = 0;
		var l:Int = pluginList.length;

		while(i < l) {
			if(pluginList[i].type == Plugin.type)
				return Plugin;
		}
		
		// no repeats! safe to add a new instance of this plugin
		pluginList.push(Plugin);
		return Plugin;
	}

	/**
	 * Retrieves a plugin based on its class name from the global plugin array.
	 * 
	 * @param	ClassType	The class name of the plugin you want to retrieve. See the <code>SpiPath</code> or <code>SpiTimer</code> constructors for example usage.
	 * 
	 * @return	The plugin object, or null if no matching plugin was found.
	 */
	public static function getPlugin(ClassType:SpiType):SpiBasic
	{
		var pluginList:Array<SpiBasic> = plugins;
		var i:Int = 0;
		var l:Int = pluginList.length;
		while(i < l) {
			if(pluginList[i].type == ClassType)
				return plugins[i];
			i++;
		}
		return null;
	}
		
	/**
	 * Removes an instance of a plugin from the global plugin array.
	 * 
	 * @param	Plugin	The plugin instance you want to remove.
	 * 
	 * @return	The same <code>SpiBasic</code>-based plugin you passed in.
	 */
	public static function removePlugin(Plugin:SpiBasic):SpiBasic
	{
		var pluginList:Array<SpiBasic> = plugins;
		var i:Int = pluginList.length - 1;

		while(i >= 0) {
			if(pluginList[i] == Plugin)
				pluginList.splice(i, 1);
			i--;
		}
		return Plugin;
	}
	
	/**
	 * Removes an instance of a plugin from the global plugin array.
	 * 
	 * @param	ClassType	The class name of the plugin type you want removed from the array.
	 * 
	 * @return	Whether or not at least one instance of this plugin type was removed.
	 */
	public static function removePluginType(ClassType:SpiType):Bool
	{
		var results:Bool = false;
		var pluginList:Array<SpiBasic> = plugins;
		var i:Int = pluginList.length - 1;

		while(i >= 0) {
			if(pluginList[i].type == ClassType) {
				pluginList.splice(i, 1);
				results = true;
			}
			i--;
		}
		return results;
	}
	
	/**
	 * Called by <code>SpiGame</code> to set up <code>SpiG</code> during <code>SpiGame</code>'s constructor.
	 */
	private static function init(Game:SpiGame, Width:Int, Height:Int, Zoom:Float, ScaleMode:Int):Void
	{
		// Set the game stuff
		_game = Game;
		width = Width;
		height = Height;
		
		// Set the sound stuff
		sounds = new SpiGroup();
		volumeHandler = new SpiVolumeHandler();
		music = null;

		// Initialize all the SpiG general variables
		_cache = new SpiAssetManager();
		
		SpiCamera.defaultZoom = Zoom;
		SpiCamera.defaultScaleMode = ScaleMode;
		cameras = new Array<SpiCamera>();
		displayList = new Array<SpiCamera>();
		spriteLightning = new SpiLightning();
		camera = null;

		// Set the plugin stuff
		plugins = new Array<SpiBasic>();
	// 	addPlugin(new SpiDebugPathDisplay());
		addPlugin(new SpiTimerManager());
		
		// Set the input stuff
		mouse = new SpiMouse();
		touch = mouse;
		keys = new SpiKeyboard();
	// 	accelerometer = new SpiAccelerometer();
	// 	externals = new SpiExternalInput();

		levels = new Array<Dynamic>();
		scores = new Array<Int>();
		visualDebug = false;
		
	// 	_floatArray = new float[4];
		
	// 	shaders = new ObjectMap<String, SpiShaderProgram>();
	}
	
	/**
	 * Called whenever the game is reset, doesn't have to do quite as much work as the basic initialization stuff.
	 */
	private static function reset():Void
	{
		clearBitmapCache();
		resetInput();
		destroySounds(true);
	// 	stopVibrate();
	// 	destroyShaders();

		levels.splice(0, levels.length);
		scores.splice(0, scores.length);
		level = 0;
		score = 0;
		paused = false;
		fixedTimestep = true;
		maxElapsed = 0.1;
		timeScale = 1.0;
		elapsed = 0;
	// 	globalSeed = SpiU.getSeed();
	// 	SpiU.setSeed(globalSeed);
		worldBounds = new SpiRect(-10, -10, width + 20, height + 20);
		worldDivisions = 6;
		spriteLightning.clear();
	// 	SpiDebugPathDisplay debugPathDisplay = (SpiDebugPathDisplay) getPlugin(SpiDebugPathDisplay.class);
	// 	if(debugPathDisplay != null)
	// 		debugPathDisplay.clear();
	//
	 	random.resetInitialSeed();
	}
	
	/**
	 * Called by the game object to update the keyboard and mouse input tracking objects.
	 */
	public static function updateInput():Void
	{
		// Update the specific mobile phone inputs
		// accelerometer.update();
		// externals.update();

		// Update the Keyboard inputs
		keys.update();

		#if SPI_DEBUG
		if(!_game.debuggerUp || !_game.debugger.hasMouse) {
		#end
			mouse.update();
		#if SPI_DEBUG
		}
		#end
	}
	
	/**
	 * Called by the game object to lock all the camera buffers and clear them for the next draw pass.  
	 */
	public static function lockCameras():Void
	{
		var camera:SpiCamera = activeCamera;
		
		// // If the app is an iOS app do not cut the screen
		// if(Gdx.app.getType() != ApplicationType.iOS) {
		// 	// Set the drawing area		
		// 	int scissorWidth = SpiU.ceil(camera.width * camera._screenScaleFactorX * camera.getZoom());
		// 	int scissorHeight = SpiU.ceil(camera.height * camera._screenScaleFactorY * camera.getZoom());
		// 	int scissorX = (int) (camera.x * camera._screenScaleFactorX);
		// 	int scissorY = (int) (screenHeight - ((camera.y * camera._screenScaleFactorY) + scissorHeight));
		// 	gl.glScissor(scissorX, scissorY, scissorWidth, scissorHeight);
		// } else {
		// 	gl.glScissor(0, 0, Gdx.graphics.getWidth(), Gdx.graphics.getHeight());
		// }
			
		// Clear the camera
		// if(((camera.bgColor >> 24) & 0xff) == 0xFF)
		// {
		// 	int color = SpiU.multiplyColors(camera.bgColor, camera.getColor());
		// 	_floatArray = SpiU.getRGBA(color, _floatArray);
		// 	gl.glClearColor(_floatArray[0] * 0.00392f, _floatArray[1] * 0.00392f, _floatArray[2] * 0.00392f, 1.0f);
		// 	gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
		// } else
		// // Clear camera if needed
		// if(camera.bgColor != 0x0)
		// {
		// 	camera.fill(camera.bgColor);
		// }

		// // Set tint
		// _floatArray = SpiU.getRGBA(camera.getColor(), _floatArray);
		// batch.setColor(_floatArray[0] * 0.00392f, _floatArray[1] * 0.00392f, _floatArray[2] * 0.00392f, 1.0f);

		// // Set matrix
		// batch.setProjectionMatrix(camera.glCamera.combined);
		// flashGfx.setProjectionMatrix(camera.glCamera.combined);

		// // Get ready for drawing
		// batch.begin();
		// flashGfx.begin();
	}
	
	/**
	 * Called by the game object to draw the special FX and unlock all the camera buffers.
	 */
	public static function unlockCameras():Void
	{
		var camera:SpiCamera = activeCamera;
		
		// batch.end();
		flashGfx.end();
		
		// camera.drawFX();
	}
	
	/**
	 * Called by the game object to update the cameras and their tracking/special effects logic.
	 */
	public static function updateCameras():Void
	{
		var cam:SpiCamera;
		var cams:Array<SpiCamera> = cameras;
		var i:Int = 0;
		var l:Int = cams.length;
		while(i < l)
		{
			cam = cams[i++];
			if((cam != null) && cam.exists)
			{
				if(cam.active)
					cam.update();
				//TODO cam.glCamera.position.x = cam._flashOffsetX - (cam.x / cam.getZoom());
				//TODO cam.glCamera.position.y = cam._flashOffsetY - (cam.y / cam.getZoom());
			}
		}
	}
	
	/**
	 * Used by the game object to call <code>update()</code> on all the plugins.
	 */
	public static function updatePlugins():Void
	{
		var plugin:SpiBasic;
		var pluginList:Array<SpiBasic> = plugins;
		var i:Int = 0;
		var l:Int = pluginList.length;
		while(i < l)
		{
			plugin = pluginList[i++];
			if(plugin.exists && plugin.active)
				plugin.update();
		}
	}

	/**
	 * Used by the game object to call <code>draw()</code> on all the plugins.
	 */
	public static function drawPlugins():Void
	{
		// Start the part of the screen where the plugins will be drawn
		flashGfx.begin();
		
		var plugin:SpiBasic;
		var pluginList:Array<SpiBasic> = plugins;
		var i:Int = 0;
		var l:Int = pluginList.length;
		while(i < l)
		{
			plugin = pluginList[i++];
			if(plugin.exists && plugin.visible)
				plugin.draw();
		}
		
		flashGfx.end();
	}
	
	// /**
	//  * Vibrates for the given amount of time. Note that you'll need the permission
	//  * <code> <uses-permission android:name="android.permission.VIBRATE" /></code> in your manifest file in order for this to work.

	//  * @param Milliseconds	The amount of time to vibrate for.
	//  */
	// public static void vibrate(int Milliseconds)
	// {
	// 	Gdx.input.vibrate(Milliseconds);
	// }
	
	// /**
	//  * Vibrates for the given amount of time. Note that you'll need the permission
	//  * <code> <uses-permission android:name="android.permission.VIBRATE" /></code> in your manifest file in order for this to work.
	//  */
	// public static void vibrate()
	// {
	// 	vibrate(1000);
	// }

	// /** 
	//  * Vibrate with a given pattern. Pass in an array of ints that are the times at which to turn on or off the vibrator. The first
	//  * one is how long to wait before turning it on, and then after that it alternates. If you want to repeat, pass the index into
	//  * the pattern at which to start the repeat.
	//  * 
	//  * @param Pattern	An array of longs of times to turn the vibrator on or off.
	//  * @param Repeat	The index into pattern at which to repeat, or -1 if you don't want to repeat. 
	//  * */
	// public static void vibrate(long[] Pattern, int Repeat)
	// {
	// 	Gdx.input.vibrate(Pattern, Repeat);
	// }	
	
	// /**
	//  * Stops the vibrator.
	//  */
	// public static void stopVibrate()
	// {
	// 	try {
	// 		Gdx.input.cancelVibrate();
	// 	} catch (Exception e) {
	// 		log(e.getMessage());
	// 	}
	// }

	// /**
	//  * Change the Pause Screen.
	//  */
	// public static SpiPause getPauseGroup()
	// {
	// 	return _game._pause; 
	// }

	// /**
	//  * Exits the application.
	//  */
	// public static void exit()
	// {
	// 	if(alertManager != null && Gdx.app.getType() != ApplicationType.Desktop)
	// 		alertManager.showExitAlert();
	// 	else
	// 		Gdx.app.exit();
	// }

	// /**
	//  * A helper method.
	//  * This method equals: SpiLanguagesManager.getInstance().getString(string)
	//  */
	// public static String getString(String s)
	// {
	// 	return SpiLanguagesManager.getInstance().getString(s);
	// }

	// /**
	//  * Returns the total time since the game started.
	//  */
	// public static long getTotal()
	// {
	// 	return _game._total;
	// }

	// /**
	//  * Tweens numeric public properties of an Object. Shorthand for creating a MultiVarTween tween,
	//  * starting it and adding it to a Tweener.
	//  * 
	//  * @param	object		The object containing the properties to tween.
	//  * @param	values		An object containing key/value pairs of properties and target values.
	//  * @param	duration	Duration of the tween.
	//  * @param	options		An object containing key/value pairs of the following optional parameters:
	//  * 						type		Tween type.
	//  * 						complete	Optional completion callback function.
	//  * 						ease		Optional easer function.
	//  * 						tweener		The Tweener to add this Tween to.
	//  * @return	The added MultiVarTween object.
	//  */
	// public static MultiVarTween tween(SpiBasic object, HashMap<String, Float> values, float duration, TweenOptions options)
	// {
	// 	int type = SpiTween.ONESHOT;
	// 	ISpiTween complete = null;
	// 	ISpiTweenEase ease = null;
	// 	SpiBasic tweener = SpiG.tweener;

	// 	if (options != null) {
	// 		type = options.type;
	// 		complete = options.complete;
	// 		ease = options.ease;
	// 		tweener = options.tweener;
	// 	}

	// 	MultiVarTween tween = new MultiVarTween(complete, type);
	// 	tween.tween(object, values, duration, ease);
	// 	tweener.addTween(tween);
	// 	return tween;
	// }

	// /**
	//  * Tweens numeric public properties of an Object. Shorthand for creating a MultiVarTween tween,
	//  * starting it and adding it to a Tweener.
	//  * 
	//  * @param	object		The object containing the properties to tween.
	//  * @param	values		An object containing key/value pairs of properties and target values.
	//  * @param	duration	Duration of the tween.
	//  * @return	The added MultiVarTween object.
	//  */
	// public static MultiVarTween tween(SpiBasic object, HashMap<String, Float> values, float duration)
	// {
	// 	return tween(object, values, duration, null);
	// }

	// /**
	//  * Set the global seed.
	//  */
	// public static void setGlobalSeed(long seed)
	// {
	// 	globalSeed = seed;
	// 	SpiU.setSeed(seed);
	// }
	
	// /**
	//  * Get the global seed.
	//  */
	// public static long getGlobalSeed()
	// {
	// 	return globalSeed;
	// }
	
	// /**
	//  * Generate a new random global seed.
	//  */
	// public static void generateNewGlobalSeed()
	// {
	// 	setGlobalSeed(new Random().nextLong());
	// }
	
	// /**
	//  * Get the device type.
	//  */
	// public static String getDeviceType()
	// {
	// 	String type = "";
		
	// 	if(SpiG.isAmazon) {
	// 		type = "amazon";
	// 	} else if(Gdx.app.getType() == ApplicationType.Android) {
	// 		type = "android";
	// 	} else if(Gdx.app.getType() == ApplicationType.iOS) {
	// 		type = "ios";
	// 	} else if(Gdx.app.getType() == ApplicationType.Desktop) {
	// 		type = "pc";
	// 	}

	// 	return type;
	// }
	
	// /**
	//  * Load <code>ShaderProgram</code> from file and cache it.
	//  * 
	//  * @param Name The name of the shader program.
	//  * @param Vertex The path to the vertex file.
	//  * @param Fragment The path to the fragment file.
	//  * @param callback The callback that will be fired on resume.
	//  * @return The <code>Shader Program</code> that needed to be loaded.
	//  */
	// public static SpiShaderProgram loadShader(String Name, String Vertex, String Fragment, ISpiShaderProgram callback)
	// {
	// 	ShaderProgramParameter parameter = new ShaderProgramParameter();
	// 	parameter.vertex = Vertex;
	// 	parameter.fragment = Fragment;
	// 	parameter.callback = callback;

	// 	SpiShaderProgram shader = SpiG._cache.load(Name, SpiShaderProgram.class, parameter);
	// 	shaders.put(Name, shader);
	// 	return shader;
	// }

	// /**
	//  * Load <code>ShaderProgram</code> from file and cache it. WARNING: the
	//  * uniforms will be lost if there is no callback set.
	//  * 
	//  * @param Name The name of the shader program.
	//  * @param Vertex The path to the vertex file.
	//  * @param Fragment The path to the fragment file.
	//  * @return The <code>Shader Program</code> that needed to be loaded.
	//  */
	// public static SpiShaderProgram loadShader(String Name, String Vertex, String Fragment)
	// {
	// 	return loadShader(Name, Vertex, Fragment, null);
	// }

	// /**
	//  * Free memory by disposing a <code>ShaderProgram</code> and removing it
	//  * from the cache if there are no dependencies.
	//  * 
	//  * @param Name The name of the shader.
	//  */
	// public static void disposeShader(String Name)
	// {
	// 	if(SpiG._cache.containsAsset(Name))
	// 		SpiG._cache.unload(Name);
	// 	shaders.remove(Name);
	// }

	// /**
	//  * Check whether the <code>ShaderProgram</code> compiled successfully. It
	//  * will also log any warnings if they exist.
	//  * 
	//  * @param program The ShaderProgram that needs to checked.
	//  * @return boolean
	//  */
	// public static boolean isShaderCompiled(String fileName, ShaderProgram program)
	// {
	// 	if(!program.isCompiled())
	// 	{
	// 		log(fileName + " " + program.getLog());
	// 		System.exit(0);
	// 		return false;
	// 	}
	// 	if(program.getLog().length() != 0 && !program.getLog().indexOf("WARNING")) {
	// 		log(fileName + " " + program.getLog());
	// 		return false;
	// 	}
	// 	return true;
	// }

	// /**
	//  * Restores the data for the <code>ProgramShader</code>s.<br>
	//  * Isn't applied to desktop.
	//  */
	// public static void restoreShaders()
	// {
	// 	if(!SpiG.mobile)
	// 		return;

	// 	Iterator<SpiShaderProgram> entries = shaders.values().iterator();
	// 	while(entries.hasNext())
	// 	{
	// 		entries.next().loadShaderSettings();
	// 	}
	// }

	// /**
	//  * Destroys all shaders.
	//  */
	// public static void destroyShaders()
	// {
	// 	SpiG._cache.disposeAssets(SpiShaderProgram.class);
	// 	shaders.clear();
	// 	batchShader = null;
	// }
	
	/**
	 * Preload the lightning textures in order to check for flushing.
	 * 
	 * @param texture
	 * @param normals
	 * @param specular
	 */
	public static function preloadLightning(texture:Image, normals:Image):Void
	{
		spriteLightning.preloadLightning(texture, normals);
	}
	
	// /**
	//  * Start full screen
	//  * @param fullscreen 
	//  */
	// public static void fullscreen(boolean fullscreen)
	// {
	// 	// Turn on full screen
	// 	if(fullscreen) {
	// 		DisplayMode finalMode = null;

	// 		try {
	// 			DisplayMode[] modes = Gdx.graphics.getDisplayModes();

	// 			for (int i = 0; i < modes.length; i++) {
	// 				DisplayMode current = modes[i];
					
	// 				// Check for exact resolution
	// 				if (current.width == width && current.height == height) {
	// 					finalMode = current;
	// 					break; // Cancel search
	// 				} else
	// 				// Check for width resolution
	// 				if (finalMode == null && current.width == width && current.height >= height ) {
	// 					finalMode = current;
	// 				} else
	// 				// Check for height resolution
	// 				if (finalMode == null && current.height == height && current.width >= width) {
	// 					finalMode = current;
	// 				}
	// 			}
	// 		} catch (Exception ex) {
	// 		}

	// 		// Check if we can turn on full screen
	// 		if(finalMode != null) {
	// 			SpiG.log("Size updated to width: " + finalMode.width + " height: " + finalMode.height + ".");
	//             Gdx.graphics.setDisplayMode(finalMode.width, finalMode.height, true);
	//             Gdx.input.setCursorCatched(true);
	// 		}
	// 	} else {
	// 		Gdx.graphics.setDisplayMode(SpiG.width, SpiG.height, false);
	// 		Gdx.input.setCursorCatched(false);
	// 	}
	// }

	//==========================================================================//
	//								CALLBACKS									//
	//==========================================================================//
	/**
	 * Set this hook to get a callback whenever the volume changes.
	 * Function should take the form <code>myVolumeHandler(Volume:Number)</code>.
	 */
	private static function volumeCallback(volume:Float, type:Int)
	{
		switch(type) {
			case SpiSound.MUSIC:
				if(music != null)
					music.setVolume(volume);

			case SpiSound.SFX:
				// Update all the sounds
				for(i in 0 ... sounds.members.length) {
					cast (sounds.members[i], SpiSound).setVolume(volume);
				}

			case SpiSound.ALL:
				if(music != null)
					music.setVolume(volume);

				// Update all the sounds
				for(i in 0 ... sounds.members.length) {
					cast (sounds.members[i], SpiSound).setVolume(volume);
				}
		}
	}

	// /**
	//  * Internal callback method for collision.
	//  */
	// private static ISpiObject separate = new ISpiObject()
	// {				
	// 	override
	// 	public boolean callback(SpiObject Object1, SpiObject Object2)
	// 	{
	// 		return SpiObject.separate(Object1, Object2);
	// 	}
	// };
}