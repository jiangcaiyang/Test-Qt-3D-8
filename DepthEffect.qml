import Qt3D.Render 2.0

Effect
{
    id: effect

    techniques: [ technique ]

    Technique
    {
        id: technique
        openGLFilter
        {
            api: OpenGLFilter.Desktop
            profile: OpenGLFilter.None
            majorVersion: 2
            minorVersion: 0
        }

        Texture2D
        {
            id: texPalette

            TextureImage
            {
                source: "qrc:/discreetPalette.png"
            }
        }

        renderPasses: [ grayMapPass ]
        RenderPass
        {
            id: grayMapPass

            shaderProgram: toonSP
            ShaderProgram
            {
                id: toonSP
                vertexShaderCode: loadSource( "qrc:/Depth.vert" )
                fragmentShaderCode: loadSource( "qrc:/Depth.frag" )
            }
            renderStates:
            [
                PolygonOffset { factor: 4; units: 4 },
                DepthTest { func: DepthTest.LessOrEqual }
            ]
        }
    }
}
