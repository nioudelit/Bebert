#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

varying vec4 vertTexCoord;
uniform sampler2D texture;
uniform float threshold;

void main(void)
{
    vec4 col = texture2D(texture, vertTexCoord.st);//st? texture2D?
    if(col.r <= 1.0 && (col.b >= 0.5 && col.g <= 1.0))
        discard;
    gl_FragColor = col;
}