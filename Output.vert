// Ouput.vert
#version 100

// Qt 3D默认提供的参数
attribute vec4 vertexPosition;
uniform mat4 modelMatrix;

// 自己提供的参数

void main( void )
{
    gl_Position = modelMatrix * vertexPosition;
}
