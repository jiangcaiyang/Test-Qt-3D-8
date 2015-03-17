import Qt3D 2.0
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

        parameters:
        [
            Parameter
            {
                id: lightPP
                name: "lightPosition"
                value: camera.position
            },
            Parameter
            {
                name: "texPalette"
                value: texPalette
            }
        ]

        Texture2D
        {
            id: texPalette

            TextureImage
            {
                source: "qrc:/discreetPalette.png"
            }
        }

        renderPasses: [ toonMapPass ]
        RenderPass
        {
            id: toonMapPass

            shaderProgram: toonSP
            ShaderProgram
            {
                id: toonSP
                vertexShaderCode: loadSource( "qrc:/Toon.vert" )
                fragmentShaderCode: loadSource( "qrc:/Toon.frag" )
            }
        }
    }
}
