#ifdef GL_ES
	#define LOWP lowp
	precision mediump float;
#else
	#define LOWP
#endif

#define N_LIGHTS %d

varying vec4 v_color;
varying vec2 v_texCoords;

// Set up texture id parametes
uniform sampler2D u_texture;
uniform sampler2D u_normals;

// Set up debug parametes
uniform vec2 resolution;
uniform bool useNormals;
uniform bool useShadow;
uniform float strength;
uniform bool yInvert;

// Set up global parametes
uniform vec3 ambientColor;
uniform float ambientIntensity; 
				 
// Set up light parameters
uniform vec3 lightPos[N_LIGHTS]; // Light position, normalized
uniform vec4 lightColor[N_LIGHTS]; // Light RGBA -- alpha is intensity
uniform vec3 attenuation[N_LIGHTS]; // Attenuation coefficients
				 

vec3 processLight(vec4 diffuseColor, vec3 normal, vec3 lightPos, vec4 lightColor, vec3 attenuation)
{
	// Here we do a simple distance calculation
	vec3 deltaPos = vec3( (lightPos.xy - gl_FragCoord.xy) / resolution.xy, lightPos.z );
	vec3 lightDir = normalize(deltaPos);
	float lambert = useNormals ? clamp(dot(normal, lightDir), 0.0, 1.0) : 1.0;
		
	//now let's get a nice little falloff
	float d = sqrt(dot(deltaPos, deltaPos));
		
	float att = useShadow ? 1.0 / ( attenuation.x + (attenuation.y*d) + (attenuation.z*d*d) ) : 1.0;
	
	vec3 result = (ambientColor * ambientIntensity) + (lightColor.rgb * lambert) * att;
	result *= diffuseColor.rgb;
	
	return result; 
}

void main()
{
	//sample color & normals from our textures
	vec4 diffuseColor = texture2D(u_texture, v_texCoords.st);
	vec3 nColor = texture2D(u_normals, v_texCoords.st).rgb;

	//some bump map programs will need the Y value flipped..
	nColor.g = yInvert ? 1.0 - nColor.g : nColor.g;

	//this is for debugging purposes, allowing us to lower the intensity of our bump map
	vec3 nBase = vec3(0.5, 0.5, 1.0);
	nColor = mix(nBase, nColor, strength);

	//normals need to be converted to [-1.0, 1.0] range and normalized
	vec3 normal = normalize(nColor * 2.0 - 1.0);


	// Calculation for N lights
	vec3 Sum = vec3(0.0);
	int i = 0;