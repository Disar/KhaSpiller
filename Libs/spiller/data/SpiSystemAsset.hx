package spiller.data;

/**
 * This class is only for internal use for spiller self.<br>
 * <br>
 * v1.0 Initial version
 * 
 * @version 1.0 - 17/07/2013
 * @author ratalaika / Ratalaika Games
 * @author Ka Wing Chin
 */
class SpiSystemAsset
{
	/**
	 * The file handler.
	 */
	public static inline var systemFont:String = "com/ratalaika/spiller/data/font/nokiafc22.ttf";
	/**
	 * The default image, used when creating an empty {@link SpiSprite}.
	 */
	public static inline var ImgDefault:String = "com/ratalaika/spiller/data/spiller.txt:default";
	/**
	 * The default image for an {@link SpiButton}.
	 */
	public static inline var ImgDefaultButton:String = "com/ratalaika/spiller/data/spiller.txt:button";
	/**
	 * The {@link SpiAnalog} base image.
	 */
	public static inline var ImgControlBase:String = "com/ratalaika/spiller/data/flixel.txt:base";
	/**
	 * The {@link SpiAnalog} stick image.
	 */
	public static inline var ImgControlKnob:String = "com/ratalaika/spiller/data/flixel.txt:stick";

	/**
	 * The {@link SpiDigitalPad} images. 
	 */
	public static var dpad:Array<String> = [ "com/ratalaika/spiller/data/spiller.txt:dpad_up",
													"com/ratalaika/spiller/data/spiller.txt:dpad_down",
													"com/ratalaika/spiller/data/spiller.txt:dpad_left",
													"com/ratalaika/spiller/data/spiller.txt:dpad_right",
													"com/ratalaika/spiller/data/spiller.txt:dpad_base"];
	/**
	 * The {@link SpiGamePad} images.
	 */
	public static var gpad:Array<String> = [ "com/ratalaika/spiller/data/spiller.txt:gpad_up",
													"com/ratalaika/spiller/data/spiller.txt:gpad_down",
													"com/ratalaika/spiller/data/spiller.txt:gpad_left",
													"com/ratalaika/spiller/data/spiller.txt:gpad_right"];
	/**
	 * The powered by image.
	 */
	public static inline var poweredBy:String = "com/ratalaika/spiller/data/spiller.txt:poweredby";
	/**
	 * The pause in sound.
	 */
	public static inline var pauseinSound:String = "com/ratalaika/spiller/data/pausein.mp3";
	/**
	 * The pause out sound.
	 */
	public static inline var pauseoutSound:String = "com/ratalaika/spiller/data/pauseout.mp3";
	/**
	 * The spiller splasg screen sound.
	 */
	public static inline var spillerSound:String = "com/ratalaika/spiller/data/flixel_female.mp3";
	/**
	 * The image for the A button.
	 */
	public static inline var ImgButtonA = "com/ratalaika/spiller/data/flixel.txt:button_a";
	/**
	 * The image for the B button.
	 */
	public static inline var ImgButtonB = "com/ratalaika/spiller/data/flixel.txt:button_b";
	/**
	 * The image for the C button.
	 */
	public static inline var ImgButtonC = "com/ratalaika/spiller/data/flixel.txt:button_c";
	/**
	 * The image for the Y button.
	 */
	public static inline var ImgButtonY = "com/ratalaika/spiller/data/flixel.txt:button_y";
	/**
	 * The image for the X button.
	 */
	public static inline var ImgButtonX = "com/ratalaika/spiller/data/flixel.txt:button_x";
	/**
	 * The image for the LEFT button.
	 */
	public static inline var ImgButtonLeft = "com/ratalaika/spiller/data/flixel.txt:button_left";
	/**
	 * The image for the UP button.
	 */
	public static inline var ImgButtonUp = "com/ratalaika/spiller/data/flixel.txt:button_up";
	/**
	 * The image for the RIGHT button.
	 */
	public static inline var ImgButtonRight = "com/ratalaika/spiller/data/flixel.txt:button_right";
	/**
	 * The image for the DOWN button.
	 */
	public static inline var ImgButtonDown = "com/ratalaika/spiller/data/flixel.txt:button_down";
	/**
	 * The image for the center button.
	 */
	public static inline var ImgCenter = "com/ratalaika/spiller/data/flixel.txt:dpad_center";

	/**
	 * Tile map default images.
	 */
	public static inline var ImgAuto = "com/ratalaika/spiller/data/spiller.txt:autotiles";
	/**
	 * Tile map alternative default images.
	 */
	public static inline var ImgAutoAlt = "com/ratalaika/spiller/data/spiller.txt:autotiles_alt";
	/**
	 * Tile map default images in 16x16.
	 */
	public static inline var ImgAutoBig = "com/ratalaika/spiller/data/spiller.txt:autotiles_big";

	/**
	 * Spiller UI stuff
	 */
	public static inline var ImgTab = "com/ratalaika/spiller/data/flixel.txt:tab";
	public static inline var ImgRadioButton = "com/ratalaika/spiller/data/flixel.txt:radiobutton";
	public static inline var ImgSwitch = "com/ratalaika/spiller/data/flixel.txt:switch";
	public static inline var ImgDivider = "com/ratalaika/spiller/data/flixel.txt:tab_divider";
	public static inline var ImgDividerVertical = "com/ratalaika/spiller/data/flixel.txt:tab_divider_vertical";
	public static inline var ImgTopLeft = "com/ratalaika/spiller/data/flixel.txt:ninepatch_button_topleft";
	public static inline var ImgTopCenter = "com/ratalaika/spiller/data/flixel.txt:ninepatch_button_topcenter";
	public static inline var ImgTopRight = "com/ratalaika/spiller/data/flixel.txt:ninepatch_button_topright";
	public static inline var ImgBottomLeft = "com/ratalaika/spiller/data/flixel.txt:ninepatch_button_bottomleft";
	public static inline var ImgBottomCenter = "com/ratalaika/spiller/data/flixel.txt:ninepatch_button_bottomcenter";
	public static inline var ImgBottomRight= "com/ratalaika/spiller/data/flixel.txt:ninepatch_button_bottomright";
	public static inline var ImgMiddleLeft = "com/ratalaika/spiller/data/flixel.txt:ninepatch_button_middleleft";
	public static inline var ImgMiddleCenter = "com/ratalaika/spiller/data/flixel.txt:ninepatch_button_middlecenter";
	public static inline var ImgMiddleRight = "com/ratalaika/spiller/data/flixel.txt:ninepatch_button_middleright";
	public static inline var ImgCheckBox = "com/ratalaika/spiller/data/flixel.txt:checkbox";
	public static inline var ImgLabelTopLeft = "com/ratalaika/spiller/data/flixel.txt:label_topleft";
	public static inline var ImgLabelTopCenter = "com/ratalaika/spiller/data/flixel.txt:label_topcenter";
	public static inline var ImgLabelTopRight = "com/ratalaika/spiller/data/flixel.txt:label_topright";
	public static inline var ImgLabelMiddleLeft = "com/ratalaika/spiller/data/flixel.txt:label_middleleft";
	public static inline var ImgLabelMiddleCenter = "com/ratalaika/spiller/data/flixel.txt:label_middlecenter";
	public static inline var ImgLabelMiddleRight = "com/ratalaika/spiller/data/flixel.txt:label_middleright";
	public static inline var ImgLabelBottomLeft = "com/ratalaika/spiller/data/flixel.txt:label_bottomleft";
	public static inline var ImgLabelBottomCenter = "com/ratalaika/spiller/data/flixel.txt:label_bottomcenter";
	public static inline var ImgLabelBottomRight = "com/ratalaika/spiller/data/flixel.txt:label_bottomright";
	public static inline var ImgTextAreaTopLeft = "com/ratalaika/spiller/data/flixel.txt:ninepatch_textarea_topleft";
	public static inline var ImgTextAreaTopCenter = "com/ratalaika/spiller/data/flixel.txt:ninepatch_textarea_topcenter";
	public static inline var ImgTextAreaTopRight = "com/ratalaika/spiller/data/flixel.txt:ninepatch_textarea_topright";
	public static inline var ImgTextAreaMiddleLeft = "com/ratalaika/spiller/data/flixel.txt:ninepatch_textarea_middleleft";
	public static inline var ImgTextAreaMiddleCenter = "com/ratalaika/spiller/data/flixel.txt:ninepatch_textarea_middlecenter";
	public static inline var ImgTextAreaMiddleRight = "com/ratalaika/spiller/data/flixel.txt:ninepatch_textarea_middleright";
	public static inline var ImgTextAreaBottomLeft = "com/ratalaika/spiller/data/flixel.txt:ninepatch_textarea_bottomleft";
	public static inline var ImgTextAreaBottomCenter = "com/ratalaika/spiller/data/flixel.txt:ninepatch_textarea_bottomcenter";
	public static inline var ImgTextAreaBottomRight = "com/ratalaika/spiller/data/flixel.txt:ninepatch_textarea_bottomright";
}
