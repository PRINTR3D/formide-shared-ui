TEMPLATE = app

QT += qml quick core
CONFIG += c++11

SOURCES += src/main.cpp\
    lib/SystemCall.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

    HEADERS += \
    lib/SystemCall.h
