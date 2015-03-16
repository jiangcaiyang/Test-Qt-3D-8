// Toon.frag
#version 100

// 自己提供的参数
varying vec3 reflectVec;
varying vec3 viewVec;
varying float NdotL;
uniform sampler2D texPalette;

void main( void )
{
    gl_FragColor = texture2D( texPalette, vec2( NdotL, 1.0 ) );
    //gl_FragData[0] = texture2D( texPalette, vec2( NdotL, 1.0 ) );
}
