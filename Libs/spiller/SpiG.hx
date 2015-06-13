package spiller;
/*
import java.util.HashMap;
import java.util.Iterator;
import java.util.Random;

import com.badlogic.gdx.Application.ApplicationType;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Graphics.DisplayMode;
import com.badlogic.gdx.InputMultiplexer;
import com.badlogic.gdx.assets.loaders.BitmapFontLoader.BitmapFontParameter;
import com.badlogic.gdx.assets.loaders.TextureLoader.TextureParameter;
import com.badlogic.gdx.assets.loaders.resolvers.ResolutionFileResolver.Resolution;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.Pixmap;
import com.badlogic.gdx.graphics.Pixmap.Format;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.TextureData;
import com.badlogic.gdx.graphics.g2d.BitmapFont;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g2d.TextureAtlas;
import com.badlogic.gdx.graphics.g2d.TextureAtlas.AtlasRegion;
import com.badlogic.gdx.graphics.glutils.ShaderProgram;
import com.badlogic.gdx.math.MathUtils;

import com.badlogic.gdx.utils.IntArray;
import com.badlogic.gdx.utils.ObjectMap;
import com.badlogic.gdx.utils.reflect.ClassReflection;
import spiller.event.ISpiCamera;
import spiller.event.ISpiCollision;
import spiller.event.ISpiObject;
import spiller.event.ISpiReplay;
import spiller.event.ISpiShaderProgram;
import spiller.event.ISpiTween;
import spiller.event.ISpiTweenEase;
import spiller.event.ISpiVolume;
import spiller.gl.SpiManagedTextureData;
import spiller.gl.SpiShaderProgram;
import spiller.plugin.SpiDebugPathDisplay;
import spiller.plugin.SpiLanguagesManager;
import spiller.plugin.SpiPause;
import spiller.plugin.SpiPause.PauseEvent;
import spiller.plugin.SpiRotation;
import spiller.plugin.SpiTimerManager;
import spiller.plugin.SpiUpdateFPS;
import spiller.plugin.ads.SpiAdManager;
import spiller.plugin.api.SpiAlertManager;
import spiller.plugin.api.SpiMoreGames;
import spiller.plugin.api.SpiPNManager;
import spiller.plugin.api.SpiSocialGames;
import spiller.plugin.inapp.SpiInAppManager;
import spiller.plugin.lighting.SpiLightning;
import spiller.plugin.store.SpiSave;
import spiller.plugin.tweens.SpiTween;
import spiller.plugin.tweens.misc.MultiVarTween;
import spiller.plugin.tweens.util.TweenOptions;
import spiller.system.SpiAssetManager;
import spiller.system.SpiQuadTree;
import spiller.system.SpiVolumeHandler;
import spiller.system.flash.Graphics;
import spiller.system.flash.SpiGameStage;
import spiller.system.gdx.loaders.SpiShaderLoader.ShaderProgramParameter;
import spiller.system.input.SpiAccelerometer;
import spiller.system.input.SpiExternalInput;
import spiller.system.input.SpiKeyboard;
import spiller.system.input.SpiMouse;
import spiller.system.replay.SpiReplay;
*/

import spiller.math.SpiRandom;
import spiller.math.SpiPoint;
import spiller.math.SpiRect;

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
 * @author Ka Wing Chin
 * @author Thomas Weston
 */
@:allow(spiller)
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
	// /**
	//  * Some handy color presets.  Less glaring than pure RGB full values.
	//  * Primarily used in the visual debugger mode for bounding box displays.
	//  * Red is used to indicate an active, movable, solid object.
	//  */
	// public static inline var RED = 0xffff0012;
	// /**
	//  * Green is used to indicate solid but immovable objects.
	//  */
	// public static inline var GREEN = 0xff00f225;
	// /**
	//  * Blue is used to indicate non-solid objects.
	//  */
	// public static inline var BLUE = 0xff0090e9;
	// /**
	//  * Pink is used to indicate objects that are only partially solid, like one-way platforms.
	//  */
	// public static inline var PINK = 0xfff01eff;
	// /**
	//  * White... for white stuff.
	//  */
	// public static inline var WHITE = 0xffffffff;
	// /**
	//  * And black too.
	//  */
	// public static inline var BLACK = 0xff000000;
	// /**
	//  * Why not some yellow as well?
	//  */
	// public static inline var YELLOW = 0xFFFFFF00;
	/**
	 * Internal tracker for game object.
	 */
	private static var _game:SpiGame;
	// /**
	//  * Handy shared variable for implementing your own pause behavior.
	//  */
	// public static boolean paused;
	// /**
	//  * Whether you are running in Debug or Release mode.
	//  * Set automatically by <code>SpiPreloader</code> during startup.
	//  */
	// public static boolean debug;
	// /**
	//  * Whether we show the FPS or not.
	//  */
	// public static boolean showFPS;
	// /**
	//  * Handy shared variable to check if the pause is on or off.
	//  */
	// private static boolean _disablePause;
	// /**
	//  * WARNING: Changing this can lead to issues with physics<br>
	//  * and the recording system.<br>
	//  * Setting this to false might lead to smoother animations<br>
	//  * (even at lower fps) at the cost of physics accuracy.
	//  */
	// public static boolean fixedTimestep = true;
	// /**
	//  * Useful when the timestep is NOT fixed (i.e. variable),<br>
	//  * to prevent jerky movement or erratic behavior at very low fps.<br>
	//  * Essentially locks the framerate to a minimum value - any slower and<br>
	//  * you'll get slowdown instead of frameskip; default is 1/10th of a second.
	//  */
	// public static float maxElapsed = 0.1f;
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
	// /**
	//  * Setting this to true will disable/skip stuff that isn't necessary for mobile platforms like Android. [BETA]
	//  */
	// public static boolean mobile;
	// /**
	//  * The global random number generator seed (for deterministic behavior in recordings and saves).
	//  */
	// private static long globalSeed;
	// /**
	//  * All the levels you have completed.
	//  */
	// public static Array<Object> levels;
	// /**
	//  * The current level.
	//  */
	// public static int level;
	// /**
	//  * The scores accomplished each level.
	//  */
	// public static IntArray scores;
	// /**
	//  * The current score.
	//  */
	// public static int score;
	// /**
	//  * <code>saves</code> is a generic bucket for storing
	//  * SpiSaves so you can access them whenever you want.
	//  */
	// public static Array<SpiSave> saves;
	// /**
	//  * The current save.
	//  */
	// public static int save;
	// /**
	//  * An InputProcessor that delegates to an ordered list of other InputProcessors.
	//  * Delegation for an event stops if a processor returns true, which indicates that the event was handled.
	//  */
	// public static InputMultiplexer inputs; 
	// /**
	//  * A reference to a <code>SpiMouse</code> object.  Important for input!
	//  * Referenced also as touch for code reading.
	//  */
	// public static SpiMouse touch, mouse;
	// /**
	//  * A reference to a <code>SpiKeyboard</code> object.  Important for input!
	//  */
	// public static SpiKeyboard keys;
	// /**
	//  * If we fire an event after each key down event.<br>
	//  * This could be handy to configuring player specific keys.<br>
	//  * Default = false<br>
	//  */
	// public static boolean fireEvent = false;
	// /**
	//  * A reference to a <code>SpiAccelerometer</code> object. Important for input!
	//  */
	// public static SpiAccelerometer accelerometer;
	// /**
	//  * A reference to any <code>SpiExternalInput</code> objects. Important for input!
	//  */
	// public static SpiExternalInput externals;
	// /**
	//  * A handy container for a background music object.
	//  */
	// public static SpiSound music;
	// /**
	//  * A list of all the sounds being played in the game.
	//  */
	// public static SpiGroup sounds;
	// /**
	//  * Internal volume level, used for global sound control.
	//  */
	// private static SpiVolumeHandler volumeHandler;
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
	// /**
	//  * Allows you to possibly slightly optimize the rendering process IF
	//  * you are not doing any pre-processing in your game state's <code>draw()</code> call.
	//  * @default false
	//  */
	// public static boolean useBufferLocking;
	// /**
	//  * An array container for <code>ShaderProgram</code>s.
	//  */
	// public static ObjectMap<String, SpiShaderProgram> shaders;
	// /**
	//  * This <code>ShaderProgram</code> will be used for
	//  * <code>SpriteBatch.setShader()</code> only.
	//  */
	// public static ShaderProgram batchShader;
	// /**
	//  * An array container for plugins.
	//  * By default spiller uses a couple of plugins:
	//  * SpiDebugPathDisplay, and SpiTimerManager.
	//  */
	// public static Array<SpiBasic> plugins; 
	// /**
	//  * Useful helper objects for doing Flash-specific rendering.
	//  * Primarily used for "debug visuals" like drawing bounding boxes directly to the screen buffer.
	//  */
	// public static Graphics flashGfx;
	// /**
	//  * Internal storage system to prevent assets from being used repeatedly in memory.
	//  */
	// public static SpiAssetManager _cache;
	// /**
	//  * Global <code>SpriteBatch</code> for rendering sprites to the screen.
	//  */
	// public static SpriteBatch batch;
	// /**
	//  * Internal reference to OpenGL.
	//  */
	// public static GL20 gl;
	/**
	 * The camera currently being drawn.
	 */
	private static var activeCamera:SpiCamera;
	// /**
	//  * The sprite lightning plugin.
	//  */
	// public static SpiLightning spriteLightning;
	// /**
	//  * Internal, a pre-allocated array to prevent <code>new</code> calls.
	//  */
	// private static float[] _floatArray;
	// /**
	//  * Global tweener for tweening between multiple worlds
	//  */
	// public static SpiBasic tweener = new SpiBasic();
	// /**
	//  * If there have been a state change request.
	//  */
	// public static boolean stateChange;
	// /**
	//  * Helper to refer a (1, 1) SpiPoint.
	//  */
	// public static final SpiPoint basicPoint = SpiPoint.get(1, 1);

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

	// /**
	//  * Get the current stack trace.
	//  */
	// public static String getStackTrace()
	// {
	// 	StackTraceElement[] st = Thread.currentThread().getStackTrace();
	// 	StringBuffer buf = new StringBuffer();
	// 	for(int i = 0; i < st.length; i++)
	// 		buf.append("StackTrace"+ " "+ st[i] + "\n");
	// 	return buf.toString();
	// }

	// /**
	//  * Disable the pause system.
	//  * 
	//  * @param Pause		If we disable the pause system or not.
	//  */
	// public static void setDisablePause(boolean Pause)
	// {
	// 	_disablePause = Pause;
	// }

	// /**
	//  * Return the true if we disabled the pause system.
	//  */
	// public static boolean getDisablePause()
	// {
	// 	return _disablePause;
	// }


	// /**
	//  * Check if the game is paused or not.
	//  */
	// public static boolean getPause()
	// {
	// 	return paused;
	// }
	
	// /**
	//  * Check if the game is focused or not.
	//  */
	// public static boolean isFocus()
	// {
	// 	return !_game._lostFocus;
	// }

	// /**
	//  * Return the game instance (DANGEROUS!!!)
	//  */
	// public static SpiGame getGame()
	// {
	// 	return _game;
	// }

	// /**
	//  * This method pause/unpause the game. Only do something if the game was not in the pause/unpause state.
	//  */
	// public static void setPause(boolean pause)
	// {
	// 	if(_disablePause) {
	// 		boolean op = paused;
	// 		paused = pause;
	// 		if(paused != op) {
	// 			if(paused) pauseAudio();
	// 			else resumeAudio();
	// 		}
	// 		return;
	// 	}

	// 	boolean op = paused;
	// 	paused = pause;
	// 	if(paused != op) {
	// 		if(paused) {
	// 			pauseAudio();
				
	// 			// Dispatch pause event
	// 			if(SpiG.getStage() != null)
	// 				SpiG.getStage().dispatchEvent(PauseEvent.getEvent(PauseEvent.PAUSE_IN));
	// 		} else {
	// 			resumeAudio();
				
	// 			// Dispatch pause event
	// 			if(SpiG.getStage() != null)
	// 				SpiG.getStage().dispatchEvent(PauseEvent.getEvent(PauseEvent.PAUSE_OUT));
	// 		}
	// 	}
	// }

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
		_game.step = Std.int(1000 / Framerate);
		if(_game.maxAccumulation < _game.step)
			_game.maxAccumulation = Std.int(_game.step);

		// Update the fps at runtime
		//if(updateFPS != null)
		//	updateFPS.updateFPS(Framerate);
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
		if(_game.maxAccumulation < _game.step)
			_game.maxAccumulation = Std.int(_game.step);
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
	
// 	/**
// 	 * Returns true if we are replaying the game.
// 	 */
// 	public static boolean isReplaying()
// 	{
// 		return _game._replaying;
// 	}
	
// 	/**
// 	 * Resets the game or state and replay requested flag.
// 	 * 
// 	 * @param	StandardMode	If true, reload entire game, else just reload current game state.
// 	 */
// 	public static void reloadReplay(boolean StandardMode)
// 	{
// 		if(StandardMode)
// 			resetGame();
// 		else
// 			resetState();
// 		if(_game._replay.frameCount > 0)
// 			_game._replayRequested = true;
// 	}
	
// 	/**
// 	 * Resets the game or state and replay requested flag. 
// 	 */
// 	public static void reloadReplay()
// 	{
// 		reloadReplay(true);
// 	}
	
// 	/**
// 	 * Stops the current replay.
// 	 */
// 	public static void stopReplay()
// 	{
// 		_game._replaying = false;
// 		if(_game.debugger != null)
// 			_game.debugger.vcr.stopped();
// 		resetInput();
// 	}
	
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
	
// 	/**
// 	 * Reset the input helper objects (useful when changing screens or states)
// 	 */
// 	public static void resetInput()
// 	{
// 		keys.reset();
// 		mouse.reset();
// 		externals.reset();
// 		accelerometer.reset();
// 	}
	
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
	
// 	/**
// 	 * Get the music volume.
// 	 */
// 	public static float getMusicVolume()
// 	{
// 		 return volumeHandler.musicVolume;
// 	}

// 	/**
// 	 * Get the sound volume.
// 	 */
// 	public static float getSoundVolume()
// 	{
// 		 return volumeHandler.soundVolume;
// 	}
	 
// 	/**
// 	 * Sets the music volume
// 	 */
// 	public static void setMusicVolume(float volume)
// 	{
// 		if(volume < 0)
// 			volume = 0;
// 		else if(volume > 1)
// 			volume = 1;

// 		volumeHandler.musicVolume = volume;
// 		if(volumeCallback != null)
// 			volumeCallback.onChange(volumeHandler.mute ? 0 : volume, SpiSound.MUSIC);
// 	}

// 	/**
// 	 * Sets the sound volume
// 	 */
// 	public static void setSoundVolume(float volume)
// 	{
// 		if(volume < 0)
// 			volume = 0;
// 		else if(volume > 1)
// 			volume = 1;

// 		volumeHandler.soundVolume = volume;
// 		if(volumeCallback != null)
// 			volumeCallback.onChange(volumeHandler.mute ? 0 : volume, SpiSound.SFX);
// 	}
	
// 	/**
// 	 * Get the mute state
// 	 */
// 	public static boolean getMute()
// 	{
// 		return volumeHandler.mute;
// 	}

// 	/**
// 	 * Sets the mute state
// 	 */
// 	public static void setMute(boolean mute)
// 	{
// 		volumeHandler.mute = mute;
// 		if(mute) {
// 			if(volumeCallback != null)
// 				volumeCallback.onChange(0, SpiSound.ALL);
// 		} else {
// 			if(volumeCallback != null) {
// 				volumeCallback.onChange(volumeHandler.musicVolume, SpiSound.MUSIC);
// 				volumeCallback.onChange(volumeHandler.soundVolume, SpiSound.SFX);
// 			}
// 		}
// 	}
	
// 	/**
// 	 * Called by SpiGame on state changes to stop and destroy sounds.
// 	 * 
// 	 * @param	ForceDestroy		Kill sounds even if they're flagged <code>survive</code>.
// 	 */
// 	static void destroySounds(boolean ForceDestroy)
// 	{
// 		if((music != null) && (ForceDestroy || !music.survive))
// 		{
// 			music.destroy();
// 			music = null;
// 		}
// 		int i = 0;
// 		SpiSound sound;
// 		int l = sounds.size();
// 		while(i < l)
// 		{
// 			sound = (SpiSound) sounds.members.get(i);
// 			if((sound != null) && (ForceDestroy || !sound.survive))
// 				sound.destroy(); 
// 			i++;
// 		}
// 		sounds.clear();
// 	}

// 	/**
// 	 * Called by SpiGame on state changes to stop and destroy sounds.
// 	 * 
// 	 * @param	ForceDestroy		Kill sounds even if they're flagged <code>survive</code>.
// 	 */
// 	static void destroySounds()
// 	{
// 		destroySounds(false);
// 	}
	
// 	/**
// 	 * Called by the game loop to make sure the sounds get updated each frame.
// 	 */
// 	public static void updateSounds()
// 	{
// 		if((music != null) && music.active)
// 			music.update();
// 		if((sounds != null) && sounds.active)
// 			sounds.update();
// 	}
	
// 	/**
// 	 * Pause all sounds currently playing.
// 	 */
// 	public static void pauseAudio()
// 	{
// 		// Pause the music.
// 		if((music != null) && music.exists)
// 			music.pause();

// 		// Pause all the sounds.
// 		int i = 0;
// 		SpiSound sound;
// 		if(sounds != null) {
// 			int l = sounds.size();
// 			while(i < l)
// 			{
// 				sound = (SpiSound) sounds.members.get(i++);
// 				if((sound != null) && sound.exists)
// 					sound.pause();
// 			}
// 		}
// 	}
	
// 	/**
// 	 * Resume playing existing sounds.
// 	 */
// 	public static void resumeAudio()
// 	{
// 		// Resume the music.
// 		if((music != null) && music.exists)
// 			music.play();
		
// 		// Resume all the sounds.
// 		int i = 0;
// 		SpiSound sound;
// 		int l = sounds.size();
// 		while(i < l)
// 		{
// 			sound = (SpiSound) sounds.members.get(i++);
// 			if((sound != null) && sound.exists)
// 				sound.resume();
// 		}
// 	}
	
// 	/**
// 	 * Free memory by disposing a sound file and removing it from the cache.
// 	 * 
// 	 * @param Path The path to the sound file.
// 	 */
// 	public static void disposeSound(String Path)
// 	{
// 		_cache.unload(Path);
// 	}

// 	/**
// 	 * Check the local cache to see if an asset with this key has been loaded
// 	 * already.
// 	 * 
// 	 * @param Key The string key identifying the asset.
// 	 * 
// 	 * @return Whether or not this file can be found in the cache.
// 	 */
// 	public static boolean checkCache(String Key)
// 	{
// 		return _cache.containsAsset(Key);
// 	}
	
// 	/**
// 	 * Check the local bitmap cache to see if a bitmap with this key has been
// 	 * loaded already.
// 	 * 
// 	 * @param Key The string key identifying the bitmap.
// 	 * 
// 	 * @return Whether or not this file can be found in the cache.
// 	 */
// 	public static boolean checkBitmapCache(String Key)
// 	{
// 		return _cache.containsAsset(Key, Texture.class);
// 	}
	
// 	/**
// 	 * Generates a new <code>TextureRegion</code> object (a colored square) and caches it.
// 	 * 
// 	 * @param Width 	How wide the square should be.
// 	 * @param Height 	How high the square should be.
// 	 * @param Color 	What color the square should be (0xAARRGGBB)
// 	 * @param Unique	Ensures that the <code>TextureRegion</code> uses a new slot in the cache.
// 	 * @param Key		Force the cache to use a specific Key to index the <code>TextureRegion</code>.
// 	 * 
// 	 * @return The <code>AtlasRegion</code> we just created.
// 	 */
// 	public static AtlasRegion createBitmap(int Width, int Height, int Color, boolean Unique, String Key)
// 	{		
// 		if(Key == null)
// 		{
// 			Key = Width+"x"+Height+":"+Color;
// 			if(Unique && checkBitmapCache(Key))
// 			{
// 				// Generate a unique key
// 				int inc = 0;
// 				String ukey;
// 				do
// 				{
// 					ukey = Key + inc++;
// 				}
// 				while(checkBitmapCache(ukey));
// 				Key = ukey;
// 			}
// 		}
		
// 		if(!checkBitmapCache(Key))
// 		{
// 			if (Width == 0 || Height == 0)
// 				throw new RuntimeException("A bitmaps width and height must be greater than zero.");

// 			Pixmap pixmap = new Pixmap(MathUtils.nextPowerOfTwo(Width), MathUtils.nextPowerOfTwo(Height), Format.RGBA8888);			
// 			pixmap.setColor(SpiU.argbToRgba(Color));
// 			pixmap.fill();
			
// 			TextureParameter parameter = new TextureParameter();
// 			parameter.textureData = new SpiManagedTextureData(pixmap);
// 			_cache.load(Key, Texture.class, parameter);
// 		}
// 		return new AtlasRegion(_cache.load(Key, Texture.class), 0, 0, Width, Height);
// 	}
	
	// /**
	//  * Generates a new <code>TextureRegion</code> object (a colored square) and caches it.
	//  * 
	//  * @param Width 	How wide the square should be.
	//  * @param Height 	How high the square should be.
	//  * @param Color 	What color the square should be (0xAARRGGBB)
	//  * @param Unique	Ensures that the <code>TextureRegion</code> uses a new slot in the cache.
	//  * 
	//  * @return The <code>AtlasRegion</code> we just created.
	//  */
	// public static AtlasRegion createBitmap(int Width, int Height, int Color, boolean Unique)
	// {
	// 	return createBitmap(Width, Height, Color, Unique, null);
	// }

	// /**
	//  * Generates a new <code>TextureRegion</code> object (a colored square) and caches it.
	//  * 
	//  * @param Width 	How wide the square should be.
	//  * @param Height 	How high the square should be.
	//  * @param Color 	What color the square should be (0xAARRGGBB)
	//  * 
	//  * @return The <code>AtlasRegion</code> we just created.
	//  */
	// public static AtlasRegion createBitmap(int Width, int Height, int Color)
	// {
	// 	return createBitmap(Width, Height, Color, false, null);
	// }
	
	// /**
	//  * Loads a <code>TextureRegion</code> from a file and caches it.
	//  * 
	//  * @param	Graphic		The image file that you want to load.
	//  * @param	Reverse		Whether to generate a flipped version. Not used.
	//  * @param	Unique		Ensures that the <code>TextureRegion</code> uses a new slot in the cache.
	//  * @param	Key			Force the cache to use a specific Key to index the <code>TextureRegion</code>.
	//  * 
	//  * @return	The <code>AtlasRegion</code> we just created.
	//  */
	// public static AtlasRegion addBitmap(String Graphic, boolean Reverse, boolean Unique, String Key)
	// {
	// 	if(Key != null) {
	// 		Unique = true;
	// 	} else {
	// 		Key = Graphic/*+(Reverse?"_REVERSE_":"")*/;
	// 		if(Unique && checkBitmapCache(Key)) {
	// 			int inc = 0;
	// 			String ukey;
	// 			do {
	// 				ukey = Key + inc++;
	// 			} while(checkBitmapCache(ukey));
	// 			Key = ukey;
	// 		}
	// 	}
		
	// 	AtlasRegion atlasRegion = null;
	// 	String[] split = Graphic.split(":");

	// 	// If no region has been specified, load as standard texture 
	// 	if (split.length == 1) {
	// 		Texture texture = _cache.load(Graphic, Texture.class);
	// 		atlasRegion = new AtlasRegion(texture, 0, 0, texture.getWidth(), texture.getHeight());
	// 	// Otherwise, load as TextureAtlas 
	// 	} else if (split.length == 2) {
	// 		String fileName = split[0];
	// 		String regionName = split[1];
		
	// 		atlasRegion = loadTextureAtlas(fileName).findRegion(regionName);
		
	// 		if (atlasRegion == null)
	// 			throw new RuntimeException("Could not find region " + regionName + " in " + fileName);
	// 	}
	// 	else
	// 	{
	// 		throw new IllegalArgumentException("Invalid path: " + Graphic + ".");
	// 	}
		
	// 	if (Unique) {
	// 		if(!checkBitmapCache(Key)) {
	// 			TextureData textureData = atlasRegion.getTexture().getTextureData();
		
	// 			if(!textureData.isPrepared())
	// 				textureData.prepare();
				
	// 			int rx = atlasRegion.getRegionX();
	// 			int ry = atlasRegion.getRegionY();
	// 			int rw = atlasRegion.getRegionWidth();
	// 			int rh = atlasRegion.getRegionHeight();
				
	// 			Pixmap newPixmap = new Pixmap(MathUtils.nextPowerOfTwo(rw), MathUtils.nextPowerOfTwo(rh), Pixmap.Format.RGBA8888);
	// 			Pixmap graphicPixmap = textureData.consumePixmap();
	// 			newPixmap.drawPixmap(graphicPixmap, 0, 0, rx, ry, rw, rh);
				
	// 			if (textureData.disposePixmap())
	// 				graphicPixmap.dispose();
				
	// 			TextureParameter parameter = new TextureParameter();
	// 			parameter.textureData = new SpiManagedTextureData(newPixmap);
	// 			_cache.load(Key, Texture.class, parameter);
	// 		}
	// 		atlasRegion = new AtlasRegion(_cache.load(Key, Texture.class), 0, 0, atlasRegion.getRegionWidth(), atlasRegion.getRegionHeight());
	// 	}

	// 	return atlasRegion;
	// }
	
	// /**
	//  * Loads a <code>AtlasRegion</code> from a file and caches it.
	//  * 
	//  * @param	Graphic		The image file that you want to load.
	//  * @param	Reverse		Whether to generate a flipped version. Not used.
	//  * @param	Unique		Ensures that the <code>TextureRegion</code> uses a new slot in the cache.
	//  * 
	//  * @return	The <code>AtlasRegion</code> we just created.
	//  */
	// public static AtlasRegion addBitmap(String Graphic, boolean Reverse, boolean Unique)
	// {
	// 	return addBitmap(Graphic, Reverse, Unique, null);
	// }
	
	// /**
	//  * Loads a <code>AtlasRegion</code> from a file and caches it.
	//  * 
	//  * @param	Graphic		The image file that you want to load.
	//  * @param	Reverse		Whether to generate a flipped version. Not used.
	//  * 
	//  * @return	The <code>AtlasRegion</code> we just created.
	//  */
	// public static AtlasRegion addBitmap(String Graphic, boolean Reverse)
	// {
	// 	return addBitmap(Graphic, Reverse, false, null);
	// }
	
	// /**
	//  * Loads a <code>AtlasRegion</code> from a file and caches it.
	//  * 
	//  * @param	Graphic		The image file that you want to load.
	//  * 
	//  * @return	The <code>AtlasRegion</code> we just created.
	//  */
	// public static AtlasRegion addBitmap(String Graphic)
	// {
	// 	return addBitmap(Graphic, false, false, null);
	// }
	
	// /**
	//  * Loads a <code>TextureAtlas</code> from a file and caches it.
	//  * 
	//  * @param Path The path to the atlas file you want to load.
	//  * 
	//  * @return The <code>TextureAtlas</code>.
	//  */
	// public static TextureAtlas loadTextureAtlas(String Path)
	// {
	// 	return _cache.load(Path, TextureAtlas.class);
	// }

	// /**
	//  * Free memory by disposing a <code>TextureAtlas</code> and removing it from
	//  * the cache.
	//  * 
	//  * @param Path The path to the atlas file.
	//  */
	// public static void disposeTextureAtlas(String Path)
	// {
	// 	_cache.unload(Path);
	// }
	
	// /**
	//  * Dumps the cache's image references.
	//  */
	// public static void clearBitmapCache()
	// {
	// 	_cache.disposeRunTimeTextures();
	// }

	// /**
	//  * Dispose the asset manager and all assets it contains.
	//  */
	// public static void disposeAssetManager()
	// {
	// 	if(_cache != null)
	// 		_cache.dispose();
	// }
	
	// /**
	//  * The number of assets currently loaded. Useful for debugging.
	//  * 
	//  * @return The number of assets.
	//  */
	// public static int getNumberOfAssets()
	// {
	// 	return _cache.getNumberOfAssets();
	// }

	// /**
	//  * Add resolutions to the resolver.
	//  * 
	//  * @param resolutions An array of resolutions (e.g. new Resolution(320, 480,
	//  *        "320480")).
	//  */
	// public static void addResolutionResolver(Resolution[] resolutions)
	// {
	// 	_cache.addResolutionResolver(resolutions);
	// }
	
	// /**
	//  * Loads an external text file.
	//  * 
	//  * @param FileName	The path to the text file.
	//  * 
	//  * @return	The contents of the file.
	//  */
	// public static String loadString(String FileName)
	// {
	// 	return Gdx.files.internal(FileName).readString();
	// }
	
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
	
	// /**
	//  * Read-only: retrieves the Flash stage object (required for event listeners)
	//  * Will be null if it's not safe/useful yet.
	//  */
	// public static SpiGameStage getStage()
	// {
	// 	return _game.stage;
	// }
	
	// /**
	//  * Read-only: access the current game state from anywhere.
	//  */
	// public static SpiState getState()
	// {
	// 	return _game._state;
	// }
	
	/**
	 * Read-only: gets the current SpiCamera.
	 */
	public static function getActiveCamera():SpiCamera
	{
		return activeCamera;
	}
	
	// /**
	//  * Switch from the current game state to the one specified here.
	//  * 
	//  * @param state 			The new state.
	//  */
	// public static void switchState(SpiState State)
	// {
	// 	setState(State);
	// }

	// /**
	//  * Switch from the current game state to the one specified here.
	//  * Saving the current in the stack.
	//  * 
	//  * @param state 	The new state.
	//  */
	// public static void setState(SpiState state)
	// {
	// 	_game.requestedState = state;
	// }
	
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
	
	// /**
	//  * Add a new camera object to the game.
	//  * Handy for PiP, split-screen, etc.
	//  * 
	//  * @param	NewCamera		The camera you want to add.
	//  * @param	addToCameras	If we add the camera to the global list of cameras.
	//  * 
	//  * @return	This <code>SpiCamera</code> instance.
	//  */
	// public static SpiCamera addCamera(SpiCamera NewCamera, boolean addToCameras)
	// {
	// 	displayList.add(NewCamera);
		
	// 	if(addToCameras)
	// 		cameras.add(NewCamera);

	// 	return NewCamera;
	// }

	// /**
	//  * Add a new camera object to the game.
	//  * Handy for PiP, split-screen, etc.
	//  * 
	//  * @param	NewCamera	The camera you want to add.
	//  * 
	//  * @return	This <code>SpiCamera</code> instance.
	//  */
	// public static SpiCamera addCamera(SpiCamera NewCamera)
	// {
	// 	return addCamera(NewCamera, true);
	// }
	
	// /**
	//  * Remove a camera from the game.
	//  * 
	//  * @param	Camera	The camera you want to remove.
	//  * @param	Destroy	Whether to call destroy() on the camera, default value is true.
	//  */
	// public static void removeCamera(SpiCamera Camera, boolean Destroy)
	// {
	// 	if(!displayList.removeValue(Camera, true))
	// 		log("Error removing camera, not part of game.");
	// 	cameras.removeValue(Camera, true);
	// 	if(Destroy)
	// 		Camera.destroy();
	// }
	
	// /**
	//  * Remove a camera from the game.
	//  * 
	//  * @param	Camera	The camera you want to remove.
	//  */
	// public static void removeCamera(SpiCamera Camera)
	// {
	// 	removeCamera(Camera, true);
	// }
	
	// /**
	//  * Dumps all the current cameras and resets to just one camera.
	//  * Handy for doing split-screen especially.
	//  * 
	//  * @param	NewCamera	Optional; specify a specific camera object to be the new main camera.
	//  */
	// public static void resetCameras(SpiCamera NewCamera)
	// {
	// 	SpiCamera cam;
	// 	int i = 0;
	// 	int l = displayList.size;
	// 	while(i < l)
	// 	{
	// 		cam = displayList.get(i++);
	// 		cam.destroy();
	// 	}
	// 	displayList.clear();
	// 	cameras.clear();

	// 	if(NewCamera == null)
	// 		NewCamera = new SpiCamera(0, 0, width, height);
	// 	camera = addCamera(NewCamera);
	// }
	
	// /**
	//  * Dumps all the current cameras and resets to just one camera.
	//  * Handy for doing split-screen especially.
	//  */ 
	// public static void resetCameras()
	// {
	// 	resetCameras(null);
	// }
	
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
	
	// /**
	//  * Get and set the background color of the game.
	//  * Is equivalent to camera.bgColor.
	//  */
	// public static int getBgColor()
	// {
	// 	if(camera == null)
	// 		return 0xff000000;
	// 	else
	// 		return camera.bgColor;
	// }

	// /**
	//  * Set the background color of all the game cameras.
	//  */
	// public static void setBgColor(int Color)
	// {
	// 	int i = 0;
	// 	int l = cameras.size;
	// 	while(i < l)
	// 		cameras.get(i++).bgColor = Color;
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
	
	// /**
	//  * Adds a new plugin to the global plugin array.
	//  * 
	//  * @param	Plugin	Any object that extends SpiBasic. Useful for managers and other things.  See spiller.plugin for some examples!
	//  * 
	//  * @return	The same <code>SpiBasic</code>-based plugin you passed in.
	//  */
	// public static SpiBasic addPlugin(SpiBasic Plugin)
	// {
	// 	// Don't add repeats
	// 	Array<SpiBasic> pluginList = plugins;
	// 	int i = 0;
	// 	int l = pluginList.size;
	// 	while(i < l)
	// 	{
	// 		if(pluginList.get(i++).toString().equals(Plugin.toString()))
	// 			return Plugin;
	// 	}
		
	// 	// no repeats! safe to add a new instance of this plugin
	// 	pluginList.add(Plugin);
	// 	return Plugin;
	// }

	// /**
	//  * Retrieves a plugin based on its class name from the global plugin array.
	//  * 
	//  * @param	ClassType	The class name of the plugin you want to retrieve. See the <code>SpiPath</code> or <code>SpiTimer</code> constructors for example usage.
	//  * 
	//  * @return	The plugin object, or null if no matching plugin was found.
	//  */
	// public static SpiBasic getPlugin(Class<? extends SpiBasic> ClassType)
	// {
	// 	Array<SpiBasic> pluginList = plugins;
	// 	int i = 0;
	// 	int l = pluginList.size;
	// 	while(i < l)
	// 	{
	// 		if(pluginList.get(i).getClass().equals(ClassType))
	// 			return plugins.get(i);
	// 		i++;
	// 	}
	// 	return null;
	// }
		
	// /**
	//  * Removes an instance of a plugin from the global plugin array.
	//  * 
	//  * @param	Plugin	The plugin instance you want to remove.
	//  * 
	//  * @return	The same <code>SpiBasic</code>-based plugin you passed in.
	//  */
	// public static SpiBasic removePlugin(SpiBasic Plugin)
	// {
	// 	//Don't add repeats
	// 	Array<SpiBasic> pluginList = plugins;
	// 	int i = pluginList.size-1;
	// 	while(i >= 0)
	// 	{
	// 		if(pluginList.get(i) == Plugin)
	// 			pluginList.removeIndex(i);
	// 		i--;
	// 	}
	// 	return Plugin;
	// }
	
	// /**
	//  * Removes an instance of a plugin from the global plugin array.
	//  * 
	//  * @param	ClassType	The class name of the plugin type you want removed from the array.
	//  * 
	//  * @return	Whether or not at least one instance of this plugin type was removed.
	//  */
	// public static boolean removePluginType(Class<? extends SpiBasic> ClassType)
	// {
	// 	//Don't add repeats
	// 	boolean results = false;
	// 	Array<SpiBasic> pluginList = plugins;
	// 	int i = pluginList.size-1;
	// 	while(i >= 0)
	// 	{
	// 		if(ClassReflection.isInstance(ClassType, pluginList.get(i)))
	// 		{
	// 			pluginList.removeIndex(i);
	// 			results = true;
	// 		}
	// 		i--;
	// 	}
	// 	return results;
	// }
	
	/**
	 * Called by <code>SpiGame</code> to set up <code>SpiG</code> during <code>SpiGame</code>'s constructor.
	 */
	private static function init(Game:SpiGame, Width:Int, Height:Int, Zoom:Float, ScaleMode:Int):Void
	{
		// Set the game stuff
		_game = Game;
	// 	width = Width;
	// 	height = Height;
		
	// 	// Set the sound stuff
	// 	sounds = new SpiGroup();
	// 	volumeHandler = new SpiVolumeHandler();
	// 	music = null;

	// 	// Initialize all the SpiG general variables
	// 	_cache = new SpiAssetManager();
	// 	stateChange = false;
		
	// 	SpiCamera.defaultZoom = Zoom;
	// 	SpiCamera.defaultScaleMode = ScaleMode;
	// 	cameras = new Array<SpiCamera>();
	// 	displayList = new Array<SpiCamera>();
	// 	spriteLightning = new SpiLightning();
	// 	camera = null;
	// 	useBufferLocking = false;

	// 	// Set the plugin stuff
	// 	plugins = new Array<SpiBasic>();
	// 	addPlugin(new SpiDebugPathDisplay());
	// 	addPlugin(new SpiTimerManager());
		
	// 	// Set the input stuff
	// 	mouse = new SpiMouse();
	// 	touch = mouse;
	// 	keys = new SpiKeyboard();
	// 	accelerometer = new SpiAccelerometer();
	// 	externals = new SpiExternalInput();
	// 	inputs = new InputMultiplexer(); 

	// 	levels = new Array<Object>();
	// 	scores = new IntArray();
	// 	visualDebug = false;
		
	// 	_floatArray = new float[4];

	// 	//SpiGestureManager manager = new SpiGestureManager();
	// 	//inputs.addProcessor(new SpiSwipeDetector(10, manager));
	// 	//inputs.addProcessor(new GestureDetector());
	// 	//addPlugin(manager);
		
	// 	shaders = new ObjectMap<String, SpiShaderProgram>();
	}
	
	/**
	 * Called whenever the game is reset, doesn't have to do quite as much work as the basic initialization stuff.
	 */
	private static function reset():Void
	{
	// 	clearBitmapCache();
	// 	resetInput();
	// 	destroySounds(true);
	// 	stopVibrate();
	// 	destroyShaders();

	// 	levels.clear();
	// 	scores.clear();
	// 	level = 0;
	// 	score = 0;
	// 	paused = false;
	// 	fixedTimestep = true;
	// 	maxElapsed = 0.1f;
	// 	timeScale = 1.0f;
	// 	elapsed = 0;
	// 	globalSeed = SpiU.getSeed();
	// 	SpiU.setSeed(globalSeed);
	// 	worldBounds = new SpiRect(-10, -10, width + 20, height + 20);
	// 	worldDivisions = 6;
	// 	spriteLightning.clear();
	// 	SpiDebugPathDisplay debugPathDisplay = (SpiDebugPathDisplay) getPlugin(SpiDebugPathDisplay.class);
	// 	if(debugPathDisplay != null)
	// 		debugPathDisplay.clear();
	//
	//  random.resetInitialSeed();
	}
	
	// /**
	//  * Called by the game object to update the keyboard and mouse input tracking objects.
	//  */
	// public static void updateInput()
	// {
	// 	// Update the specific mobile phone inputs
	// 	accelerometer.update();
	// 	externals.update();

	// 	// Update the Keyboard inputs
	// 	keys.update();

	// 	if(!_game.debuggerUp || !_game.debugger.hasMouse)
	// 		mouse.update();
	// }
	
	// /**
	//  * Called by the game object to lock all the camera buffers and clear them for the next draw pass.  
	//  */
	// public static void lockCameras()
	// {
	// 	SpiCamera camera = activeCamera;
		
	// 	// If the app is an iOS app do not cut the screen
	// 	if(Gdx.app.getType() != ApplicationType.iOS) {
	// 		// Set the drawing area		
	// 		int scissorWidth = SpiU.ceil(camera.width * camera._screenScaleFactorX * camera.getZoom());
	// 		int scissorHeight = SpiU.ceil(camera.height * camera._screenScaleFactorY * camera.getZoom());
	// 		int scissorX = (int) (camera.x * camera._screenScaleFactorX);
	// 		int scissorY = (int) (screenHeight - ((camera.y * camera._screenScaleFactorY) + scissorHeight));
	// 		gl.glScissor(scissorX, scissorY, scissorWidth, scissorHeight);
	// 	} else {
	// 		gl.glScissor(0, 0, Gdx.graphics.getWidth(), Gdx.graphics.getHeight());
	// 	}
			
	// 	// Clear the camera
	// 	if(((camera.bgColor >> 24) & 0xff) == 0xFF)
	// 	{
	// 		int color = SpiU.multiplyColors(camera.bgColor, camera.getColor());
	// 		_floatArray = SpiU.getRGBA(color, _floatArray);
	// 		gl.glClearColor(_floatArray[0] * 0.00392f, _floatArray[1] * 0.00392f, _floatArray[2] * 0.00392f, 1.0f);
	// 		gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
	// 	} else
	// 	// Clear camera if needed
	// 	if(camera.bgColor != 0x0)
	// 	{
	// 		camera.fill(camera.bgColor);
	// 	}

	// 	// Set tint
	// 	_floatArray = SpiU.getRGBA(camera.getColor(), _floatArray);
	// 	batch.setColor(_floatArray[0] * 0.00392f, _floatArray[1] * 0.00392f, _floatArray[2] * 0.00392f, 1.0f);

	// 	// Set matrix
	// 	batch.setProjectionMatrix(camera.glCamera.combined);
	// 	flashGfx.setProjectionMatrix(camera.glCamera.combined);

	// 	// Get ready for drawing
	// 	batch.begin();
	// 	flashGfx.begin();
	// }
	
	// /**
	//  * Called by the game object to draw the special FX and unlock all the camera buffers.
	//  */
	// public static void unlockCameras()
	// {
	// 	SpiCamera camera = activeCamera;
		
	// 	batch.end();
	// 	flashGfx.end();
		
	// 	camera.drawFX();
	// }
	
	// /**
	//  * Called by the game object to update the cameras and their tracking/special effects logic.
	//  */
	// public static void updateCameras()
	// {
	// 	SpiCamera cam;
	// 	Array<SpiCamera> cams = cameras;
	// 	int i = 0;
	// 	int l = cams.size;
	// 	while(i < l)
	// 	{
	// 		cam = cams.get(i++);
	// 		if((cam != null) && cam.exists)
	// 		{
	// 			if(cam.active)
	// 				cam.update();
	// 			cam.glCamera.position.x = cam._flashOffsetX - (cam.x / cam.getZoom());
	// 			cam.glCamera.position.y = cam._flashOffsetY - (cam.y / cam.getZoom());
	// 		}
	// 	}
	// }
	
	// /**
	//  * Used by the game object to call <code>update()</code> on all the plugins.
	//  */
	// public static void updatePlugins()
	// {
	// 	SpiBasic plugin;
	// 	Array<SpiBasic> pluginList = plugins;
	// 	int i = 0;
	// 	int l = pluginList.size;
	// 	while(i < l)
	// 	{
	// 		plugin = pluginList.get(i++);
	// 		if(plugin.exists && plugin.active)
	// 			plugin.update();
	// 	}
	// }

	// /**
	//  * Used by the game object to call <code>draw()</code> on all the plugins.
	//  */
	// public static void drawPlugins()
	// {
	// 	// Start the part of the screen where the plugins will be drawn
	// 	flashGfx.begin();
		
	// 	SpiBasic plugin;
	// 	Array<SpiBasic> pluginList = plugins;
	// 	int i = 0;
	// 	int l = pluginList.size;
	// 	while(i < l)
	// 	{
	// 		plugin = pluginList.get(i++);
	// 		if(plugin.exists && plugin.visible)
	// 			plugin.draw();
	// 	}
		
	// 	flashGfx.end();
	// }
	
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
	
	// /**
	//  * Preload the lightning textures in order to check for flushing.
	//  * 
	//  * @param texture
	//  * @param normals
	//  * @param specular
	//  */
	// public static void preloadLightning(Texture texture, Texture normals)
	// {
	// 	spriteLightning.preloadLightning(texture, normals);
	// }
	
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

	// //==========================================================================//
	// //								CALLBACKS									//
	// //==========================================================================//
	// /**
	//  * Set this hook to get a callback whenever the volume changes.
	//  * Function should take the form <code>myVolumeHandler(Volume:Number)</code>.
	//  */
	// private static ISpiVolume volumeCallback = new ISpiVolume()
	// {
	// 	public void onChange(float volume, int type)
	// 	{
	// 		switch(type) {
	// 			case SpiSound.MUSIC:
	// 				if(music != null)
	// 					music.setVolume(volume);
	// 				break;
	// 			case SpiSound.SFX:
	// 				// Update all the sounds
	// 				for(int i = 0; i < sounds.members.size; i++) {
	// 					((SpiSound)sounds.members.get(i)).setVolume(volume);
	// 				}
	// 				break;
	// 			case SpiSound.ALL:
	// 				if(music != null)
	// 					music.setVolume(volume);
	// 				// Update all the sounds
	// 				for(int i = 0; i < sounds.members.size; i++) {
	// 					((SpiSound)sounds.members.get(i)).setVolume(volume);
	// 				}
	// 				break;
	// 		}
	// 	};
	// };

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