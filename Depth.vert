// Depth.vert
#version 100

// Qt 3D默认提供的参数
attribute vec3 vertexPosition;
uniform mat4 modelView;
uniform mat4 mvp;

// 自己提供的参数
varying vec4 position;

void main( void )
{
    position = modelView * vec4( vertexPosition, 1.0 );
    gl_Position = mvp * vec4( vertexPosition, 1.0 );
}
