package spiller.effects.lighting;

import kha.graphics4.Program;
import kha.Image;
import kha.math.Vector2;
import kha.math.Vector3;
import kha.Color;

import spiller.SpiBasic;
import spiller.SpiG;

/**
 * A lightning system for 2D sprites.<br>
 * You need to have the map of normals.<br>
 * You can use the Sprite Lamp to make it.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 24/02/2014
 * @author ratalaika / Ratalaika Games
 */
class SpiLightning extends SpiBasic
{
	// /**
	//  * The fragment shader.
	//  */
	// public static inline var String FRAG_HEAD = "com/ratalaika/spiller/data/shaders/lightning/frag_head.glsl";
	// public static inline var String FRAG_REP = "com/ratalaika/spiller/data/shaders/lightning/frag_rep.glsl";
	// public static inline var String FRAG_BOTTOM = "com/ratalaika/spiller/data/shaders/lightning/frag_bottom.glsl";
	// /**
	//  * The vertex shader.
	//  */
	// public static inline var String VERTEX = "com/ratalaika/spiller/data/shaders/lightning/vertex.glsl";
	/**
	 * Default position of our light.
	 */
	public static var DEFAULT_LIGHT_POS:Vector3 = new Vector3(0, 0, 0.07);
	/**
	 * Default color of our light.
	 */
	public static var DEFAULT_LIGHT_COLOR:Vector3 = new Vector3(1, 0.9, 0.5);
	/**
	 * Default light intensity (brightness to use when unlit).
	 */
	public static inline var DEFAULT_LIGHT_INTENSITY = 0.2;
	/**
	 * Default ambient color (color to use when unlit).
	 */
	public static var DEFAULT_AMBIENT_COLOR:Vector3 = new Vector3(0.48, 0.48, 0.42);
	/**
	 * Default attenuation factor: x = constant, y = linear, z = quadratic.
	 */
	public static var DEFAULT_ATTENUATION:Vector3 = new Vector3(0.4, 3, 20);
	/**
	 * Default ambient intensity (brightness to use when unlit).
	 */
	public static inline var DEFAULT_AMBIENT_INTENSITY:Float = 0.2;
	/**
	 * Default light strength. (ALPHA).
	 */
	public static inline var DEFAULT_STRENGTH:Float = 1;
	/**
	 * Default normal color.
	 */
	public static var NORMAL_VCOLOR:Color = Color.fromFloats(1, 1, 1, DEFAULT_STRENGTH);
	/**
	 * The default number of lights
	 */
	public static inline var DEFAULT_NUM_LIGHTS:Int = 1;
	/**
	 * The default ambient color.
	 */
	private var _ambientColor:Vector3;
	/**
	 * The current ambient intensity.
	 */
	private var _ambientIntensity:Float = DEFAULT_AMBIENT_INTENSITY;
	/**
	 * The current light strength.
	 */
	private var _strength:Float = DEFAULT_STRENGTH;
	/**
	 * Whether to use attenuation/shadows
	 */
	private var _useShadow:Bool = true;
	/**
	 * Whether to use lambert shading (with our normal map).
	 */
	private var _useNormals:Bool = true;
	/**
	 * Our shader program.
	 */
	private var _shader:Program;
	/**
	 * If we want flip the normals on the Y axis.
	 */
	private var _flipY:Bool = false;
	/**
	 * The screen resolution.
	 */
	private var _resolution:Vector2;
	/**
	 * Our array of lights.
	 */
	private var _lights:Array<SpiLight>;
	/**
	 * The current textures on batching.
	 */
	private var _texture:Image = null;
	/**
	 * The current normals on batching.
	 */
	private var _normals:Image = null;

	/**
	 * Class constructor.
	 */
	public function new(numberOfLights:Int = DEFAULT_NUM_LIGHTS)
	{
		super();

		// Initialize everything
		_resolution = new Vector2();
		_lights = new Array<SpiLight>();
		_ambientColor = new Vector3().add(DEFAULT_AMBIENT_COLOR);
	}

	// /**
	//  * Set the current ambient intensity.
	//  */
	// public void setAmbientIntensity(float value)
	// {
	// 	_ambientIntensity = value;
		
	// 	if(_shader != null)
	// 		_shader.setUniformf("ambientIntensity", _ambientIntensity);
	// }
	
	// /**
	//  * Sets the ambient light color.
	//  */
	// public void setAmbientColor(Vector3 color)
	// {
	// 	setAmbientColor(color.x, color.y, color.z);
	// }
	
	// /**
	//  * Set the current ambient intensity.
	//  */
	// public void setAmbientColor(float R, float G, float B)
	// {
	// 	_ambientColor.x = R;
	// 	_ambientColor.y = G;
	// 	_ambientColor.z = B;
		
	// 	if(_shader != null)
	// 		_shader.setUniformf("ambientColor", _ambientColor);
	// }

	// /**
	//  * Get the current ambient intensity.
	//  */
	// public float getAmbientIntensity()
	// {
	// 	return _ambientIntensity;
	// }

	// /**
	//  * Set the current light strength.
	//  */
	// public void setLightStrength(float value)
	// {
	// 	_strength = value;
		
	// 	if(_shader != null)
	// 		_shader.setUniformf("strength", _strength);
	// }

	// /**
	//  * Get the current light strength.
	//  */
	// public float getLightStrength()
	// {
	// 	return _strength;
	// }
	
	// /**
	//  * Overridden update method.
	//  */
	// public void update()
	// {
	// 	// Do nothing on OUYA
	// 	if(SpiG.inOuya) {
	// 		// Turn if off ass well
	// 		if (visible)
	// 			visible = false;
	// 		return;
	// 	}
		
	// 	// Check if we have something to render LOL!
	// 	if(_lights.size <= 0)
	// 		return;

	// 	// No shader yet!
	// 	if(_shader == null)
	// 		return;

	// 	// Check if we have been turned of or not
	// 	if(!active)
	// 		return;

	// 	// Check if we need to update the lights
	// 	if(needsToUpdateLights()) {
	// 		// Update light values
	// 		float[] color = new float[_lights.size * 4];
	// 		float[] pos = new float[_lights.size * 3];
	// 		float[] attenuation = new float[_lights.size * 3];

	// 		int j = 0;
	// 		int k = 0;
	// 		for(int i = 0; i < _lights.size; i++) {
	// 			SpiLight light = _lights.get(i);
	// 			light.updateProcessed();

	// 			// Set the color values
	// 			color[k] = light.getColor().x;
	// 			color[k + 1] = light.getColor().y;
	// 			color[k + 2] = light.getColor().z;
	// 			color[k + 3] = light.getIntensity();

	// 			// Set the position values
	// 			pos[j] = light.getPosition().x;
	// 			pos[j + 1] = light.getPosition().y;
	// 			pos[j + 2] = light.getPosition().z;

	// 			// Set the attenuation values
	// 			attenuation[j] = light.getAttenuation().x;
	// 			attenuation[j + 1] = light.getAttenuation().y;
	// 			attenuation[j + 2] = light.getAttenuation().z;
				
	// 			j += 3;
	// 			k += 4;
	// 		}

	// 		_shader.begin();
	// 		_shader.setUniform4fv("lightColor", color, 0, _lights.size * 4);
	// 		_shader.setUniform3fv("lightPos", pos, 0, _lights.size * 3);
	// 		_shader.setUniform3fv("attenuation", attenuation, 0, _lights.size * 3);
	// 		_shader.end();
	// 	}
		

	// 	// Update debug parameters
	// 	//_shader.setUniformi("useNormals", _useNormals ? 1 : 0);
	// 	//_shader.setUniformi("useShadow", _useShadow ? 1 : 0);
	// 	//_shader.setUniformf("strength", _strength);

	// 	// Update global parameters
	// 	//_shader.setUniformf("ambientColor", _ambientColor);
	// 	//_shader.setUniformf("ambientIntensity", _ambientIntensity);
	// }

	// /**
	//  * If the lights need an update.
	//  */
	// private boolean needsToUpdateLights()
	// {
	// 	boolean needUpdate = false;
	// 	for(int i = 0; i < _lights.size; i++) {
	// 		SpiLight light = _lights.get(i);
	// 		needUpdate = needUpdate || light.needUpdate(); 
	// 	}
	// 	return needUpdate;
	// }

	/**
	 * Preload the lightning textures in order to check for flushing.
	 * 
	 * @param texture
	 * @param normals
	 * @param specular
	 */
	public function preloadLightning(texture:Image, normals:Image):Void
	{
	// 	// Check if we need to flush due to texture
	// 	if (_texture == null)
	// 		_texture = texture;
	// 	else if (_texture != texture) {
	// 		SpiG.batch.flush();
	// 		_texture = texture;
	// 	}

	// 	// Check if we need to flush due to normals
	// 	if (_normals == null)
	// 		_normals = normals;
	// 	else if (_normals != normals) {
	// 		SpiG.batch.flush();
	// 		_normals = normals;
	// 	}
	}

	// /**
	//  * Create the shader program.
	//  */
	// private ShaderProgram createShaderProgram(int lights)
	// {
	// 	// Do nothing if on an OUYA
	// 	if(SpiG.inOuya)
	// 		return null;
		
	// 	SpiG.log("Creating lightning shader for " + lights + " lights.");
		
	// 	// see the code here: http://pastebin.com/7fkh1ax8
	// 	// simple illumination model using ambient, diffuse (lambert) and attenuation
	// 	// see here: http://nccastaff.bournemouth.ac.uk/jmacey/CGF/slides/IlluminationModels4up.pdf
	// 	String vertexShader = Gdx.files.classpath(VERTEX).readString();
	// 	StringBuffer fragmentShader = new StringBuffer();
	// 	fragmentShader.append(String.format(Gdx.files.classpath(FRAG_HEAD).readString(), lights));
		
	// 	for(int i = 0; i < lights; i++)
	// 		fragmentShader.append(Gdx.files.classpath(FRAG_REP).readString());
		
	// 	fragmentShader.append(Gdx.files.classpath(FRAG_BOTTOM).readString());

	// 	// u_proj and u_trans will not be active but SpriteBatch will still try to set them...
	// 	ShaderProgram.pedantic = false;
		
	// 	// Create and compile the shader
	// 	ShaderProgram program = new ShaderProgram(vertexShader, fragmentShader.toString());
	// 	if (program.isCompiled() == false)
	// 		throw new IllegalArgumentException("Couldn't compile shader: " + program.getLog());

	// 	// set resolution vector
	// 	_resolution.set(SpiG.width, SpiG.height);

	// 	// we are only using this many uniforms for testing purposes...!!
	// 	program.begin();
		
	// 	// Set texture ids
	// 	program.setUniformi("u_texture", 0);
	// 	program.setUniformi("u_normals", 1);

	// 	// Set global parameters
	// 	program.setUniformf("ambientColor", _ambientColor);
	// 	program.setUniformf("ambientIntensity", _ambientIntensity);

	// 	// Set debug parameters
	// 	program.setUniformf("strength", _strength);
	// 	program.setUniformf("resolution", _resolution);
	// 	program.setUniformi("useShadow", _useShadow ? 1 : 0);
	// 	program.setUniformi("useNormals", _useNormals ? 1 : 0);
	// 	program.setUniformi("yInvert", _flipY ? 1 : 0);

	// 	// Set light parameters
	// 	float[] color = new float[_lights.size * 4];
	// 	float[] pos = new float[_lights.size * 3];
	// 	float[] attenuation = new float[_lights.size * 3];

	// 	int j = 0;
	// 	int k = 0;
	// 	for(int i = 0; i < _lights.size; i++) {
	// 		SpiLight light = _lights.get(i);

	// 		// Set the color values
	// 		color[k] = light.getColor().x;
	// 		color[k+1] = light.getColor().y;
	// 		color[k+2] = light.getColor().z;
	// 		color[k+3] = 1;
			
	// 		// Set the position values
	// 		pos[j] = light.getPosition().x;
	// 		pos[j+1] = light.getPosition().y;
	// 		pos[j+2] = light.getPosition().z;
			
	// 		// Set the attenuation values
	// 		attenuation[j] = light.getAttenuation().x;
	// 		attenuation[j+1] = light.getAttenuation().y;
	// 		attenuation[j+2] = light.getAttenuation().z;
			
	// 		j += 3;
	// 		k += 4;
	// 	}

	// 	program.setUniform4fv("lightColor", color, 0, _lights.size * 4);
	// 	program.setUniform3fv("lightPos", pos, 0, _lights.size * 3);
	// 	program.setUniform3fv("attenuation", attenuation, 0, _lights.size * 3);
		

	// 	// Terminate the shader
	// 	program.end();

	// 	return program;
	// }

	// /**
	//  * Add a new light to the scene.<br>
	//  */
	// public void addLight(SpiLight light)
	// {
	// 	_lights.add(light);
	// }

	// /**
	//  * Remove a light.<br>
	//  */
	// public void removeLight(SpiLight light)
	// {
	// 	_lights.removeValue(light, true);
	// }
	
	// /**
	//  * Add a new group of light to the scene.
	//  */
	// public void addLights(Array<SpiLight> lights)
	// {
	// 	_lights.addAll(lights);
	// }
	
	// /**
	//  * Remove a group of lights.
	//  */
	// public void removeLights(Array<SpiLight> lights)
	// {
	// 	_lights.removeAll(lights, true);
	// }

	// /**
	//  * Process all added or removed lights
	//  */
	// public void processLights()
	// {
	// 	// Dispose the previous shader if needed
	// 	if(_shader != null)
	// 		_shader.dispose();

	// 	// Check if it's worth it
	// 	if(_lights.size == 0)
	// 		return;
		
	// 	// Create a new shader
	// 	_shader = createShaderProgram(_lights.size);
	// }

	/**
	 * Clear everything
	 */
	public function clear():Void
	{
	// 	// Dispose the previous shader if needed
	// 	if (_shader != null) {
	// 		_shader.dispose();
	// 		_shader.end();
	// 	}		
	// 	_shader = null;
	// 	_texture = null;
	// 	_normals = null;
	// 	_lights.clear();
	}

	// /**
	//  * Return the shader program.
	//  */
	// public Program getShader()
	// {
	// 	return _shader;
	// }
}