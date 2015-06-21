package spiller.system.kha.graphics;

import kha.Blob;
import kha.graphics4.FragmentShader;
import kha.graphics4.Program;
import kha.graphics4.VertexShader;

typedef ShaderProgramCallback = SpiShaderProgram->Void;

/**
 * A shader program encapsulates a vertex and fragment shader<br>
 * pair linked to form a shader program usable with OpenGL ES 2.0.<br>
 * <br>
 * It restores the shader settings when the context is lost.<br>
 * 
 * v1.0 Initial version<br>
 * <br>
 * 
 * @version 1.0 - 10/09/2014
 * @author ratalaika / Ratalaika Games
 * @author Ka Wing Chin
 */
class SpiShaderProgram extends Program
{
	/**
	 * The callback that will be fired when the game resume.
	 */
	public var callback:ShaderProgramCallback;

	/**
	 * Creates a <code>ManagedShaderData</code> object.
	 * 
	 * @param vertexShader The path to the vertexShader.
	 * @param fragmentShader The path to the fragmentShader.
	 * @param callback The callback that will be used on resume.
	 */
	public function new(vertexShader:Blob, fragmentShader:Blob, callback:ShaderProgramCallback = null)
	{
		super();

		setVertexShader(new VertexShader(vertexShader));
		setFragmentShader(new FragmentShader(fragmentShader));
	

		this.callback = callback;
	}

	/**
	 * Load the shader settings.
	 */
	public function loadShaderSettings():Void
	{
		if (callback != null)
			callback(this);
	}

	public function dispose():Void
	{
		callback = null;
	}
}
