import Qt3D 2.0
import Qt3D.Render 2.0

Entity
{
    property Texture2D colorAttachTex
    property Layer layer

    PlaneMesh
    {
        id: planeMesh
        width: 2.0
        height: 2.0
        meshResolution: Qt.size( 2, 2 )
    }
    Transform
    {
        id: planeTransform

        Rotate
        {
            axis : Qt.vector3d( 1.0, 0.0, 0.0 )
            angle : 90
        }
    }
    Material
    {
        id: planeMat

        effect: planeEffect

        Effect
        {
            id: planeEffect
            techniques: [ planeTech ]

            Technique
            {
                id: planeTech

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
                        name: "colorAttachTex"
                        value: colorAttachTex
                    },
                    Parameter
                    {
                        name: "texSize"
                        value : Qt.size( window.width,
                                        window.height )
                    },
                    Parameter
                    {
                        name: "texOffsetX"
                        value: 1.0 / colorAttachTex.width
                    },
                    Parameter
                    {
                        name: "texOffsetY"
                        value: 1.0 / colorAttachTex.height
                    }
                ]

                renderPasses: [ outputPass ]
                RenderPass
                {
                    id: outputPass

                    shaderProgram: outputSP
                    ShaderProgram
                    {
                        id: outputSP
                        vertexShaderCode: loadSource( "qrc:/Output.vert" )
                        fragmentShaderCode: loadSource( "qrc:/Output.frag" )
                    }
                }
            }
        }
    }

    components: [ layer, planeMesh, planeTransform, planeMat ]
}
