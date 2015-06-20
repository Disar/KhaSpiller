package;

import kha.Sys;
import kha.Starter;

import spiller.SpiGame;
import spiller.SpiState;

import spiller.util.tmx.TiledMap;

class Main {
	static var gameWidth:Int = 640; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	static var gameHeight:Int = 480; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	static var initialState:SpiState = null; // The FlxState the game starts with.
	static var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	static var framerate:Int = 60; // How many frames per second the game should run at.
	static var skipSplash:Bool = false; // Whether to skip the flixel splash screen that appears in release mode.

	public static function main() {
		var starter:Starter = new Starter();
		starter.start(new SpiGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash));
	}
}