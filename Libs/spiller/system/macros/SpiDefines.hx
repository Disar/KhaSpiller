package spiller.system.macros;

#if macro
import haxe.macro.Compiler;
import haxe.macro.Context;
using StringTools;

private enum UserDefines
{
	SPI_NO_MOUSE_ADVANCED;
	SPI_NO_GAMEPAD;
	SPI_NO_NATIVE_CURSOR;
	SPI_NO_MOUSE;
	SPI_NO_TOUCH;
	SPI_NO_KEYBOARD;

	SPI_NO_SOUND_SYSTEM;

	SPI_FOCUS_LOST_SCREEN;
	SPI_REFLECTION;
	SPI_SOUND_TRAY;
	SPI_DEBUG;
	SPI_RECORD_REPLAY;
}

/**
 * These are "typedef defines" - complex #if / #elseif conditions
 * are shortened into a single define to avoid the redundancy
 * that comes with using them frequently.
 */
private enum HelperDefines
{
	SPI_MOUSE_ADVANCED;
	SPI_NATIVE_CURSOR;
	SPI_POINTER_INPUT;
	
	SPI_JOYSTICK_API;
	SPI_GAMEINPUT_API;
}

class SpiDefines
{
	public static function run()
	{
		#if (haxe_ver < "3.1.1")
		Context.fatalError('The minimum required Haxe version for HaxeFlixel is 3.1.1. '
			+ 'Please install a newer version.', SpiMacroUtil.here());
		#end
		
		checkDefines();
		defineHelperDefines();
		
		if (defined("flash"))
		{
			checkSwfVersion();
		}
	}
	
	private static function checkDefines()
	{		
		for (define in HelperDefines.getConstructors())
		{
			abortIfDefined(define);
		}
		
		#if (haxe_ver >= "3.2")
		var userDefinable = UserDefines.getConstructors();
		for (define in Context.getDefines().keys())
		{
			if (define.startsWith("SPI_") && userDefinable.indexOf(define) == -1)
			{
				Context.warning('"$define" is not a valid spiller define.', SpiMacroUtil.here());
			}
		}
		#end
	}
	
	private static function abortIfDefined(define:String)
	{
		if (defined(define))
		{
			Context.fatalError('$define can only be defined by spiller.', SpiMacroUtil.here());
		}
	}
	
	private static function defineHelperDefines()
	{
		if (!defined(SPI_NO_MOUSE) && !defined(SPI_NO_MOUSE_ADVANCED) && (!defined("flash") || defined("flash11_2")))
		{
			define(SPI_MOUSE_ADVANCED);
		}
		
		if (!defined(SPI_NO_MOUSE) && !defined(SPI_NO_NATIVE_CURSOR) && defined("flash10_2"))
		{
			define(SPI_NATIVE_CURSOR);
		}
		
		if ((defined("next") && !defined("flash")) || defined("flash11_8"))
		{
			define(SPI_GAMEINPUT_API);
		}
		else if (!defined("next") && (defined("cpp") || defined("neko") || defined("bitfive")))
		{
			define(SPI_JOYSTICK_API);
		}

		if (!defined(SPI_NO_TOUCH) || !defined(SPI_NO_MOUSE))
		{
			define(SPI_POINTER_INPUT);
		}
		
		if (!defined(SPI_NO_GAMEPAD) && defined("bitfive"))
		{
			define("bitfive_gamepads");
		}
	}
	
	private static function checkSwfVersion()
	{
		swfVersionError("Native mouse cursors are", "10.2", SPI_NO_NATIVE_CURSOR);
		swfVersionError("Middle and right mouse button events are", "11.2", SPI_NO_MOUSE_ADVANCED);
		swfVersionError("Gamepad input is", "11.8", SPI_NO_GAMEPAD);
	}
	
	private static function swfVersionError(feature:String, version:String, define:UserDefines)
	{
		var errorMessage = '[feature] only supported in Flash Player version [version] or higher. '
			+ 'Define [define] to disable this feature or add <set name="SWF_VERSION" value="$version" /> to your Project.xml.';
		
		if (!defined("flash" + version.replace(".", "_")) && !defined(define))
		{
			Context.fatalError(errorMessage
				.replace("[feature]", feature)
				.replace("[version]", version)
				.replace("[define]", define.getName()),
				SpiMacroUtil.here());
		}
	}
	
	private static inline function defined(define:Dynamic)
	{
		return Context.defined(Std.string(define));
	}
	
	private static inline function define(define:Dynamic)
	{
		Compiler.define(Std.string(define));
	}
}
#end