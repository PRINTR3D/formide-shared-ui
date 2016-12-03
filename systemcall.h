#include <QObject>
#include <iostream>

#ifndef systemcall_H
#define systemcall_H


class SystemCall : public QObject
{
    Q_OBJECT

public:
     SystemCall();
    int x;
     Q_INVOKABLE QString msg(QString a);

    Q_INVOKABLE void msg2(QString a);

};

#endif // SystemCall_H
