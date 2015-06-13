package spiller.system.debug;

// import com.badlogic.gdx.math.Rectangle;
// import com.badlogic.gdx.math.Vector2;
// import spiller.SpiG;
// import spiller.SpiGroup;
// import spiller.SpiSprite;
// import spiller.SpiText;
// import spiller.system.debug.Log;
// import spiller.system.debug.Perf;
// import spiller.system.debug.VCR;
// import spiller.system.debug.Vis;
// import spiller.system.debug.Watch;

/**
 * Container for the new debugger overlay.
 * Most of the functionality is in the debug folder widgets,
 * but this class instantiates the widgets and handles their basic formatting and arrangement.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 25/04/2013
 * @author ratalaika / Ratalaika Games
 * @author Ka Wing Chin
 */
class SpiDebugger extends SpiGroup
{
	// /**
	//  * Container for the performance monitor widget.
	//  */
	// public Perf perf;
	// /**
	//  * Container for the trace output widget.
	//  */
	// public Log log;
	// /**
	//  * Container for the watch window widget.
	//  */
	// public Watch watch;
	// /**
	//  * Container for the record, stop and play buttons.
	//  */
	// public VCR vcr;
	// /**
	//  * Container for the visual debug mode toggle.
	//  */
	// public Vis vis;
	// /**
	//  * Whether the mouse is currently over one of the debugger windows or not.
	//  */
	// public boolean hasMouse;
	
	// /**
	//  * Internal, tracks what debugger window layout user has currently selected.
	//  */
	// protected int _layout;
	// /**
	//  * Internal, stores width and height of the Flash Player window.
	//  */
	// protected Vector2 _screen;
	// /**
	//  * Internal, used to space out windows from the edges.
	//  */
	// protected int _gutter;

	// /**
	//  * Instantiates the debugger overlay.
	//  * 
	//  * @param Width		The width of the screen.
	//  * @param Height	The height of the screen.
	//  */
	// public SpiDebugger(float Width,float Height)
	// {
	// 	super();
	// 	visible = false;
	// 	hasMouse = false;
	// 	_screen = new Vector2(Width,Height);

	// 	add(new SpiSprite().makeGraphic((int) Width,15,0x7f000000));

	// 	SpiText txt = new SpiText(2, 0, 160);
	// 	txt.setFormat(null, 12, 0xffffff);
	// 	//txt.height = 16;
	// 	//txt.selectable = false;
	// 	//txt.multiline = false;
	// 	//txt.defaultTextFormat = new TextFormat("Courier",12,0xffffff);
	// 	String str = SpiG.getLibraryName();
	// 	if(SpiG.debug)
	// 		str += " [debug]";
	// 	else
	// 		str += " [release]";
	// 	txt.setText(str);
	// 	add(txt);

	// 	_gutter = 8;
	// 	Rectangle screenBounds = new Rectangle(_gutter,15+_gutter/2,_screen.x-_gutter*2,_screen.y-_gutter*1.5f-15);

	// 	log = new Log("log",0,0,true,screenBounds);
	// 	//addChild(log);

	// 	watch = new Watch("watch",0,0,true,screenBounds);
	// 	//addChild(watch);

	// 	perf = new Perf("stats",0,0,false,screenBounds);
	// 	//addChild(perf);

	// 	vcr = new VCR();
	// 	//vcr.x = (Width - vcr.width/2)/2;
	// 	//vcr.y = 2;
	// 	//addChild(vcr);

	// 	vis = new Vis();
	// 	//vis.x = Width-vis.width - 4;
	// 	//vis.y = 2;
	// 	//addChild(vis);

	// 	setLayout(SpiG.DEBUGGER_STANDARD);

	// 	//Should help with fake mouse focus type behavior
	// 	//addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
	// 	//addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
	// }

	// /**
	//  * Clean up memory.
	//  */
	// public void destroy()
	// {
	// 	_screen = null;
	// 	//removeChild(log);
	// 	log.destroy();
	// 	log = null;
	// 	//removeChild(watch);
	// 	watch.destroy();
	// 	watch = null;
	// 	//removeChild(perf);
	// 	perf.destroy();
	// 	perf = null;
	// 	//removeChild(vcr);
	// 	vcr.destroy();
	// 	vcr = null;
	// 	//removeChild(vis);
	// 	vis.destroy();
	// 	vis = null;

	// 	//removeEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
	// 	//removeEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
	// }

	// /**
	//  * Mouse handler that helps with fake "mouse focus" type behavior.
	//  * 
	//  * @param	E	Flash mouse event.
	//  */
	// protected void onMouseOver()
	// {
	// 	hasMouse = true;
	// }

	// /**
	//  * Mouse handler that helps with fake "mouse focus" type behavior.
	//  * 
	//  * @param	E	Flash mouse event.
	//  */
	// protected void onMouseOut()
	// {
	// 	hasMouse = false;
	// }

	// /**
	//  * Rearrange the debugger windows using one of the constants specified in SpiG.
	//  * 
	//  * @param	Layout		The layout style for the debugger windows, e.g. <code>SpiG.DEBUGGER_MICRO</code>.
	//  */
	// public void setLayout(int Layout)
	// {
	// 	_layout = Layout;
	// 	resetLayout();
	// }

	// /**
	//  * Forces the debugger windows to reset to the last specified layout.
	//  * The default layout is <code>SpiG.DEBUGGER_STANDARD</code>.
	//  */
	// public void resetLayout()
	// {
	// 	switch(_layout)
	// 	{
	// 		case SpiG.DEBUGGER_MICRO:
	// 			log.resize(_screen.x/4,68);
	// 			log.reposition(0,_screen.y);
	// 			watch.resize(_screen.x/4,68);
	// 			watch.reposition(_screen.x,_screen.y);
	// 			perf.reposition(_screen.x,0);
	// 			break;
	// 		case SpiG.DEBUGGER_BIG:
	// 			log.resize((_screen.x-_gutter*3)/2,_screen.y/2);
	// 			log.reposition(0,_screen.y);
	// 			watch.resize((_screen.x-_gutter*3)/2,_screen.y/2);
	// 			watch.reposition(_screen.x,_screen.y);
	// 			perf.reposition(_screen.x,0);
	// 			break;
	// 		case SpiG.DEBUGGER_TOP:
	// 			log.resize((_screen.x-_gutter*3)/2,_screen.y/4);
	// 			log.reposition(0,0);
	// 			watch.resize((_screen.x-_gutter*3)/2,_screen.y/4);
	// 			watch.reposition(_screen.x,0);
	// 			perf.reposition(_screen.x,_screen.y);
	// 			break;
	// 		case SpiG.DEBUGGER_LEFT:
	// 			log.resize(_screen.x/3,(_screen.y-15-_gutter*2.5f)/2);
	// 			log.reposition(0,0);
	// 			watch.resize(_screen.x/3,(_screen.y-15-_gutter*2.5f)/2);
	// 			watch.reposition(0,_screen.y);
	// 			perf.reposition(_screen.x,0);
	// 			break;
	// 		case SpiG.DEBUGGER_RIGHT:
	// 			log.resize(_screen.x/3,(_screen.y-15-_gutter*2.5f)/2);
	// 			log.reposition(_screen.x,0);
	// 			watch.resize(_screen.x/3,(_screen.y-15-_gutter*2.5f)/2);
	// 			watch.reposition(_screen.x,_screen.y);
	// 			perf.reposition(0,0);
	// 			break;
	// 		case SpiG.DEBUGGER_STANDARD:
	// 		default:
	// 			log.resize((_screen.x-_gutter*3)/2,_screen.y/4);
	// 			log.reposition(0,_screen.y);
	// 			watch.resize((_screen.x-_gutter*3)/2,_screen.y/4);
	// 			watch.reposition(_screen.x,_screen.y);
	// 			perf.reposition(_screen.x,0);
	// 			break;
	// 	}
	// }
}