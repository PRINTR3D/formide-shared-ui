#configuration
CONFIG +=  cross_compile shared qpa release qt_no_framework
host_build {
    QT_ARCH = x86_64
    QT_TARGET_ARCH = arm
} else {
    QT_ARCH = arm
}
QT_CONFIG +=  minimal-config small-config medium-config large-config full-config fontconfig libudev evdev tslib libinput linuxfb c++11 accessibility egl eglfs eglfs_brcm openvg opengl opengles2 shared qpa reduce_exports clock-gettime clock-monotonic posix_fallocate mremap getaddrinfo ipv6ifname getifaddrs inotify eventfd threadsafe-cloexec poll_poll system-png png doubleconversion system-freetype harfbuzz system-zlib mtdev nis cups iconv glib dbus dbus-linked openssl libproxy rpath alsa pulseaudio gstreamer-1.0 icu concurrent audio-backend release

#versioning
QT_VERSION = 5.7.0
QT_MAJOR_VERSION = 5
QT_MINOR_VERSION = 7
QT_PATCH_VERSION = 0

#namespaces
QT_LIBINFIX = 
QT_NAMESPACE = 

QT_EDITION = OpenSource

# pkgconfig
PKG_CONFIG_SYSROOT_DIR = /opt/rpi/sysroot
PKG_CONFIG_LIBDIR = /opt/rpi/sysroot/home/pi/qtdeps/lib/pkgconfig:/opt/rpi/sysroot/usr/local/lib/pkgconfig:/opt/rpi/sysroot/usr/lib/pkgconfig:/opt/rpi/sysroot/usr/share/pkgconfig:/opt/rpi/sysroot/usr/lib/arm-linux-gnueabihf/pkgconfig

# sysroot
!host_build {
    QMAKE_CFLAGS    += --sysroot=$$[QT_SYSROOT]
    QMAKE_CXXFLAGS  += --sysroot=$$[QT_SYSROOT]
    QMAKE_LFLAGS    += --sysroot=$$[QT_SYSROOT]
}

QT_COMPILER_STDCXX = 199711
QT_GCC_MAJOR_VERSION = 4
QT_GCC_MINOR_VERSION = 8
QT_GCC_PATCH_VERSION = 3
