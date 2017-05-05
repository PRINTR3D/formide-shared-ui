#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "../lib/SystemCall.h"
#include <unistd.h>

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    SystemCall mySystemObject;
    engine.rootContext()->setContextProperty("mySystem", &mySystemObject);
    engine.load(QUrl(QStringLiteral("qrc:/src/main.qml")));

    return app.exec();
}
