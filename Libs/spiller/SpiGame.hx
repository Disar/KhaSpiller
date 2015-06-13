package spiller;

import kha.Game;
import kha.Image;
import kha.Font;

import spiller.system.flash.Graphics;
import spiller.system.flash.SpiGameStage;
import spiller.system.flash.events.Event;
import spiller.system.flash.events.KeyboardEvent;
import spiller.system.flash.events.MouseEvent;
import spiller.system.debug.SpiDebugger;
import spiller.system.replay.SpiReplay;
import spiller.system.SpiPause;

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
	 * Class type of the initial/first game state for the game, usually MenuState or something like that.
	 */
	private var _iState:Class<SpiState>;
	/**
	 * Whether the game object's basic initialization has finished yet.
	 */
	private var _created:Bool;
	/**
	 * Total number of milliseconds elapsed since game start.
	 */
	private var _total:Int = 0;
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
	private var step:Int;
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
	/**
	 * The "focus lost" screen (see <code>createFocusScreen()</code>).
	 */
	private var _focus:Image;

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
	private var _font:Font;
	/**
	 * Temporary camera to display the fps.
	 */
	// private var _fontCamera:OrthographicCamera;
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
	public function new(GameSizeX:Int, GameSizeY:Int, InitialState:Class<SpiState>, Zoom:Float = 1, GameFramerate:Int = 60, FlashFramerate:Int = 60, UseSystemCursor:Bool = true, ScaleMode:Int = SpiCamera.STRETCH)
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
		_accumulator = Std.int(step);
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
		// if(SpiGame.useSplashScreen) {
			// _iState = SpiSplashScreen;
			// SpiSplashScreen.initialGameState = InitialState; // Set the initial game state after the spash screen
		// } else {
			_iState = InitialState;
		// }
		requestedState = null;
		_requestedReset = true;
		_created = false;
		_destroyed = false;
	}

	// /**
	//  * Internal event handler for input and focus.
	//  * 
	//  * @param KeyCode A libgdx key code.
	//  */
	// override
	// public boolean keyUp(int KeyCode)
	// {
	// 	if (debuggerUp && debugger.watch.editing)
	// 		return false;

	// 	if (!SpiG.mobile) {
	// 		if ((debugger != null) && ((KeyCode == Keys.APOSTROPHE) || (KeyCode == Keys.BACKSLASH))) {
	// 			debugger.visible = !debugger.visible;
	// 			debuggerUp = debugger.visible;

	// 			/*
	// 			 * if(debugger.visible) flash.ui.Mouse.show(); else if(!useSystemCursor) flash.ui.Mouse.hide();
	// 			 */
	// 			// _console.toggle();
	// 			return true;
	// 		}
	// 		if (useSoundHotKeys) {
	// 			int c = KeyCode;
	// 			// String code = String.fromCharCode(KeyCode);
	// 			switch (c) {
	// 				case Keys.NUM_0:
	// 					SpiG.setMute(!SpiG.getMute());
	// 					if (SpiG.volumeCallback != null)
	// 						SpiG.volumeCallback.onChange(SpiG.getMute() ? 0 : SpiG.getMusicVolume(), SpiSound.ALL);
	// 					showSoundTray();
	// 					return true;
	// 				case Keys.MINUS:
	// 					SpiG.setMute(false);
	// 					SpiG.setMusicVolume(SpiG.getMusicVolume() - 0.1f);
	// 					showSoundTray();
	// 					return true;
	// 				case Keys.PLUS:
	// 				case Keys.EQUALS:
	// 					SpiG.setMute(false);
	// 					SpiG.setMusicVolume(SpiG.getMusicVolume() + 0.1f);
	// 					showSoundTray();
	// 					return true;
	// 				default:
	// 					break;
	// 			}
	// 		}
	// 	}
	// 	if (_replaying)
	// 		return true;

	// 	SpiG.keys.handleKeyUp(KeyCode);
		
	// 	if(SpiG.fireEvent) {
	// 		_keyboardEvent.type = KeyboardEvent.KEY_UP;
	// 		_keyboardEvent.keyCode = KeyCode;
	// 		stage.dispatchEvent(_keyboardEvent);
	// 	}
	// 	return true;
	// }

	// /**
	//  * Internal event handler for input and focus.
	//  * 
	//  * @param KeyCode libgdx key code.
	//  */
	// override
	// public boolean keyDown(int KeyCode)
	// {
	// 	if (debuggerUp && debugger.watch.editing)
	// 		return false;
		
	// 	// Handle pause game keys
	// 	if ((KeyCode == Keys.MENU || KeyCode == Keys.F1 || KeyCode == Keys.ESCAPE) && !SpiG.getDisablePause()) {
	// 		//TODO Move? Remove? Leave?
	// 		//if (!SpiG.getPause())
	// 		//	onFocusLost();
	// 		//else
	// 		//	onFocus();
	// 		SpiG.setPause(!SpiG.getPause());
	// 	}

	// 	if (_replaying && (_replayCancelKeys != null) && (debugger == null) && /* (KeyCode != Keys.TILDE) && */(KeyCode != Keys.BACKSLASH)) {
	// 		// boolean cancel = false;
	// 		String replayCancelKey;
	// 		int i = 0;
	// 		int l = _replayCancelKeys.size;
	// 		while (i < l) {
	// 			replayCancelKey = _replayCancelKeys.get(i++);
	// 			if ((replayCancelKey == "ANY") || (SpiG.keys.getKeyCode(replayCancelKey) == KeyCode)) {
	// 				if (_replayCallback != null) {
	// 					_replayCallback.callback();
	// 					_replayCallback = null;
	// 				} else
	// 					SpiG.stopReplay();
	// 				break;
	// 			}
	// 		}
	// 		return true;
	// 	}

	// 	SpiG.keys.handleKeyDown(KeyCode);
	// 	if(SpiG.fireEvent) {
	// 		_keyboardEvent.type = KeyboardEvent.KEY_DOWN;
	// 		_keyboardEvent.keyCode = KeyCode;
	// 		stage.dispatchEvent(_keyboardEvent);
	// 	}
	// 	return true;
	// }

	// override
	// public boolean keyTyped(char character)
	// {
	// 	_keyboardEvent.charCode = character;
	// 	_keyboardEvent.type = KeyboardEvent.KEY_TYPED;
	// 	stage.dispatchEvent(_keyboardEvent);
	// 	return true;
	// }

	// /**
	//  * Internal event handler for input and focus.
	//  */
	// override
	// public boolean touchDown(int X, int Y, int Pointer, int Button)
	// {
	// 	if (debuggerUp) {
	// 		if (debugger.hasMouse)
	// 			return false;
	// 		if (debugger.watch.editing)
	// 			debugger.watch.submit();
	// 	}

	// 	if (_replaying && (_replayCancelKeys != null)) {
	// 		String replayCancelKey;
	// 		int i = 0;
	// 		int l = _replayCancelKeys.size;
	// 		while (i < l) {
	// 			replayCancelKey = _replayCancelKeys.get(i++);
	// 			if ((replayCancelKey == "MOUSE") || (replayCancelKey == "ANY")) {
	// 				if (_replayCallback != null) {
	// 					_replayCallback.callback();
	// 					_replayCallback = null;
	// 				} else
	// 					SpiG.stopReplay();
	// 				break;
	// 			}
	// 		}
	// 		return true;
	// 	}

	// 	SpiG.mouse.handleMouseDown(X, Y, Pointer, Button);
	// 	_mouseEvent.type = MouseEvent.MOUSE_DOWN;
	// 	_mouseEvent.stageX = X;
	// 	_mouseEvent.stageY = Y;
	// 	stage.dispatchEvent(_mouseEvent);
	// 	return true;
	// }

	// /**
	//  * Internal event handler for input and focus.
	//  */
	// override
	// public boolean touchUp(int X, int Y, int Pointer, int Button)
	// {
	// 	if ((debuggerUp && debugger.hasMouse) || _replaying)
	// 		return true;
	// 	SpiG.mouse.handleMouseUp(X, Y, Pointer, Button);
	// 	_mouseEvent.type = MouseEvent.MOUSE_UP;
	// 	_mouseEvent.stageX = X;
	// 	_mouseEvent.stageY = Y;
	// 	stage.dispatchEvent(_mouseEvent);
	// 	return true;
	// }

	// /**
	//  * Internal event handler for input and focus.
	//  */
	// override
	// public boolean scrolled(int Amount)
	// {
	// 	if ((debuggerUp && debugger.hasMouse) || _replaying)
	// 		return false;
	// 	SpiG.mouse.handleMouseWheel(Amount);
	// 	return true;
	// }

	// /**
	//  * Internal event handler for input and focus.
	//  */
	// override
	// public boolean touchDragged(int X, int Y, int Pointer)
	// {
	// 	return false;
	// }

	// override
	// public boolean mouseMoved(int x, int y)
	// {
	// 	return false;
	// }

	// /**
	//  * Internal event handler for input and focus.
	//  */
	// override
	// public void resume()
	// {
	// 	onFocus();
	// }

	// /**
	//  * Internal event handler for input and focus.
	//  */
	// override
	// public void pause()
	// {
	// 	onFocusLost();
	// }

	// /**
	//  * Internal event handler for input and focus.
	//  */
	// private void onFocus()
	// {
	// 	// if(!debuggerUp && !useSystemCursor)
	// 	// flash.ui.Mouse.hide();
	// 	SpiG.resetInput();
	// 	_lostFocus /*= _focus.visible*/ = false;
	// 	// stage.frameRate = _flashFramerate;
	// 	//SpiG.setPause(false);
	// 	SpiG.restoreShaders();
	// }

	// /**
	//  * Internal event handler for input and focus.
	//  */
	// private void onFocusLost()
	// {
	// 	// flash.ui.Mouse.show();
	// 	_lostFocus = /*_focus.visible =*/ true;
	// 	// stage.frameRate = 10;0
	// 	//SpiG.setPause(true);
	// }

	// /**
	//  * Handles the render call and figures out how many updates and draw calls to do.
	//  */
	// override
	// public void render()
	// {
	// 	if(_destroyed)
	// 		return;

	// 	long mark = System.currentTimeMillis();
	// 	_elapsedMS = mark - _total;
	// 	_total = mark;

	// 	// Dispatch the on enter frame event
	// 	stage.dispatchEvent(_onEnterFrame);

	// 	updateSoundTray(_elapsedMS);

	// 	if (!_lostFocus) {
	// 		if ((debugger != null) && debugger.vcr.paused) {
	// 			if (debugger.vcr.stepRequested) {
	// 				debugger.vcr.stepRequested = false;
	// 				step();
	// 			}
	// 		} else {
	// 			if (SpiG.fixedTimestep) {
	// 				_accumulator += _elapsedMS;
	// 				if (_accumulator > maxAccumulation) {
	// 					_accumulator = maxAccumulation;
	// 				}

	// 				while (_accumulator > step) {
	// 					step();
	// 					_accumulator = _accumulator - step;
	// 				}
	// 			} else {
	// 				step();
	// 			}
	// 		}

	// 		SpiBasic.VISIBLECOUNT = 0;
	// 		draw();

	// 		if (debuggerUp) {
	// 			debugger.perf.flash((int) _elapsedMS);
	// 			debugger.perf.visibleObjects(SpiBasic.VISIBLECOUNT);
	// 			debugger.perf.update();
	// 			debugger.watch.update();
	// 		}
	// 	} else if (_pause.visible && SpiG.getPause()) {
	// 		SpiBasic.VISIBLECOUNT = 0;
	// 		draw();
	// 	}
	// }

	// /**
	//  * If there is a state change requested during the update loop, this function handles actual destroying the old state and related processes, and calls creates on the new state
	//  * and plugs it into the game object.
	//  */
	// private void switchState()
	// {
	// 	if(_destroyed)
	// 		return;

	// 	// Basic reset stuff
	// 	SpiG.resetCameras();
	// 	SpiG.resetInput();
	// 	SpiG.destroySounds();
	// 	SpiG.clearBitmapCache();
		
	// 	// Clear posible lightning stuff
	// 	SpiG.spriteLightning.clear();
	// 	SpiG.batch.setShader(null);
	// 	SpiSprite.currentShader = null;

	// 	// Clear the debugger overlay's Watch window
	// 	if (debugger != null)
	// 		debugger.watch.removeAll();

	// 	// Clear any timers left in the timer manager
	// 	SpiTimerManager timerManager = SpiTimer.getManager();
	// 	if (timerManager != null)
	// 		timerManager.clear();

	// 	// Destroy the old state (if there is an old state)
	// 	if (_state != null) {
	// 		_state.destroy();
	// 		_pause.secureClear();
	// 		_state = null;
	// 	}

	// 	// Finally assign and create the new state
	// 	_state = requestedState;
	// 	_state.create();
	// }

	// /**
	//  * This is the main game update logic section. The onEnterFrame() handler is in charge of calling this the appropriate number of times each frame. This block handles state
	//  * changes, replays, all that good stuff.
	//  */
	// private void step()
	// {
	// 	if(_destroyed)
	// 		return;

	// 	// Handle game reset request
	// 	if (_requestedReset) {
	// 		_requestedReset = false;
	// 		try {
	// 			requestedState = ClassReflection.newInstance(_iState);
	// 		} catch (Exception e) {
	// 			throw new RuntimeException(e);
	// 		}
	// 		_replayTimer = 0;
	// 		_replayCancelKeys = null;
	// 		SpiG.reset();
	// 	}

	// 	// Handle replay-related requests
	// 	if (_recordingRequested) {
	// 		_recordingRequested = false;
	// 		_replay.create(SpiG.getGlobalSeed());
	// 		_recording = true;
	// 		if (debugger != null) {
	// 			debugger.vcr.recording();
	// 			SpiG.log("spiller: starting new spiller gameplay record.");
	// 		}
	// 	} else if (_replayRequested) {
	// 		_replayRequested = false;
	// 		_replay.rewind();
	// 		SpiG.setGlobalSeed(_replay.seed);
	// 		if (debugger != null)
	// 			debugger.vcr.playing();
	// 		_replaying = true;
	// 	}

	// 	// Handle state switching requests
	// 	if (_state != requestedState)
	// 		switchState();

	// 	// Finally actually step through the game physics
	// 	SpiBasic.ACTIVECOUNT = 0;
	// 	if (_replaying) {
	// 		_replay.playNextFrame();
	// 		if (_replayTimer > 0) {
	// 			_replayTimer -= step;
	// 			if (_replayTimer <= 0) {
	// 				if (_replayCallback != null) {
	// 					_replayCallback.callback();
	// 					_replayCallback = null;
	// 				} else
	// 					SpiG.stopReplay();
	// 			}
	// 		}
	// 		if (_replaying && _replay.finished) {
	// 			SpiG.stopReplay();
	// 			if (_replayCallback != null) {
	// 				_replayCallback.callback();
	// 				_replayCallback = null;
	// 			}
	// 		}
	// 		if (debugger != null)
	// 			debugger.vcr.updateRuntime(step);
	// 	} else
	// 		SpiG.updateInput();

	// 	// Record the frame if needed
	// 	if (_recording && !SpiG.getPause()) {
	// 		_replay.recordFrame();
	// 		if (debugger != null)
	// 			debugger.vcr.updateRuntime(step);
	// 	}

	// 	update();
	// 	SpiG.mouse.wheel = 0;
	// 	if (debuggerUp)
	// 		debugger.perf.activeObjects(SpiBasic.ACTIVECOUNT);
	// }

	// /**
	//  * This function is called by step() and updates the actual game state. May be called multiple times per "frame" or draw call.
	//  */
	// private void update()
	// {
	// 	if(_destroyed)
	// 		return;

	// 	long mark = System.currentTimeMillis();
		
	// 	if (SpiG.fixedTimestep) {
	// 		SpiG.elapsed = SpiG.timeScale * (step / 1000.f); // fixed timestep
	// 	} else {
	// 		SpiG.elapsed = SpiG.timeScale * (_elapsedMS / 1000); // variable timestep

	// 		float max = SpiG.maxElapsed * SpiG.timeScale;
	// 		if (SpiG.elapsed > max)
	// 			SpiG.elapsed = max;
	// 	}

	// 	// If paused update pause stuff only
	// 	if (SpiG.getPause()) {
	// 		_pause.update();
	// 		return;
	// 	}

	// 	SpiG.updateSounds();
	// 	_state.preProcess(); // Execute the pre-process stuff
	// 	SpiG.updatePlugins(); // Update the plugins
	// 	_state.update();
	// 	SpiG.updateCameras();

	// 	// TODO: temporary key for turning on debug, delete when SpiDebugger complete
	// 	if (SpiG.keys.justPressed(Keys.F2) && (SpiG.debug || forceDebugger))
	// 		SpiG.visualDebug = !SpiG.visualDebug;

	// 	if (debuggerUp)
	// 		debugger.perf.spillerUpdate((int) (System.currentTimeMillis() - mark));

	// 	_state.postProcess(); // Execute the post process stuff.
	// }

	// /**
	//  * Goes through the game state and draws all the game objects and special effects.
	//  */
	// private void draw()
	// {
	// 	if(_destroyed)
	// 		return;
		
	// 	if(SpiG.batch == null)
	// 		return;

	// 	long mark = System.currentTimeMillis();

	// 	int i = 0;
	// 	int l = SpiG.displayList.size;

	// 	// Clear the whole screen (needed for iOS RoboVM)
	// 	if (Gdx.app.getType() == ApplicationType.iOS)
	// 		Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
		
	// 	// Update the lighning
	// 	SpiG.spriteLightning.update();

	// 	// Loop and draw every camera
	// 	while (i < l) {
	// 		SpiG.activeCamera = SpiG.displayList.get(i++);
			
	// 		// Check for 'off' cameras
	// 		if(!SpiG.activeCamera.active)
	// 			continue;

	// 		SpiG.lockCameras();
	// 		_state.draw();

	// 		// Draw the pause menu
	// 		if (SpiG.getPause() && _pause.size() > 0)
	// 			_pause.draw();

	// 		SpiG.unlockCameras();

	// 		SpiG.drawPlugins();
	// 	}

	// 	// Draw fps display
	// 	// No need to delete because only in debug mode
	// 	if (SpiG.debug || SpiG.showFPS) {
	// 		SpiG.batch.setProjectionMatrix(_fontCamera.combined);
	// 		SpiG.batch.begin();
	// 		SpiG.gl.glScissor(0, 0, Gdx.graphics.getWidth(), Gdx.graphics.getHeight());
	// 		if(_font != null)
	// 			_font.draw(SpiG.batch, "fps: " + Gdx.graphics.getFramesPerSecond() + " / " + SpiG.getFramerate(), Gdx.graphics.getWidth() - 160, 0);
	// 		if(_font != null && SpiG.debug)
	// 			_font.draw(SpiG.batch, SpiSystemInfo.MemInfo(), 60, 60);
	// 		SpiG.batch.end();
	// 	}

	// 	// Check if we have to draw the mouse
	// 	if (SpiG.mouse.getCursor() != null) {
	// 		SpiG.batch.setProjectionMatrix(_fontCamera.combined);
	// 		SpiG.batch.begin();
	// 		SpiG.gl.glScissor(0, 0, Gdx.graphics.getWidth(), Gdx.graphics.getHeight());
	// 		SpiG.mouse.getCursor().draw();
	// 		SpiG.batch.end();
	// 	}
	// 	// Check if the debugger is up
	// 	if (debuggerUp)
	// 		debugger.perf.spillerDraw((int) (System.currentTimeMillis() - mark));
	// }

	/**
	 * Used to instantiate the guts of the spiller game object once we have a valid reference to the root.
	 */
	override
	public function init(): Void
	{
		if (_created)
			return;

		_total = System.currentTimeMillis();

		// Set up the listener
		Gdx.input.setCatchBackKey(true);
		Gdx.input.setCatchMenuKey(true);

		// Set up OpenGL
		SpiG.gl = Gdx.gl20;

		// Common OpenGL
		SpiG.gl.glEnable(GL20.GL_SCISSOR_TEST);
		SpiG.gl.glDisable(GL20.GL_CULL_FACE);
		SpiG.gl.glDisable(GL20.GL_DITHER);
		SpiG.gl.glDisable(GL20.GL_DEPTH_TEST);

		SpiG.batch = new SpriteBatch();
		SpiG.flashGfx = Graphics.initGraphics();

		// Catch the cursor if we have to
		if (!useSystemCursor) {
			Gdx.input.setCursorCatched(true);
		}

		// Add basic input event listeners and mouse container
		SpiG.inputs.addProcessor(this);
		Gdx.input.setInputProcessor(SpiG.inputs);
		_mouseEvent = new MouseEvent(null, 0, 0);
		_keyboardEvent = new KeyboardEvent(null);
		_onEnterFrame = new EnterFrameEvent(EnterFrameEvent.ENTER_FRAME);

		// Detect whether or not we're running on a mobile device or not
		// If we are running on a OUYA we consider that as Desktop
		SpiG.mobile = (Gdx.app.getType() != ApplicationType.Desktop && !SpiG.inOuya);

		// Initialize the assets and create the font
		try {
			_font = new BitmapFont(Gdx.files.classpath("com/ratalaika/spiller/data/font/nokiafc22.fnt"), Gdx.files.classpath("com/ratalaika/spiller/data/font/nokiafc22.png"), true);
			_font.getData().setScale(2);
		} catch(Exception e) {}
		_fontCamera = new OrthographicCamera();
		_fontCamera.setToOrtho(true);

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

			// Focus gained/lost monitoring
			createFocusScreen();
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

	// /**
	//  * {@inheritDoc}
	//  */
	// override
	// public function dispose():Void
	// {		
	// 	_destroyed = true;

	// 	if (_font != null) {
	// 		_font.dispose();
	// 		_font = null;
	// 	}
	// 	if (_state != null) {
	// 		_state.destroy();
	// 		_state = null;
	// 	}

	// 	_mouseEvent = null;
	// 	_keyboardEvent = null;
	// 	SpiG.reset();

	// 	SpiG.disposeAssetManager();
	// 	if (SpiG.batch != null) {
	// 		SpiG.batch.dispose();
	// 		SpiG.batch = null;
	// 	}
	// 	if (SpiG.flashGfx != null) {
	// 		SpiG.flashGfx.dispose();
	// 		SpiG.flashGfx = null;
	// 	}
	// 	System.gc();
	// }

	#if SPI_SOUND_TRAY
	// /**
	//  * Sets up the "sound tray", the little volume meter that pops down sometimes.
	//  */
	// // TODO: Sound tray
	// private void createSoundTray()
	// {
	// 	// _soundTray.visible = false;
	// 	// _soundTray.scaleX = 2;
	// 	// _soundTray.scaleY = 2;
	// 	// var tmp:Bitmap = new Bitmap(new BitmapData(80,30,true,0x7F000000));
	// 	// _soundTray.x = (SpiG.width/2)*SpiCamera.defaultZoom-(tmp.width/2)*_soundTray.scaleX;
	// 	// _soundTray.addChild(tmp);

	// 	// var text:TextField = new TextField();
	// 	// text.width = tmp.width;
	// 	// text.height = tmp.height;
	// 	// text.multiline = true;
	// 	// text.wordWrap = true;
	// 	// text.selectable = false;
	// 	// text.embedFonts = true;
	// 	// text.antiAliasType = AntiAliasType.NORMAL;
	// 	// text.gridFitType = GridFitType.PIXEL;
	// 	// text.defaultTextFormat = new TextFormat("system",8,0xffffff,null,null,null,null,null,"center");;
	// 	// _soundTray.addChild(text);
	// 	// text.text = "VOLUME";
	// 	// text.y = 16;

	// 	// var bx:uint = 10;
	// 	// var by:uint = 14;
	// 	// _soundTrayBars = new Array();
	// 	// var i:uint = 0;
	// 	// while(i < 10)
	// 	// {
	// 	// tmp = new Bitmap(new BitmapData(4,++i,false,0xffffff));
	// 	// tmp.x = bx;
	// 	// tmp.y = by;
	// 	// _soundTrayBars.push(_soundTray.addChild(tmp));
	// 	// bx += 6;
	// 	// by--;
	// 	// }

	// 	// _soundTray.y = -_soundTray.height;
	// 	// _soundTray.visible = false;
	// 	// addChild(_soundTray);

	// 	// TODO: Load saved sound preferences for this game if they exist
	// 	// SpiSavePref soundPrefs = new SpiSavePref();
	// 	// if(soundPrefs.bind("spiller"))// && (soundPrefs.data.get("sound") != null))
	// 	// {
	// 	// if(soundPrefs.data.get("musicVolume", Float.class) != null)
	// 	// SpiG.setMusicVolume(soundPrefs.data.get("musicVolume", Float.class));
	// 	// if(soundPrefs.data.get("soundVolume", Float.class) != null)
	// 	// SpiG.setSoundVolume(soundPrefs.data.get("soundVolume", Float.class));
	// 	// if(soundPrefs.data.get("mute", Boolean.class) != null)
	// 	// SpiG.setMute(soundPrefs.data.get("mute", Boolean.class));
	// 	// soundPrefs.destroy();
	// 	// }
	// }

	// /**
	//  * Makes the little volume tray slide out.
	//  * 
	//  * @param Silent Whether or not it should beep.
	//  */
	// private void showSoundTray(boolean Silent = false)
	// {
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
	// }

	// /**
	//  * This function just updates the soundtray object.
	//  */
	// private void updateSoundTray(float MS)
	// {
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
	// }
	#end

	// /**
	//  * Sets up the darkened overlay with the big white "play" button that appears when a spiller game loses focus.
	//  */
	// // TODO: Focus screen
	// private void createFocusScreen()
	// {
	// 	// var gfx:Graphics = _focus.graphics;
	// 	// var screenWidth:uint = SpiG.width*SpiCamera.defaultZoom;
	// 	// var screenHeight:uint = SpiG.height*SpiCamera.defaultZoom;

	// 	// draw transparent black backdrop
	// 	// gfx.moveTo(0,0);
	// 	// gfx.beginFill(0,0.5);
	// 	// gfx.lineTo(screenWidth,0);
	// 	// gfx.lineTo(screenWidth,screenHeight);
	// 	// gfx.lineTo(0,screenHeight);
	// 	// gfx.lineTo(0,0);
	// 	// gfx.endFill();

	// 	// draw white arrow
	// 	// var halfWidth:uint = screenWidth/2;
	// 	// var halfHeight:uint = screenHeight/2;
	// 	// var helper:uint = SpiU.min(halfWidth,halfHeight)/3;
	// 	// gfx.moveTo(halfWidth-helper,halfHeight-helper);
	// 	// gfx.beginFill(0xffffff,0.65);
	// 	// gfx.lineTo(halfWidth+helper,halfHeight);
	// 	// gfx.lineTo(halfWidth-helper,halfHeight+helper);
	// 	// gfx.lineTo(halfWidth-helper,halfHeight-helper);
	// 	// gfx.endFill();

	// 	// var logo:Bitmap = new ImgLogo();
	// 	// logo.scaleX = int(helper/10);
	// 	// if(logo.scaleX < 1)
	// 	// logo.scaleX = 1;
	// 	// logo.scaleY = logo.scaleX;
	// 	// logo.x -= logo.scaleX;
	// 	// logo.alpha = 0.35;
	// 	// _focus.addChild(logo);

	// 	// addChild(_focus);
	// }
}