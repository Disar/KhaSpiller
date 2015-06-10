package;

import kha.Sys;
import kha.Starter;
import spiller.SpiBasic;
import spiller.math.SpiPoint;
import spiller.math.SpiRect;

class Main {
	var gameWidth:Int = 640; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 480; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	//var initialState:Class<FlxState> = null; // The FlxState the game starts with.
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = false; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets

	public static function main() {
		var starter:Starter = new Starter();
		SpiPoint.poolStatus();
		//starter.start(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));
//		starter.start(new KhaFlixelGame());
	}

	protected new() {}
}