// Output.frag
#version 100

// 自己提供的参数
uniform sampler2D colorAttachTex;
//uniform sampler2D depthAttachTex;
uniform vec2 texSize;
uniform float texOffsetX;
uniform float texOffsetY;

float gray( vec4 color )
{
    return dot( color.xyz, vec3( 0.299, 0.587, 0.114 ) );
}

void main( void )
{
    vec4 texColor[9];
    texColor[0] = texture2D( colorAttachTex, gl_FragCoord.xy / texSize + vec2( -texOffsetX, texOffsetY ) );
    texColor[1] = texture2D( colorAttachTex, gl_FragCoord.xy / texSize + vec2( 0.0, -texOffsetY ) );
    texColor[2] = texture2D( colorAttachTex, gl_FragCoord.xy / texSize + vec2( texOffsetX, texOffsetY ) );
    texColor[3] = texture2D( colorAttachTex, gl_FragCoord.xy / texSize + vec2( -texOffsetX, 0 ) );
    texColor[4] = texture2D( colorAttachTex, gl_FragCoord.xy / texSize + vec2( 0.0, 0.0 ) );
    texColor[5] = texture2D( colorAttachTex, gl_FragCoord.xy / texSize + vec2( texOffsetX, 0 ) );
    texColor[6] = texture2D( colorAttachTex, gl_FragCoord.xy / texSize + vec2( -texOffsetX, -texOffsetY ) );
    texColor[7] = texture2D( colorAttachTex, gl_FragCoord.xy / texSize + vec2( 0.0, -texOffsetY ) );
    texColor[8] = texture2D( colorAttachTex, gl_FragCoord.xy / texSize + vec2( texOffsetX, -texOffsetY ) );

//    // 索贝尔算子
//    float sobel_x[9];
//    sobel_x[0] = -1.0;
//    sobel_x[1] = 0.0;
//    sobel_x[2] = 1.0;
//    sobel_x[3] = -2.0;
//    sobel_x[4] = 0.0;
//    sobel_x[5] = 2.0;
//    sobel_x[6] = -1.0;
//    sobel_x[7] = 0.0;
//    sobel_x[8] = 1.0;

//    float sobel_y[9];
//    sobel_y[0] = 1.0;
//    sobel_y[1] = 2.0;
//    sobel_y[2] = 1.0;
//    sobel_y[3] = 0.0;
//    sobel_y[4] = 0.0;
//    sobel_y[5] = 0.0;
//    sobel_y[6] = -1.0;
//    sobel_y[7] = -2.0;
//    sobel_y[8] = -1.0;

//    // 卷积操作
//    vec4 edgeX = vec4( 0.0 );
//    vec4 edgeY = vec4( 0.0 );
//    for ( int i = 0; i < 9; ++i )
//    {
//        edgeX += texColor[i] * sobel_x[i];
//        edgeY += texColor[i] * sobel_y[i];
//    }
    // 普雷维特算子
    float prewitt_x[9];
    prewitt_x[0] = -1.0;
    prewitt_x[1] = 0.0;
    prewitt_x[2] = 1.0;
    prewitt_x[3] = -1.0;
    prewitt_x[4] = 0.0;
    prewitt_x[5] = 1.0;
    prewitt_x[6] = -1.0;
    prewitt_x[7] = 0.0;
    prewitt_x[8] = 1.0;

    float prewitt_y[9];
    prewitt_y[0] = 1.0;
    prewitt_y[1] = 1.0;
    prewitt_y[2] = 1.0;
    prewitt_y[3] = 0.0;
    prewitt_y[4] = 0.0;
    prewitt_y[5] = 0.0;
    prewitt_y[6] = -1.0;
    prewitt_y[7] = -1.0;
    prewitt_y[8] = -1.0;

    // 卷积操作
    vec4 edgeX = vec4( 0.0 );
    vec4 edgeY = vec4( 0.0 );
    for ( int i = 0; i < 9; ++i )
    {
        edgeX += texColor[i] * prewitt_x[i];
        edgeY += texColor[i] * prewitt_y[i];
    }

    vec4 edgeColor = sqrt( ( edgeX * edgeX ) + ( edgeY * edgeY ) );
    float edgeIntensity = gray( edgeColor );
    const float threshold = 0.05;

    if ( edgeIntensity > threshold )
        gl_FragColor = vec4( 0.0, 0.0, 0.0, 1.0 );
    else discard;
}
