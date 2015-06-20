package spiller.system;

import spiller.SpiGroup;
import spiller.SpiSprite;

/**
 * This automates the color-rotation effect on the 'S'<br>
 * image during game launch, not used in actual game code.<br>
 * <br>
 * v1.1 Commented the code<br>
 * v1.0 Initial version<br>
 * 
 * @version 1.1 - 06/03/2013
 * @author ratalaika / Ratalaika Games
 */
class SpiLogoPixel extends SpiGroup
{
	/**
	 * All the sprite images organized as layers.
	 */
	private var _layers:Array<SpiSprite>;
	/**
	 * The current layer.
	 */
	private var _curLayer:Int;

	/**
	 * Class constructor.
	 * 
	 * @param xPos			The X position.
	 * @param yPos			The Y position.
	 * @param finalColor	The final color.
	 * @param Size			The size of the pixel.
	 */
	public function new(xPos:Int, yPos:Int, finalColor:Int, Size:Int)
	{
		super();

		// Build up the color layers
		_layers = new Array<SpiSprite>();
		var colors:Array<Int> = [ 0xACFFFFFF, finalColor, 0xACFFFFFF, finalColor, 0xACFFFFFF ];

		// Create the background with the final color
		var background:SpiSprite = new SpiSprite(xPos, yPos);
		background.makeGraphic(Size, Size, finalColor);
		add(background);
		_layers[0] = background;

		// Create the rest of the layers 
		var l:Int = colors.length;
		var index:Int = 0;
		for (i in 0 ... l) {
			var coloredBlock:SpiSprite = new SpiSprite(xPos, yPos);
			coloredBlock.makeGraphic(Size, Size, colors[index]);
			add(coloredBlock);
			_layers[i + 1] = coloredBlock;

			if (++index >= l)
				index = 0;
		}
		_curLayer = _layers.length - 1;
	}

	/**
	 * Overridden update method.
	 */
	override
	public function update():Void
	{
		// If we are in the first layer stop the animation
		if (_curLayer == 0)
			return;

		// Update the alpha value
		if (_layers[_curLayer].getAlpha() >= 0.1)
			_layers[_curLayer].setAlpha(_layers[_curLayer].getAlpha() - 0.1);
		else {
			_layers[_curLayer].setAlpha(0);
			_curLayer--;
		}
	}
}
