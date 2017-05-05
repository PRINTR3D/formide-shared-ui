#include <QObject>
#include <iostream>

#ifndef SystemCall_H
#define SystemCall_H


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
