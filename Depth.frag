// Depth.frag
#version 110

// 自己提供的参数
varying vec4 position;
//uniform float zNear;
//uniform float zFar;

bool inBetween( float v, float min, float max )
{
    return v > min && v < max;
}

void main( void )
{
    float exp = 256.0;
    gl_FragColor = vec4( vec3( pow( gl_FragCoord.z, exp ) ), 1.0);
}
