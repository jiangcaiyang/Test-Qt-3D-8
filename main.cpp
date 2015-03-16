#include <QApplication>
#include <QDesktopWidget>
#include <QQmlApplicationEngine>
#include <Window>
#include <QRenderAspect>
#include <QInputAspect>
#include <QQmlAspectEngine>
#include <QQmlContext>

int main( int argc, char* argv[] )
{
    QApplication app( argc, argv );

    QSurfaceFormat defaultFormat;
    defaultFormat.setSamples( 4 );
    QSurfaceFormat::setDefaultFormat( defaultFormat );

    Qt3D::Window window;
    Qt3D::Quick::QQmlAspectEngine engine;
    engine.aspectEngine( )->registerAspect( new Qt3D::QRenderAspect );
    engine.aspectEngine( )->registerAspect( new Qt3D::QInputAspect );
    engine.aspectEngine( )->initialize( );

    QVariantMap data;
    data.insert( QStringLiteral( "surface" ),
                 QVariant::fromValue( static_cast<QSurface*>( &window ) ) );
    data.insert( QStringLiteral( "eventSource" ),
                 QVariant::fromValue( &window ) );
    engine.aspectEngine( )->setData( data );
    engine.qmlEngine( )->rootContext( )->setContextProperty( "window", &window );

    engine.aspectEngine( )->initialize( );
    engine.setSource( QUrl( "qrc:/main.qml" ) );

    // 让窗口以一定的大小居中显示
    int clientWidth = app.desktop( )->availableGeometry( ).width( );
    int clientHeight = app.desktop( )->availableGeometry( ).height( );
    int windowWidth = 480;
    int windowHeight = 320;

    window.setGeometry( ( clientWidth - windowWidth ) / 2,
                        ( clientHeight - windowHeight ) / 2,
                        windowWidth,
                        windowHeight );
    window.show( );

    return app.exec( );
}
