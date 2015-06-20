package spiller.system.flash;

/**
 * A class that provides constant values for visual blend mode effects.
 * 
 * v1.0 Initial version<br>
 * <br>
 * @version 1.0 - 10/09/2014
 * @author ratalaika / Ratalaika Games
 */
class BlendMode
{
	/**
	 * Adds the values of the constituent colors of the display object to the
	 * colors of its background, applying a ceiling of 0xFF.
	 */
	public static inline var ADD:String = "add";
	/**
	 * Applies the alpha value of each pixel of the display object to the
	 * background.
	 */
	public static inline var ALPHA:String = "alpha";
	/**
	 * Selects the darker of the constituent colors of the display object and
	 * the colors of the background (the colors with the smaller values).
	 */
	public static inline var DARKEN:String = "darken";
	/**
	 * Compares the constituent colors of the display object with the colors of
	 * its background, and subtracts the darker of the values of the two
	 * constituent colors from the lighter value.
	 */
	public static inline var DIFFERENCE:String = "difference";
	/**
	 * Erases the background based on the alpha value of the display object.
	 */
	public static inline var ERASE:String = "erase";
	/**
	 * Adjusts the color of each pixel based on the darkness of the display
	 * object.
	 */
	public static inline var HARDLIGHT:String = "hardlight";
	/**
	 * Inverts the background.
	 */
	public static inline var INVERT:String = "invert";
	/**
	 * Forces the creation of a transparency group for the display object.
	 */
	public static inline var LAYER:String = "layer";
	/**
	 * Selects the lighter of the constituent colors of the display object and
	 * the colors of the background (the colors with the larger values).
	 */
	public static inline var LIGHTEN:String = "lighten";
	/**
	 * Multiplies the values of the display object constituent colors by the
	 * constituent colors of the background color, and normalizes by dividing by
	 * 0xFF, resulting in darker colors.
	 */
	public static inline var MULTIPLY:String = "multiply";
	/**
	 * The display object appears in front of the background.
	 */
	public static inline var NORMAL:String = "normal";
	/**
	 * Adjusts the color of each pixel based on the darkness of the background.
	 */
	public static inline var OVERLAY:String = "overlay";
	/**
	 * Multiplies the complement (inverse) of the display object color by the
	 * complement of the background color, resulting in a bleaching effect.
	 */
	public static inline var SCREEN:String = "screen";
	/**
	 * Uses a shader to define the blend between objects.
	 */
	public static inline var SHADER:String = "shader";
	/**
	 * Subtracts the values of the constituent colors in the display object from
	 * the values of the background color, applying a floor of 0.
	 */
	public static inline var SUBTRACT:String = "subtract";

	/**
	 * Internal, helps convert between strings and openGL blend modes.
	//  */
	// private static Map<String, int[]> _blendMap;

	// /**
	//  * Convert a Flash blend mode string to openGL compatible values.
	//  * 
	//  * @param blendmode The blend mode string.
	//  * @return An array containing the opengl blend values.
	//  */
	// public static int[] getOpenGLBlendMode(String blendmode)
	// {
	// 	int[] openGLBlendmode = _blendMap.get(blendmode);
	// 	if(openGLBlendmode == null)
	// 		openGLBlendmode = _blendMap.get(NORMAL);

	// 	return openGLBlendmode;
	// }

	// /**
	//  * Add a new blendmode.
	//  */
	// public static void addBlendMode(String name, int sFactor, int dFactor)
	// {
	// 	_blendMap.put(name, new int[]{sFactor, dFactor});
	// }

	// /**
	//  * Initializes the map;
	//  */
	// static
	// {
	// 	_blendMap = new HashMap<String, int[]>(15);

	// 	addBlendMode(ADD, GL20.GL_ONE, GL20.GL_ONE);
	// 	addBlendMode(ALPHA, GL20.GL_SRC_ALPHA, GL20.GL_ONE);
	// 	// _blendMap.put(DARKEN, new int[]{GL20.GL_DST_COLOR, GL20.GL_ZERO});
	// 	// _blendMap.put(DIFFERENCE, new int[]{GL20.GL_SRC_ALPHA,
	// 	// GL20.GL_ONE_MINUS_SRC_ALPHA});
	// 	addBlendMode(ERASE, GL20.GL_ZERO, GL20.GL_SRC_ALPHA);
	// 	// _blendMap.put(HARDLIGHT, new int[]{GL20.GL_SRC_ALPHA,
	// 	// GL20.GL_ONE_MINUS_SRC_ALPHA});
	// 	// _blendMap.put(INVERT, new int[]{GL20.GL_SRC_ALPHA,
	// 	// GL20.GL_ONE_MINUS_SRC_ALPHA});
	// 	// _blendMap.put(LAYER, new int[]{GL20.GL_SRC_ALPHA,
	// 	// GL20.GL_ONE_MINUS_SRC_ALPHA});
	// 	// _blendMap.put(LIGHTEN, new int[]{GL20.GL_SRC_ALPHA,
	// 	// GL20.GL_ONE_MINUS_SRC_ALPHA});
	// 	addBlendMode(MULTIPLY, GL20.GL_DST_COLOR, GL20.GL_ONE_MINUS_SRC_ALPHA);
	// 	addBlendMode(NORMAL, GL20.GL_SRC_ALPHA, GL20.GL_ONE_MINUS_SRC_ALPHA);
	// 	// _blendMap.put(OVERLAY, new int[]{GL20.GL_SRC_ALPHA,
	// 	// GL20.GL_ONE_MINUS_SRC_ALPHA});
	// 	addBlendMode(SCREEN, GL20.GL_SRC_ALPHA, GL20.GL_ONE);
	// 	// _blendMap.put(SHADER, );
	// 	// _blendMap.put(SUBTRACT, );
	// }
}
