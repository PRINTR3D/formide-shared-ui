/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


#include "SystemCall.h"
#include <QProcess>

SystemCall::SystemCall()
{

}

QString SystemCall::msg(QString a)
{
    std::string utf8_text = a.toUtf8().constData();
    std::cout << utf8_text << std::endl;

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
