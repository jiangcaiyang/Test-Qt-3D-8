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
        format: Texture.RGBAFormat
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
        format: Texture.DepthFormat
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
            clearColor: Qt.rgba( 0.8, 0.6, 0.3, 1.0 )

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

            LayerFilter
            {
                layers: [ "screenQuad" ]
                CameraSelector
                {
                    camera: camera

                    ClearBuffer
                    {
                        buffers: ClearBuffer.ColorDepthBuffer
                    }
                }
            }


        }
    }

    SceneEntity
    {
        Layer { id: sceneLayer; names: "scene" }
        effect: DepthEffect { }
        layer: sceneLayer
    }

    SceneEntity
    {
        Layer { id: quadLayer_1; names: "screenQuad" }
        effect: ToonEffect { }
        layer: quadLayer_1
    }

    ScreenQuadEntity
    {
        Layer { id: quadLayer; names: "screenQuad" }
        colorAttachTex: colorAttachTex
        layer: quadLayer
    }

    Configuration
    {
        controlledCamera: camera
    }
}
