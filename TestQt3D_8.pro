TEMPLATE = app

QT += widgets qml quick 3dcore 3drenderer 3dinput 3dquick

SOURCES += main.cpp

RESOURCES += \
    Resource3D.qrc \
    Shaders.qrc \
    Image.qrc \
    QML.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)
