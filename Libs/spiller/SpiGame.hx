package spiller;

import kha.Game;
import kha.Canvas;
import kha.Color;
import kha.Font;
import kha.FontStyle;
import kha.Framebuffer;
import kha.graphics2.Graphics;
import kha.Image;
import kha.input.Keyboard;
import kha.input.Mouse;
import kha.input.Surface;
import kha.Kravur;
import kha.Loader;
import kha.math.Vector2;
import kha.Key;
import kha.Scheduler;
import kha.ScreenCanvas;

import spiller.math.SpiRandom;
import spiller.system.flash.SpiGameStage;
import spiller.system.flash.events.Event;
import spiller.system.flash.events.KeyboardEvent;
import spiller.system.flash.events.MouseEvent;
import spiller.system.flash.events.EnterFrameEvent;
import spiller.system.SpiPause;
import spiller.system.kha.Keys;
import spiller.sound.SpiSound;
import spiller.system.time.SpiTimer;
import spiller.system.time.SpiTimerManager;
import spiller.system.SpiSplashScreen;

#if SPI_DEBUG
import spiller.system.debug.SpiDebugger;
#end

#if SPI_RECORD_REPLAY
import spiller.system.replay.SpiReplay;
#end


/**
 * SpiGame is the heart of all spiller games, and contains a bunch of basic game loops and things. It is a long and sloppy file that you shouldn't have to worry about too much! It
 * is basically only used to create your game object in the first place, after that SpiG and SpiState have all the useful stuff you actually need.
 * 
 * v1.4 Updated reflection stuff v1.3 Added configurable assets dispose v1.2 Fixed the mobile check v1.1 Ported to Java v1.0 Initial version (?)
 * 
 * @version 1.4 - 02/07/2013
 * @author Ka Wing Chin
 * @author Thomas Weston
 * @author ratalaika / Ratalaika Games
 */
 @:allow(spiller)
class SpiGame extends Game
{
	/**
	 * If we are going to use the splash screen.
	 */
	public static inline var useSplashScreen:Bool = true;
	/**
	 * Sets 0, -, and + to control the global volume sound volume.
	 * 
	 * @default true
	 */
	public var useSoundHotKeys:Bool;
	/**
	 * Tells spiller to use the default system mouse cursor instead of custom spiller mouse cursors.
	 * 
	 * @default false
	 */
	public var useSystemCursor:Bool;
	/**
	 * Current game state.
	 */
	private var _state:SpiState;
	/**
	 * Mouse cursor.
	 */
	// private TextureRegion _mouse;
	/**
	 * The back buffer image.
	 */
	private var _backBuffer:Image;
	/**
	 * Class type of the initial/first game state for the game, usually MenuState or something like that.
	 */
	private var _iState:SpiState;
	/**
	 * Whether the game object's basic initialization has finished yet.
	 */
	private var _created:Bool;
	/**
	 * Total number of milliseconds elapsed since game start.
	 */
	private var _total:Float = 0;
	/**
	 * Total number of milliseconds elapsed since last update loop. Counts down as we step through the game loop.
	 */
	private var _accumulator:Float;
	/**
	 * Milliseconds of time since last step.
	 */
	private var _elapsedMS:Float;
	/**
	 * Whether the Flash player lost focus.
	 */
	private var _lostFocus:Bool;
	/**
	 * Milliseconds of time per step of the game loop.<br>
	 * FlashEvent.g. 60 fps = 16ms.
	 */
	private var _step:Int;
	/**
	 * Framerate of the Flash player (NOT the game loop). Default = 30.
	 */
	private var _flashFramerate:Int;
	/**
	 * Max allowable accumulation (see _accumulator).<br>
	 * Should always (and automatically) be set to roughly 2x the flash player framerate.
	 */
	private var maxAccumulation:Int;
	/**
	 * The current game framerate.
	 */
	private var _gameFramerate:Int;
	/**
	 * If a state change was requested, the new state object is stored here until we switch to it.
	 */
	private var requestedState:SpiState;
	/**
	 * A flag for keeping track of whether a game reset was requested or not.
	 */
	private var _requestedReset:Bool;
	
	#if SPI_FOCUS_LOST_SCREEN
	/**
	 * The "focus lost" screen (see <code>createFocusScreen()</code>).
	 */
	private var _focus:Image;
	#end

	#if SPI_SOUND_TRAY
	/**
	 * The sound tray display container (see <code>createSoundTray()</code>).
	 */
	private var _soundTray:SpiSprite;
	/**
	 * Helps us auto-hide the sound tray after a volume change.
	 */
	private var _soundTrayTimer:Float;
	/**
	 * Helps display the volume bars on the sound tray.
	 */
	private var _soundTrayBars:Array<SpiSprite>;
	#end

	#if SPI_DEBUG
	/**
	 * Initialize and allow the spiller debugger overlay even in release mode. Also useful if you don't use SpiPreloader!
	 * 
	 * @default false
	 */
	public var forceDebugger:Bool;
	/**
	 * The debugger overlay object.
	 */
	private var debugger:SpiDebugger;
	/**
	 * A handy boolean that keeps track of whether the debugger exists and is currently visible.
	 */
	private var debuggerUp:Bool;
	#end

	#if SPI_RECORD_REPLAY
	/**
	 * Container for a game replay object.
	 */
	private var _replay:SpiReplay;
	/**
	 * Flag for whether a playback of a recording was requested.
	 */
	private var _replayRequested:Bool;
	/**
	 * Flag for whether a new recording was requested.
	 */
	private var _recordingRequested:Bool;
	/**
	 * Flag for whether a replay is currently playing.
	 */
	private var _replaying:Bool;
	/**
	 * Flag for whether a new recording is being made.
	 */
	private var _recording:Bool;
	/**
	 * Array that keeps track of keypresses that can cancel a replay. Handy for skipping cutscenes or getting out of attract modes!
	 */
	private var _replayCancelKeys:Array<String>;
	/**
	 * Helps time out a replay if necessary.
	 */
	private var _replayTimer:Int;
	/**
	 * This function, if set, is triggered when the callback stops playing.
	 */
	private var _replayCallback:ReplayCallback;
	#end

	/**
	 * Temporary _font to display the fps.
	 */
	private var _font:Kravur;
	/**
	 * Represents the Flash stage.
	 */
	public var stage:SpiGameStage;
	/**
	 * The pause state.
	 */
	private var _pause:SpiPause;
	/**
	 * Internal, a pre-allocated <code>MouseEvent</code> to prevent <code>new</code> calls.
	 */
	private var _mouseEvent:MouseEvent;
	/**
	 * Internal, a pre-allocated <code>KeyboardEvent</code> to prevent <code>new</code> calls.
	 */
	private var _keyboardEvent:KeyboardEvent;
	/**
	 * Internal, a pre-allocated <code>EnterFrameEvent</code> to prevent <code>new</code> calls.
	 */
	private var _onEnterFrame:Event;
	/**
	 * If the game has been destroyed.
	 */
	private var _destroyed:Bool;

	/**
	 * Instantiate a new game object.
	 * 
	 * @param GameSizeX The width of your game in game pixels, not necessarily final display pixels (see Zoom).
	 * @param GameSizeY The height of your game in game pixels, not necessarily final display pixels (see Zoom).
	 * @param InitialState The class name of the state you want to create and switch to first (e.g. MenuState).
	 * @param Zoom The default level of zoom for the game's cameras (e.g. 2 = all pixels are now drawn at 2x). Default = 1.
	 * @param GameFramerate How frequently the game should update (default is 30 times per second).
	 * @param FlashFramerate Sets the actual display framerate for Flash player (default is 30 times per second).
	 * @param UseSystemCursor Whether to use the default OS mouse pointer, or to use custom spiller ones.
	 * @param ScaleMode How to scale the stage to fit the display (default is stretch).
	 */
	public function new(GameSizeX:Int, GameSizeY:Int, InitialState:SpiState, Zoom:Float = 1, GameFramerate:Int = 60, FlashFramerate:Int = 60, UseSystemCursor:Bool = true, ScaleMode:Int = SpiCamera.STRETCH)
	{
		super("KhaSpiller");

		// Super high priority init stuff (focus, mouse, etc)
		_lostFocus = false;

		// Basic display and update setup stuff
		SpiG.init(this, GameSizeX, GameSizeY, Zoom, ScaleMode);
		SpiG.setFramerate(GameFramerate);
		SpiG.setFlashFramerate(FlashFramerate);

		// If no stage size has been specified, set it to the game size
		stage = new SpiGameStage(Std.int(GameSizeX * Zoom), Std.int(GameSizeY * Zoom));

		// Basic stuff
		_accumulator = Std.int(_step);
		_total = 0;
		_state = null;
		useSoundHotKeys = false;
		useSystemCursor = UseSystemCursor;

		#if SPI_DEBUG
		// Debug stuff
		forceDebugger = false;
		debuggerUp = false;
		#end

		#if SPI_RECORD_REPLAY
		// Replay data
		_replay = new SpiReplay();
		_replayRequested = false;
		_recordingRequested = false;
		_replaying = false;
		_recording = false;
		#end

		// Then get ready to create the game object for real;
		if(SpiGame.useSplashScreen) {
			// _iState = SpiSplashScreen;
			SpiSplashScreen.initialGameState = InitialState; // Set the initial game state after the spash screen
		} else {
			_iState = InitialState;
		}
		requestedState = null;
		_requestedReset = true;
		_created = false;
		_destroyed = false;
	}

	/**
	 * This returns the key code.
	 */
	private static function getKeyCode(key:Key, char:String) : Int
	{
		var keyCode:Int = -1;

		switch(key) {
			case Key.BACKSPACE:
				keyCode = Keys.BACKSPACE;
			case Key.DEL:
				keyCode = Keys.DELETE;
			case Key.DOWN:
				keyCode = Keys.DOWN;
			case Key.UP:
				keyCode = Keys.UP;
			case Key.LEFT:
				keyCode = Keys.LEFT;
			case Key.RIGHT:
				keyCode = Keys.RIGHT;
			case Key.SHIFT:
				keyCode = Keys.SHIFT;
			case Key.ESC:
				keyCode = Keys.ESCAPE;
			case Key.ENTER:
				keyCode = Keys.ENTER;
			case Key.TAB:
				keyCode = Keys.TAB;
			case Key.CTRL:
				keyCode = Keys.CONTROL;
			case Key.CHAR:
				keyCode = -1;
			case Key.ALT:
				keyCode = -1;
		}

		if(keyCode == -1)
			keyCode = char.toUpperCase().charCodeAt(0);
		
		return keyCode;
	}
	

	/**
	 * Internal event handler for Kha keyboard events.
	 */
	public function onKeyUp(key:Key, char:String):Void
	{
		var keyCode:Int = getKeyCode(key, char);
		if(keyCode == -1)
			return;

		keyUpInternal(keyCode);
	}

	/**
	 * Internal event handler for Kha keyboard events.
	 */
	public function onKeyDown(key:Key, char:String):Void
	{
		var keyCode:Int = getKeyCode(key, char);
		if(keyCode == -1)
			return;

		keyDownInternal(keyCode);
	}

	/**
	 * Internal event handler for Kha touch events.
	 */
	public function onTouchStart(id:Int, x:Int, y:Int):Void
	{
		touchDown(x, y, id, 0);
	}

	/**
	 * Touch listener for Kha events.
	 */
	public function onTouchEnd(id:Int, x:Int, y:Int):Void
	{
		touchUp(x, y, id, 0);
	}

	/**
	 * Internal event handler for Kha touch events.
	 */
	public function onTouchMove(id:Int, x:Int, y:Int):Void
	{
		touchMove(x, y, id);
	}

	/**
	 * Internal event handler for Kha mouse events.
	 */
	public function onMouseDown(button:Int, x:Int, y:Int):Void
	{
		touchDown(x, y, 0, button);
	}

	/**
	 * Internal event handler for Kha mouse events.
	 */
	public function onMouseUp(button:Int, x:Int, y:Int):Void
	{
		touchUp(x, y, 0, button);
	}

	/**
	 * Internal event handler for Kha mouse events.
	 */
	public function onMouseWheel(Amount:Int):Void
	{
		mouseWheelInternal(Amount);
	}

	/**
	 * Internal event handler for Kha mouse events.
	 */
	public function onMouseMove(x:Int, y:Int):Void
	{
		touchMove(x, y, 0);
	}

	/**
	 * Internal event handler for input and focus.
	 * 
	 * @param KeyCode A libgdx key code.
	 */
	public function keyUpInternal(KeyCode:Int):Bool
	{
		#if SPI_DEBUG
		if (debuggerUp && debugger.watch.editing)
			return false;
		#end

		if (!SpiG.mobile) {
			#if SPI_DEBUG
			if ((debugger != null) && ((KeyCode == Keys.APOSTROPHE) || (KeyCode == Keys.BACKSLASH))) {
				debugger.visible = !debugger.visible;
				debuggerUp = debugger.visible;

				/*
				 * if(debugger.visible) flash.ui.Mouse.show(); else if(!useSystemCursor) flash.ui.Mouse.hide();
				 */
				// _console.toggle();
				return true;
			}
			#end

			// if (useSoundHotKeys) {
			// 	var c:Int = KeyCode;
			// 	// String code = String.fromCharCode(KeyCode);
			// 	switch (c) {
			// 		case Keys.NUM_0:
			// 			SpiG.setMute(!SpiG.getMute());
			// 			if (SpiG.volumeCallback != null)
			// 				SpiG.volumeCallback(SpiG.getMute() ? 0 : SpiG.getMusicVolume(), SpiSound.ALL);
			// 			#if SPI_SOUND_TRAY
			// 			showSoundTray();
			// 			#end
			// 			return true;
			// 		case Keys.MINUS:
			// 			SpiG.setMute(false);
			// 			SpiG.setMusicVolume(SpiG.getMusicVolume() - 0.1);
			// 			#if SPI_SOUND_TRAY
			// 			showSoundTray();
			// 			#end
			// 			return true;
			// 		case Keys.PLUS:
			// 		case Keys.EQUALS:
			// 			SpiG.setMute(false);
			// 			SpiG.setMusicVolume(SpiG.getMusicVolume() + 0.1);
			// 			#if SPI_SOUND_TRAY
			// 			showSoundTray();
			// 			#end
			// 			return true;
			// 	}
			// }
		}
		
		#if SPI_RECORD_REPLAY
		if (_replaying)
			return true;
		#end

		SpiG.keys.handleKeyUp(KeyCode);
		
		if(SpiG.fireEvent) {
			_keyboardEvent.type = KeyboardEvent.KEY_UP;
			_keyboardEvent.keyCode = KeyCode;
			stage.dispatchEvent(_keyboardEvent);
		}
		return true;
	}

	/**
	 * Internal event handler for input and focus.
	 * 
	 * @param KeyCode libgdx key code.
	 */
	public function keyDownInternal(KeyCode:Int):Bool
	{
		#if SPI_DEBUG
		if (debuggerUp && debugger.watch.editing)
			return false;
		#end
		
		// Handle pause game keys
		if ((/*KeyCode == Keys.MENU ||*/
			 KeyCode == Keys.F1 || 
			 KeyCode == Keys.ESCAPE) && !SpiG.getDisablePause()) {
			//TODO Move? Remove? Leave?
			//if (!SpiG.getPause())
			//	onFocusLost();
			//else
			//	onFocus();
			SpiG.setPause(!SpiG.getPause());
		}

		#if SPI_RECORD_REPLAY
		if (_replaying && (_replayCancelKeys != null) 
			#if SPI_DEBUG
			&& (debugger == null) 
			#end
			/* (KeyCode != Keys.TILDE) && (KeyCode != Keys.BACKSLASH)*/)
		{
			// boolean cancel = false;
			var replayCancelKey:String;
			var i:Int = 0;
			var l:Int = _replayCancelKeys.length;
			while (i < l) {
				replayCancelKey = _replayCancelKeys[i++];
				if ((replayCancelKey == "ANY") || (SpiG.keys.getKeyCode(replayCancelKey) == KeyCode)) {
					if (_replayCallback != null) {
						_replayCallback();
						_replayCallback = null;
					} else
						SpiG.stopReplay();
					break;
				}
			}
			return true;
		}
		#end

		SpiG.keys.handleKeyDown(KeyCode);
		if(SpiG.fireEvent) {
			_keyboardEvent.type = KeyboardEvent.KEY_DOWN;
			_keyboardEvent.keyCode = KeyCode;
			stage.dispatchEvent(_keyboardEvent);
		}
		return true;
	}

	/**
	 * Handler for typed keys.
	 */
	public function keyTyped(character:String):Bool
	{
		_keyboardEvent.charCode = character;
		_keyboardEvent.type = KeyboardEvent.KEY_TYPED;
		stage.dispatchEvent(_keyboardEvent);
		return true;
	}

	/**
	 * Internal event handler for input and focus.
	 */
	public function touchDown(X:Int, Y:Int, Pointer:Int, Button:Int):Bool
	{
		#if SPI_DEBUG
		if (debuggerUp) {
			if (debugger.hasMouse)
				return false;
			if (debugger.watch.editing)
				debugger.watch.submit();
		}
		#end

		#if SPI_RECORD_REPLAY
		if (_replaying && (_replayCancelKeys != null)) {
			var replayCancelKey:String;
			var i:Int = 0;
			var l:Int = _replayCancelKeys.length;
			while (i < l) {
				replayCancelKey = _replayCancelKeys[i++];
				if ((replayCancelKey == "MOUSE") || (replayCancelKey == "ANY")) {
					if (_replayCallback != null) {
						_replayCallback();
						_replayCallback = null;
					} else
						SpiG.stopReplay();
					break;
				}
			}
			return true;
		}
		#end

		SpiG.mouse.handleMouseDown(X, Y, Pointer, Button);
		_mouseEvent.type = MouseEvent.MOUSE_DOWN;
		_mouseEvent.stageX = X;
		_mouseEvent.stageY = Y;
		stage.dispatchEvent(_mouseEvent);
		return true;
	}

	/**
	 * Internal event handler for input and focus.
	 */
	public function touchUp(X:Int, Y:Int, Pointer:Int, Button:Int):Bool
	{
		#if SPI_DEBUG
		if ((debuggerUp && debugger.hasMouse))
			return true;
		#end

		#if SPI_RECORD_REPLAY		
		if (_replaying)
			return true;
		#end

		SpiG.mouse.handleMouseUp(X, Y, Pointer, Button);
		_mouseEvent.type = MouseEvent.MOUSE_UP;
		_mouseEvent.stageX = X;
		_mouseEvent.stageY = Y;
		stage.dispatchEvent(_mouseEvent);
		return true;
	}

	/**
	 * Internal event handler for input and focus.
	 */
	public function touchMove(X:Int, Y:Int, Pointer:Int):Bool
	{
		#if SPI_DEBUG
		if ((debuggerUp && debugger.hasMouse))
			return true;
		#end

		#if SPI_RECORD_REPLAY		
		if (_replaying)
			return true;
		#end

		SpiG.mouse.handleMouseMove(X, Y, Pointer);
		return true;
	}

	/**
	 * Internal event handler for input and focus.
	 */
	public function mouseWheelInternal(Amount:Int):Bool
	{
		#if SPI_DEBUG
		if ((debuggerUp && debugger.hasMouse))
			return false;
		#end

		#if SPI_RECORD_REPLAY		
		if (_replaying)
			return false;
		#end
		SpiG.mouse.handleMouseWheel(Amount);
		return true;
	}

	/**
	 * Internal event handler for input and focus.
	 */
	public function resume():Void
	{
		#if SPI_FOCUS_LOST_SCREEN
		onFocus();
		#end
	}

	/**
	 * Internal event handler for input and focus.
	 */
	public function pause():Void
	{
		#if SPI_FOCUS_LOST_SCREEN
		onFocusLost();
		#end
	}

	#if SPI_FOCUS_LOST_SCREEN
	/**
	 * Internal event handler for input and focus.
	 */
	private function onFocus():Void
	{
		// if(!debuggerUp && !useSystemCursor)
		// flash.ui.Mouse.hide();
		SpiG.resetInput();
		_lostFocus /*= _focus.visible*/ = false;
		// stage.frameRate = _flashFramerate;
		SpiG.setPause(false);
		//SpiG.restoreShaders();
	}

	/**
	 * Internal event handler for input and focus.
	 */
	private function onFocusLost():Void
	{
		// flash.ui.Mouse.show();
		_lostFocus = /*_focus.visible =*/ true;
		// stage.frameRate = 10;0
		//SpiG.setPause(true);
	}
	#end

	/**
	 * Handles the render call and figures out how many updates and draw calls to do.
	 */
	override
	public function update(): Void
	{
		if(_destroyed)
			return;

		var mark:Float = Scheduler.time();
		_elapsedMS = mark - _total;
		_total = mark;

		// Dispatch the on enter frame event
		stage.dispatchEvent(_onEnterFrame);

		updateSoundTray(_elapsedMS);

		if (!_lostFocus) {
			#if SPI_DEBUG
			if ((debugger != null) && debugger.vcr.paused) {
				if (debugger.vcr.stepRequested) {
					debugger.vcr.stepRequested = false;
					step();
				}
			} else {
			#end
				if (SpiG.fixedTimestep) {
					_accumulator += _elapsedMS;
					if (_accumulator > maxAccumulation) {
						_accumulator = maxAccumulation;
					}

					while (_accumulator > _step) {
						step();
						_accumulator = _accumulator - _step;
					}
				} else {
					step();
				}
			#if SPI_DEBUG
			}
			#end

//			SpiBasic.VISIBLECOUNT = 0;
//			draw();

			#if SPI_DEBUG
			if (debuggerUp) {
				debugger.perf.flash(Std.int(_elapsedMS));
				debugger.perf.visibleObjects(SpiBasic.VISIBLECOUNT);
				debugger.perf.update();
				debugger.watch.update();
			}
			#end
		} else if (_pause.visible && SpiG.getPause()) {
//			SpiBasic.VISIBLECOUNT = 0;
//			draw();
		}
	}

	/**
	 * If there is a state change requested during the update loop, this function handles actual destroying the old state and related processes, and calls creates on the new state
	 * and plugs it into the game object.
	 */
	private function switchState():Void
	{
		if(_destroyed)
			return;

		// Basic reset stuff
		SpiG.resetCameras();
		SpiG.resetInput();
		SpiG.destroySounds();
		SpiG.clearBitmapCache();
		
		// Clear posible lightning stuff
		// SpiG.spriteLightning.clear();
		// SpiG.batch.setShader(null);
		// SpiSprite.currentShader = null;


		#if SPI_DEBUG
		// Clear the debugger overlay's Watch window
		if (debugger != null)
			debugger.watch.removeAll();
		#end

		// Clear any timers left in the timer manager
		var timerManager:SpiTimerManager = SpiTimer.getManager();
		if (timerManager != null)
			timerManager.clear();

		// Destroy the old state (if there is an old state)
		if (_state != null) {
			_state.destroy();
			_pause.secureClear();
			_state = null;
		}

		// Finally assign and create the new state
		_state = requestedState;
		_state.create();
	}

	/**
	 * This is the main game update logic section. The onEnterFrame() handler is in charge of calling this the appropriate number of times each frame. This block handles state
	 * changes, replays, all that good stuff.
	 */
	private function step():Void
	{
		if(_destroyed)
			return;

		// Handle game reset request
		if (_requestedReset) {
			_requestedReset = false;
			//requestedState = ClassReflection.newInstance(_iState);
			_replayTimer = 0;
			_replayCancelKeys = null;
			SpiG.reset();
		}

		#if SPI_RECORD_REPLAY
		// Handle replay-related requests
		if (_recordingRequested) {
			_recordingRequested = false;
			_replay.create(SpiRandom.getRecordingSeed());
			_recording = true;

			#if SPI_DEBUG
			if (debugger != null) {
				debugger.vcr.recording();
				SpiG.log("spiller: starting new spiller gameplay record.");
			}
			#end
		} else if (_replayRequested) {
			_replayRequested = false;
			_replay.rewind();
			SpiG.random.initialSeed = _replay.seed;

			#if SPI_DEBUG
			if (debugger != null)
				debugger.vcr.playing();
			#end

			_replaying = true;
		}
		#end

		// Handle state switching requests
		if (_state != requestedState)
			switchState();

		// Finally actually step through the game physics
		SpiBasic.ACTIVECOUNT = 0;
		#if SPI_RECORD_REPLAY
		if (_replaying) {
			_replay.playNextFrame();
			if (_replayTimer > 0) {
				_replayTimer -= _step;
				if (_replayTimer <= 0) {
					if (_replayCallback != null) {
						_replayCallback();
						_replayCallback = null;
					} else
						SpiG.stopReplay();
				}
			}
			if (_replaying && _replay.finished) {
				SpiG.stopReplay();
				if (_replayCallback != null) {
					_replayCallback();
					_replayCallback = null;
				}
			}

			#if SPI_DEBUG
			if (debugger != null)
				debugger.vcr.updateRuntime(_step);
			#end

		} else
		#end
			SpiG.updateInput();

		#if SPI_RECORD_REPLAY
		// Record the frame if needed
		if (_recording && !SpiG.getPause()) {
			_replay.recordFrame();

			#if SPI_DEBUG
			if (debugger != null)
				debugger.vcr.updateRuntime(_step);
			#end
		}
		#end

		updateInternal();
		SpiG.mouse.wheel = 0;
	
		#if SPI_DEBUG
		if (debuggerUp)
			debugger.perf.activeObjects(SpiBasic.ACTIVECOUNT);
		#end
	}

	/**
	 * This function is called by step() and updates the actual game state. May be called multiple times per "frame" or draw call.
	 */
	private function updateInternal():Void
	{
		if(_destroyed)
			return;

		var mark:Float = Scheduler.time();
		
		if (SpiG.fixedTimestep) {
			SpiG.elapsed = SpiG.timeScale * (_step / 1000); // fixed timestep
		} else {
			SpiG.elapsed = SpiG.timeScale * (_elapsedMS / 1000); // variable timestep

			var max:Float = SpiG.maxElapsed * SpiG.timeScale;
			if (SpiG.elapsed > max)
				SpiG.elapsed = max;
		}

		// If paused update pause stuff only
		if (SpiG.getPause()) {
			_pause.update();
			return;
		}

		SpiG.updateSounds();
		_state.preProcess(); // Execute the pre-process stuff
		SpiG.updatePlugins(); // Update the plugins
		_state.update();
		SpiG.updateCameras();

		// TODO: temporary key for turning on debug, delete when SpiDebugger complete
		if (SpiG.keys.justPressedKeyId(Keys.F2) && (SpiG.debug 
			#if SPI_DEBUG
			|| forceDebugger
			#end
			))
			SpiG.visualDebug = !SpiG.visualDebug;

		#if SPI_DEBUG
		if (debuggerUp)
			debugger.perf.spillerUpdate((int) (System.currentTimeMillis() - mark));
		#end

		_state.postProcess(); // Execute the post process stuff.
	}

	/**
	 * Goes through the game state and draws all the game objects and special effects.
	 */
	//private function draw():Void
	override
	public function render(frame: Framebuffer): Void
	{
		if(_destroyed)
			return;
		
		if(SpiG.batch == null)
			return;

		SpiBasic.VISIBLECOUNT = 0;

		var mark:Float = Scheduler.time();

		var i:Int = 0;
		var l:Int = SpiG.displayList.length;

		// Update the lighning
		// SpiG.spriteLightning.update();

		// Loop and draw every camera
		while (i < l) {
			SpiG.activeCamera = SpiG.displayList[i++];
			
			// Check for 'off' cameras
			if(!SpiG.activeCamera.active)
				continue;

			SpiG.lockCameras();
			_state.draw();

			// Draw the pause menu
			if (SpiG.getPause() && _pause.size() > 0)
				_pause.draw();

			SpiG.unlockCameras();

			// SpiG.drawPlugins();
		}

		// Draw fps display
		// No need to delete because only in debug mode
		if (SpiG.debug || SpiG.showFPS) {
			_backBuffer.g2.begin();
			if(_font != null) {
				SpiG.batch.font = _font;
				SpiG.batch.drawString("fps: " + _fps + " / " + SpiG.getFramerate(), ScreenCanvas.the.width - 160, 0);
			}
//			if(_font != null && SpiG.debug)
//				_font.draw(SpiG.batch, SpiSystemInfo.MemInfo(), 60, 60);
			SpiG.batch.end();
		}

		// Check if we have to draw the mouse
		if (SpiG.mouse.getCursor() != null) {
			// SpiG.batch.setProjectionMatrix(_fontCamera.combined);
			// SpiG.batch.begin();
			// SpiG.gl.glScissor(0, 0, Gdx.graphics.getWidth(), Gdx.graphics.getHeight());
			SpiG.mouse.getCursor().draw();
			// SpiG.batch.end();
		}

		#if SPI_DEBUG
		// Check if the debugger is up
		if (debuggerUp)
			debugger.perf.spillerDraw(Std.int(Scheduler.time() - mark));
		#end
	}

	/**
	 * Used to instantiate the guts of the spiller game object once we have a valid reference to the root.
	 */
	override
	public function init(): Void
	{
		if (_created)
			return;

		_total = Scheduler.time();

		// // Set up the listener
		// Gdx.input.setCatchBackKey(true);
		// Gdx.input.setCatchMenuKey(true);

		// // Set up OpenGL
		// SpiG.gl = Gdx.gl20;

		// // Common OpenGL
		// SpiG.gl.glEnable(GL20.GL_SCISSOR_TEST);
		// SpiG.gl.glDisable(GL20.GL_CULL_FACE);
		// SpiG.gl.glDisable(GL20.GL_DITHER);
		// SpiG.gl.glDisable(GL20.GL_DEPTH_TEST);

		_backBuffer = Image.createRenderTarget(SpiG.width, SpiG.height);
		SpiG.batch = _backBuffer.g2;
		SpiG.flashGfx = Graphics.initGraphics();

		// Catch the cursor if we have to
		if (!useSystemCursor) {
			// Gdx.input.setCursorCatched(true);
		}

		// Add basic input event listeners and mouse container
		Keyboard.get().notify(onKeyDown, onKeyUp);
		Mouse.get().notify(onMouseDown, onMouseUp, onMouseMove, onMouseWheel);
		if (Surface.get() != null) {
			Surface.get().notify(onTouchStart, onTouchEnd, onTouchMove);
		}
		_mouseEvent = new MouseEvent(null, 0, 0);
		_keyboardEvent = new KeyboardEvent(null);
		_onEnterFrame = new EnterFrameEvent(EnterFrameEvent.ENTER_FRAME);

		// Detect whether or not we're running on a mobile device or not
		// If we are running on a OUYA we consider that as Desktop
		// SpiG.mobile = (Gdx.app.getType() != ApplicationType.Desktop && !SpiG.inOuya);

		// Initialize the assets and create the font
		var fs:FontStyle = new FontStyle(false, false, false);
		_font = cast(Loader.the.loadFont("spiller/data/font/nokiafc22.fnt", fs, 12), Kravur);

		// Let mobile devs opt out of unnecessary overlays.
		if (!SpiG.mobile) {
			#if SPI_DEBUG
			// Debugger overlay
			if (SpiG.debug || forceDebugger) {
				debugger = new SpiDebugger(SpiG.width*SpiCamera.defaultZoom,SpiG.height*SpiCamera.defaultZoom);
				addChild(debugger);
			}
			#end

			#if SPI_SOUND_TRAY
			// Volume display tab
			createSoundTray();
			#end

			#if FOCUS_LOST_SCREEN
			// Focus gained/lost monitoring
			createFocusScreen();
			#end
		}

		_pause = new SpiPause();

		_created = true;
	}

	// override
	// public void resize(int Width, int Height)
	// {
	// 	if(_destroyed)
	// 		return;

	// 	SpiG.screenWidth = Width;
	// 	SpiG.screenHeight = Height;

	// 	// Reset all the cameras
	// 	for (SpiCamera camera : SpiG.cameras)
	// 		camera.setScaleMode(camera.getScaleMode());
	// }

	/**
	 * {@inheritDoc}
	 */
	public function dispose():Void
	{		
		_destroyed = true;

		if (_font != null) {
			_font = null;
		}
		if (_state != null) {
			_state.destroy();
			_state = null;
		}

		_mouseEvent = null;
		_keyboardEvent = null;
		SpiG.reset();

		SpiG.disposeAssetManager();
		// if (SpiG.batch != null) {
		// 	SpiG.batch.dispose();
		// 	SpiG.batch = null;
		// }
		// if (SpiG.flashGfx != null) {
		// 	SpiG.flashGfx.dispose();
		// 	SpiG.flashGfx = null;
		// }
	}

	#if SPI_SOUND_TRAY
	/**
	 * Sets up the "sound tray", the little volume meter that pops down sometimes.
	 */
	// TODO: Sound tray
	private function createSoundTray():Void
	{
		// _soundTray.visible = false;
		// _soundTray.scaleX = 2;
		// _soundTray.scaleY = 2;
		// var tmp:Bitmap = new Bitmap(new BitmapData(80,30,true,0x7F000000));
		// _soundTray.x = (SpiG.width/2)*SpiCamera.defaultZoom-(tmp.width/2)*_soundTray.scaleX;
		// _soundTray.addChild(tmp);

		// var text:TextField = new TextField();
		// text.width = tmp.width;
		// text.height = tmp.height;
		// text.multiline = true;
		// text.wordWrap = true;
		// text.selectable = false;
		// text.embedFonts = true;
		// text.antiAliasType = AntiAliasType.NORMAL;
		// text.gridFitType = GridFitType.PIXEL;
		// text.defaultTextFormat = new TextFormat("system",8,0xffffff,null,null,null,null,null,"center");;
		// _soundTray.addChild(text);
		// text.text = "VOLUME";
		// text.y = 16;

		// var bx:uint = 10;
		// var by:uint = 14;
		// _soundTrayBars = new Array();
		// var i:uint = 0;
		// while(i < 10)
		// {
		// tmp = new Bitmap(new BitmapData(4,++i,false,0xffffff));
		// tmp.x = bx;
		// tmp.y = by;
		// _soundTrayBars.push(_soundTray.addChild(tmp));
		// bx += 6;
		// by--;
		// }

		// _soundTray.y = -_soundTray.height;
		// _soundTray.visible = false;
		// addChild(_soundTray);

		// TODO: Load saved sound preferences for this game if they exist
		// SpiSavePref soundPrefs = new SpiSavePref();
		// if(soundPrefs.bind("spiller"))// && (soundPrefs.data.get("sound") != null))
		// {
		// if(soundPrefs.data.get("musicVolume", Float.class) != null)
		// SpiG.setMusicVolume(soundPrefs.data.get("musicVolume", Float.class));
		// if(soundPrefs.data.get("soundVolume", Float.class) != null)
		// SpiG.setSoundVolume(soundPrefs.data.get("soundVolume", Float.class));
		// if(soundPrefs.data.get("mute", Boolean.class) != null)
		// SpiG.setMute(soundPrefs.data.get("mute", Boolean.class));
		// soundPrefs.destroy();
		// }
	}

	/**
	 * Makes the little volume tray slide out.
	 * 
	 * @param Silent Whether or not it should beep.
	 */
	private function showSoundTray(Silent:Bool = false)
	{
	// 	// if(!Silent)
	// 	// SpiG.play(SndBeep);
	// 	if (_soundTray != null) {
	// 		_soundTrayTimer = 1;
	// 		_soundTray.y = 0;
	// 		_soundTray.visible = true;
	// 		int globalVolume = Math.round(SpiG.getMusicVolume() * 10);
	// 		if (SpiG.getMute())
	// 			globalVolume = 0;
	// 		for (int i = 0; i < _soundTrayBars.size; i++) {
	// 			if (i < globalVolume)
	// 				_soundTrayBars.get(i).setAlpha(1);
	// 			else
	// 				_soundTrayBars.get(i).setAlpha(0.5f);
	// 		}
	// 	}
	}

	/**
	 * This function just updates the soundtray object.
	 */
	private function updateSoundTray(MS:Float):Void
	{
	// 	// Animate stupid sound tray thing

	// 	if (_soundTray != null) {
	// 		if (_soundTrayTimer > 0)
	// 			_soundTrayTimer -= MS / 1000;
	// 		else if (_soundTray.y > -_soundTray.height) {
	// 			_soundTray.y -= (MS / 1000) * SpiG.height * 2;
	// 			if (_soundTray.y <= -_soundTray.height) {
	// 				_soundTray.visible = false;

	// 				// TODO: Save sound preferences
	// 				// SpiSavePref soundPrefs = new SpiSavePref();
	// 				// if(soundPrefs.bind("spiller"))
	// 				// {
	// 				// soundPrefs.data.put("mute", SpiG.volumeHandler.mute);
	// 				// soundPrefs.data.put("musicVolume", SpiG.volumeHandler.musicVolume);
	// 				// soundPrefs.data.put("soundVolume", SpiG.volumeHandler.soundVolume);
	// 				// soundPrefs.close();
	// 				// }
	// 			}
	// 		}
	// 	}
	}
	#end

	#if SPI_FOCUS_LOST_SCREEN
	/**
	 * Sets up the darkened overlay with the big white "play" button that appears when a spiller game loses focus.
	 */
	// TODO: Focus screen
	private function createFocusScreen():Void
	{
		// var gfx:Graphics = _focus.graphics;
		// var screenWidth:uint = SpiG.width*SpiCamera.defaultZoom;
		// var screenHeight:uint = SpiG.height*SpiCamera.defaultZoom;

		// draw transparent black backdrop
		// gfx.moveTo(0,0);
		// gfx.beginFill(0,0.5);
		// gfx.lineTo(screenWidth,0);
		// gfx.lineTo(screenWidth,screenHeight);
		// gfx.lineTo(0,screenHeight);
		// gfx.lineTo(0,0);
		// gfx.endFill();

		// draw white arrow
		// var halfWidth:uint = screenWidth/2;
		// var halfHeight:uint = screenHeight/2;
		// var helper:uint = SpiU.min(halfWidth,halfHeight)/3;
		// gfx.moveTo(halfWidth-helper,halfHeight-helper);
		// gfx.beginFill(0xffffff,0.65);
		// gfx.lineTo(halfWidth+helper,halfHeight);
		// gfx.lineTo(halfWidth-helper,halfHeight+helper);
		// gfx.lineTo(halfWidth-helper,halfHeight-helper);
		// gfx.endFill();

		// var logo:Bitmap = new ImgLogo();
		// logo.scaleX = int(helper/10);
		// if(logo.scaleX < 1)
		// logo.scaleX = 1;
		// logo.scaleY = logo.scaleX;
		// logo.x -= logo.scaleX;
		// logo.alpha = 0.35;
		// _focus.addChild(logo);

		// addChild(_focus);
	}
	#end
}