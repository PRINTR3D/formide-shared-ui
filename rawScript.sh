sudo apt-get update
sudo apt-get upgrade -y

echo "Copying Qt libs to file system..."
sudo cp -r -v Qt-rasp2-5.7.0 /usr/local
sudo cp -r -v qtdeps /usr/local/qtdeps
echo "Done."


export LD_LIBRARY_PATH=/usr/local/qtdeps/lib
export PATH=$PATH:/usr/local/qt5/bin:/usr/local/Qt-rasp2-5.7.0/bin

export PATH=$PATH:/usr/local/Qt-rasp2-5.7.0/bin
ldconfig
sudo ldconfig
export LD_LIBRARY_PATH=/usr/local/qtdeps/lib:/usr/local/Qt-rasp2-5.7.0/lib

sudo apt-get install build-essential autoconf ccache gawk gperf mesa-utils zip unzip -y

sudo ln -s /opt/vc/lib/libEGL.so /usr/lib/arm-linux-gnueabihf/libEGL.so.1.0.0
sudo ln -s /opt/vc/lib/libGLESv2.so /usr/lib/arm-linux-gnueabihf/libGLESv2.so.2.0.0
sudo ln -s /opt/vc/lib/libGLESv2.so /usr/lib/arm-linux-gnueabihf/libGLESv2.so.2

echo "deb http://apt.leandog.com/ jessie main" | sudo tee --append /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BDCBFB15
sudo apt-get update
sudo apt-get install -y qt5

sudo apt-get install -y --no-install-recommends build-essential ca-certificates curl g++ gcc git libqt5qml5 libqt5quick5 libqt5sql5 qml-module-qt-websockets qml-module-qtquick-controls qml-module-qtquick-dialogs qml-module-qtquick-layouts qml-module-qtquick-particles2 qt5-default qtdeclarative5-dev python sqlite xinit xinput-calibrator xorg


qmake
make clean
make

./formide-touch -platform eglfs

exit 0

