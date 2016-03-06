#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

varying vec4 vertTexCoord;
uniform sampler2D texture;
uniform float brightness;
uniform float contrast;
uniform float saturation;
uniform float ptdr;

void main() {
	vec3 texColor = texture2D(texture, vertTexCoord.st).rgb;

 	const vec3 LumCoeff = vec3(0.2125, 0.7154, 0.0721);
 	vec3 AvgLumin = vec3(0.5, 0.5, 0.5);
 	vec3 intensity = vec3(dot(texColor, LumCoeff));

	vec3 satColor = mix(intensity, texColor, saturation);
 	vec3 conColor = mix(AvgLumin, satColor, contrast);
    
    if(conColor.r >= ptdr && (conColor.g >= ptdr && conColor.b >= ptdr))
        discard;
    float lol = (conColor.r + conColor.g + conColor.b ) / 3;

  	//gl_FragColor = vec4(vec3(lol) * brightness, 1.0);
    gl_FragColor = vec4(conColor * brightness, 1.0);
}


