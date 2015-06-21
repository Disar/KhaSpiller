package spiller.system.kha.graphics;

import kha.graphics2.Graphics;
import kha.graphics4.Program;

class GraphicsExtension
{
	public static function setShader(g:Graphics, program: Program): Void
	{
		#if !cs
		#if !java
		g.program = program;
		#end
		#end	
	}

	public static function useBilinearFiltering(g:Graphics, value: Bool): Void
	{
		if(Std.is(g, kha.graphics4.Graphics2)) {
			cast(g, kha.graphics4.Graphics2).setBilinearFiltering(value);
		}
	}
}