CONFIG +=  cross_compile compile_examples qpa largefile use_gold_linker enable_new_dtags neon pcre
QT_BUILD_PARTS +=  libs examples
QT_NO_DEFINES =  EGL_X11 IMAGEFORMAT_JPEG XRENDER ZLIB
QT_QCONFIG_PATH = 
host_build {
    QT_CPU_FEATURES.x86_64 =  mmx sse sse2
} else {
    QT_CPU_FEATURES.arm =  neon
}
QT_COORD_TYPE = float
QT_LFLAGS_ODBC   = -lodbc
styles += mac fusion windows
CONFIG += use_libmysqlclient_r
QT_LIBS_DBUS = -L/opt/rpi/sysroot/usr/lib/arm-linux-gnueabihf -ldbus-1
QT_CFLAGS_DBUS = -I/opt/rpi/sysroot/usr/include/dbus-1.0 -I/opt/rpi/sysroot/usr/lib/arm-linux-gnueabihf/dbus-1.0/include
QT_HOST_CFLAGS_DBUS = -I/opt/rpi/sysroot/usr/include/dbus-1.0 -I/opt/rpi/sysroot/usr/lib/arm-linux-gnueabihf/dbus-1.0/include
QT_CFLAGS_GLIB = -pthread -I/opt/rpi/sysroot/usr/include/glib-2.0 -I/opt/rpi/sysroot/usr/lib/arm-linux-gnueabihf/glib-2.0/include
QT_LIBS_GLIB = -L/opt/rpi/sysroot/usr/lib/arm-linux-gnueabihf -lgthread-2.0 -pthread -lglib-2.0
QT_CFLAGS_PULSEAUDIO = -D_REENTRANT -I/opt/rpi/sysroot/usr/include/glib-2.0 -I/opt/rpi/sysroot/usr/lib/arm-linux-gnueabihf/glib-2.0/include
QT_LIBS_PULSEAUDIO = -L/opt/rpi/sysroot/usr/lib/arm-linux-gnueabihf -lpulse-mainloop-glib -lpulse -lglib-2.0
QMAKE_CFLAGS_FONTCONFIG = -I/opt/rpi/sysroot/usr/include/freetype2
QMAKE_LIBS_FONTCONFIG = -L/opt/rpi/sysroot/usr/lib/arm-linux-gnueabihf -lfontconfig -lfreetype
QMAKE_INCDIR_LIBUDEV = 
QMAKE_LIBS_LIBUDEV = -L/opt/rpi/sysroot/usr/lib/arm-linux-gnueabihf -ludev
QMAKE_LIBINPUT_VERSION_MAJOR = 1
QMAKE_LIBINPUT_VERSION_MINOR = 0
QMAKE_INCDIR_LIBINPUT = /opt/rpi/sysroot/home/pi/qtdeps/include
QMAKE_LIBS_LIBINPUT = -L/opt/rpi/sysroot/home/pi/qtdeps/lib -linput
QMAKE_X11_PREFIX = /usr
EXTRA_INCLUDEPATH +=  "/opt/rpi/sysroot/home/pi/qtdeps/include" "/opt/rpi/sysroot/usr/include/mysql"
EXTRA_LIBS +=  -L"/opt/rpi/sysroot/home/pi/qtdeps/lib"
sql-drivers = 
sql-plugins =  mysql odbc sqlite
