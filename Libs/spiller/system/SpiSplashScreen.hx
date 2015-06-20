package spiller.system;

import spiller.SpiG;
import spiller.util.SpiColor;
import spiller.SpiSprite;
import spiller.SpiState;
import spiller.data.SpiSystemAsset;

/**
 * Splash Screen State, it is call each time the game runs.<br>
 * During the splash screen the game can't be paused.<br>
 * <br>
 * v1.1 Fixed the out screen error and commented the code a little bit more<br>
 * v1.0 Initial version<br>
 * 
 * @version 1.1 - 06/03/2013
 * @author ratalaika / Ratalaika Games
 */
class SpiSplashScreen extends SpiState
{
	/**
	 * The pixel size.
	 */
	private static inline var PIXEL_SIZE:Int = 32;
	/**
	 * The logo timer.
	 */
	private static inline var LOGO_TIMER:Int = 2;
	/**
	 * The initial game state after the spash screen.
	 */
	public static var initialGameState:SpiState;
	/**
	 * Timer to control the Logo animation.
	 */
	private var _logoTimer:Float;

	/**
	 * We create the whole splash screen state.
	 */
	override
	public function create():Void
	{
		// Set the background color
		SpiG.setBgColor(SpiColor.BLACK);

		// Turn the pause off
		SpiG.setDisablePause(true);

		// Set the logo timer
		_logoTimer = 0;

		// Calculate the scale stuff
		var scale:Int = 1;
		if (SpiG.height > 200 && SpiG.height > SpiG.width)
			scale = 2;
		var pixelSize:Int = PIXEL_SIZE * scale;

		// Initialize the powered by
		var poweredBy:SpiSprite = new SpiSprite();
		poweredBy.loadGraphic(SpiSystemAsset.poweredBy);
		poweredBy.scaleSprite(scale, scale);

		// Set the top and left positions
		var top:Int = Std.int((SpiG.height / 2) - (((pixelSize * 4) + PIXEL_SIZE/2 + Std.int(poweredBy.height)) / 2));
		var left:Int = Std.int(SpiG.width / 2 - pixelSize);

		// Prevent top out of screen
		if(top < 0)
			top = 5;
		
		// Add all the logo pixels
		add(new SpiLogoPixel(left, top, (0xFF800080), pixelSize)); // Purple
		add(new SpiLogoPixel(left + pixelSize, top, (0xFFFF2346), pixelSize)); // Red
		add(new SpiLogoPixel(left, top + pixelSize, (0xFFFFBF37), pixelSize)); // Gold
		add(new SpiLogoPixel(left + pixelSize, top + (pixelSize * 2), (0xFF0BC8FF), pixelSize)); // Light Blue
		add(new SpiLogoPixel(left, top + (pixelSize * 3), (0xFF3B43FF), pixelSize)); // Dark Blue
		add(new SpiLogoPixel(left + pixelSize, top + (pixelSize * 3), (0xFF00B92B), pixelSize)); // Green

		// Set the powered by position
		poweredBy.x = SpiG.width / 2 - poweredBy.width / 2;
		poweredBy.y = top + (pixelSize * 4) + PIXEL_SIZE / 2;
		add(poweredBy);
	}

	/**
	 * We override the update method, so we can control the time of the splash screen.
	 * We call the garbage collector after the splash screen.
	 * And then we start the initial game state.
	 */
	override
	public function update():Void
	{
		super.update();
		_logoTimer += SpiG.elapsed; // Update the logo timer

		// Change the state if we complete the logo timer
		if (_logoTimer > LOGO_TIMER) {
			SpiG.setDisablePause(false);
			SpiG.switchState(initialGameState);
		}
	}
}
