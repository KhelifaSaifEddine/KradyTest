//#include <QGuiApplication>
//#include <QQmlApplicationEngine>
#include <Qt3DAnimation/QAnimationAspect>
#include <Qt3DQuick/QQmlAspectEngine>
#include <QGuiApplication>
#include <Qt3DQuickExtras/Qt3DQuickWindow>
#include <QtQml>

int main(int argc, char *argv[])
{
    /*QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();*/

    QGuiApplication app(argc, argv);

    Qt3DExtras::Quick::Qt3DQuickWindow view;
    //view.engine()->qmlEngine()->rootContext()->setContextProperty(QLatin1String("_envmapFormat"), envmapFormat);
    view.setSource(QUrl("qrc:/main.qml"));
    view.show();
    return app.exec();
}
