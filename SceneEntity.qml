import Qt3D 2.0
import Qt3D.Render 2.0

Entity
{
    property alias effect: material.effect
    property Layer layer

    Mesh
    {
        id: mesh
        source: "qrc:/toyplane.obj"
    }

    Material
    {
        id: material
    }

    components: [ layer, mesh, material ]
}
