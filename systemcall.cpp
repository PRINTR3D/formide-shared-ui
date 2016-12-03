#include "systemcall.h"
#include <QProcess>

SystemCall::SystemCall()
{
    std::cout << "Object created" << std::endl;
}


QString SystemCall::msg(QString a)
{
    std::string utf8_text = a.toUtf8().constData();
    std::cout << utf8_text << std::endl;

//    system(utf8_text.c_str());

    QProcess process;
    process.start(utf8_text.c_str());
    process.waitForFinished(-1); // will wait forever until finished

    QString stdout = process.readAllStandardOutput();

    return stdout;

}

void SystemCall::msg2(QString a)
{
    std::string utf8_text = a.toUtf8().constData();
    std::cout << utf8_text << std::endl;

    system(utf8_text.c_str());



}
