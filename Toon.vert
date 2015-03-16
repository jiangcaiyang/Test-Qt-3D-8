// Toon.vert
#version 100

// Qt 3D默认提供的参数
attribute vec3 vertexPosition;
attribute vec3 vertexNormal;
uniform mat4 modelView;
uniform mat4 modelNormalMatrix;
uniform mat4 mvp;

// 自己提供的参数
uniform vec3 lightPosition;
varying vec3 reflectVec;
varying vec3 viewVec;
varying float NdotL;

void main( void )
{
    vec3 ecPos = ( modelView * vec4( vertexPosition, 1.0 ) ).xyz;
    vec3 normal = normalize( modelNormalMatrix * vec4( vertexNormal, 1.0 ) ).xyz;
    vec3 lightVec = normalize( lightPosition - ecPos );
    reflectVec = normalize( reflect( -lightVec, normal ) );
    viewVec = normalize( -ecPos );
    NdotL = ( dot( lightVec, normal ) + 1.0 ) * 0.5;

    gl_Position = mvp * vec4( vertexPosition, 1.0 );
}
