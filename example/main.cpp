#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "../lib/SystemCall.h"
#include <unistd.h>

int main(int argc, char* argv[])
{

    std::cout << "HOLA" << std::endl;
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    SystemCall mySystemObject;
    engine.rootContext()->setContextProperty("mySystem", &mySystemObject);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
