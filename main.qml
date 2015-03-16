import Qt3D 2.0
import Qt3D.Render 2.0

Entity
{
    id: root

    Camera
    {
        id: camera
        position: Qt.vector3d( 0.0, 0.0, -40.0 )
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        aspectRatio: 16.0 / 9.0
        nearPlane : 0.1
        farPlane : 1000.0
        upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
        viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
    }

    Texture2D
    {
        id: colorAttachTex
        width: 1024
        height: 1024
        format: Texture.RGB8_UNorm
        generateMipMaps: false
        magnificationFilter: Texture.Nearest
        minificationFilter: Texture.Nearest
        wrapMode
        {
            x: WrapMode.ClampToEdge
            y: WrapMode.ClampToEdge
        }
    }

    Texture2D
    {
        id : depthAttachTex
        width: 1024
        height: 1024
        format: Texture.D32F
        generateMipMaps: false
        magnificationFilter: Texture.Nearest
        minificationFilter: Texture.Nearest
        wrapMode
        {
            x: WrapMode.ClampToEdge
            y: WrapMode.ClampToEdge
        }
    }

    components: FrameGraph
    {
        Viewport
        {
            rect: Qt.rect( 0.0, 0.0, 1.0, 1.0 )
            clearColor: Qt.rgba( 0.0, 0.4, 0.7, 1.0 )

            LayerFilter
            {
                layers: "scene"

                CameraSelector
                {
                    camera: camera

                    ClearBuffer
                    {
                        buffers: ClearBuffer.ColorDepthBuffer
                        RenderTargetSelector
                        {
                            target: RenderTarget
                            {
                                attachments:
                                [
                                    RenderAttachment
                                    {
                                        name: "colorAttachTex"
                                        type: RenderAttachment.ColorAttachment0
                                        texture: colorAttachTex
                                    },
                                    RenderAttachment
                                    {
                                        name: "depthAttachTex"
                                        type: RenderAttachment.DepthAttachment
                                        texture: depthAttachTex
                                    }
                                ]
                            }
                        }
                    }
                }
            }

            ClearBuffer
            {
                buffers: ClearBuffer.ColorDepthBuffer
                CameraSelector
                {
                    camera: camera
                }
            }
        }
    }

    Entity
    {
        Layer
        {
            id: sceneLayer
            names: "scene"
        }

        Mesh
        {
            id: mesh
            source: "qrc:/toyplane.obj"
        }

        Material
        {
            id: material
            effect: effect

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

                    renderPasses: [ grayMapPass ]
                    RenderPass
                    {
                        id: grayMapPass

                        shaderProgram: toonSP
                        ShaderProgram
                        {
                            id: toonSP
                            vertexShaderCode: loadSource( "qrc:/Toon.vert" )
                            fragmentShaderCode: loadSource( "qrc:/Toon.frag" )
                        }

//                        renderStates:
//                        [
//                            PolygonOffset { factor: 4; units: 4 },
//                            DepthTest { func: DepthTest.LessOrEqual }
//                        ]
                    }
                }
            }
        }

        components: [ sceneLayer, mesh, material ]
    }

    //! [9]
    Entity
    {
        Layer
        {
            id: screenLayer
            names: "screenQuad"
        }
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
                            name: "depthAttachTex"
                            value: depthAttachTex
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

//                        renderStates:
//                        [
//                            PolygonOffset { factor: 4; units: 4 },
//                            DepthTest { func: DepthTest.Less }
//                        ]
                    }
                }
            }
        }

        components: [ screenLayer, planeMesh, planeTransform, planeMat ]
    }
    //! [9]

    Configuration
    {
        controlledCamera: camera
    }
}
