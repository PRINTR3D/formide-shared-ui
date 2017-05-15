#!/bin/bash

echo "Raspberry Pi Qt installation (eglfs plugin included)"
# Copy Qt Dependancies and drivers to file system
pushd . > /dev/null
cd deps

echo "Copying Qt libs to file system..."
sudo cp -r Qt-rasp2-5.7.0 /usr/local
sudo cp -r qtdeps /usr/local/qtdeps
echo "Done."

# Update bin and library paths
echo "Updating binary and library paths..."
export LD_LIBRARY_PATH=/usr/local/qtdeps/lib:/usr/local/Qt-rasp2-5.7.0/lib:/usr/lib/arm-linux-gnueabihf
export PATH=$PATH:/usr/local/Qt-rasp2-5.7.0/bin
echo "Done."

# Link GPU eglfs binaries so Qt can get to them in system path
echo "Creating symlinks to correct libEGL libraries..."
sudo ln -s /opt/vc/lib/libEGL.so /usr/lib/arm-linux-gnueabihf/libEGL.so.1.0.0
sudo ln -s /opt/vc/lib/libGLESv2.so /usr/lib/arm-linux-gnueabihf/libGLESv2.so.2.0.0
sudo ln -s /opt/vc/lib/libGLESv2.so /usr/lib/arm-linux-gnueabihf/libGLESv2.so.2
echo "Done."

# Install the leandog apt server in your sources
echo "Installing Qt5 and qmake..."
echo "deb http://apt.leandog.com/ jessie main" | sudo tee --append /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BDCBFB15

# Install Qt5 packages
sudo apt-get update
sudo apt-get install -y qt5
sudo apt-get install -y --no-install-recommends build-essential ca-certificates curl g++ gcc git libqt5qml5 libqt5quick5 libqt5sql5 qml-module-qt-websockets qml-module-qtquick-controls qml-module-qtquick-dialogs qml-module-qtquick-layouts qml-module-qtquick-particles2 qt5-default qtdeclarative5-dev python sqlite xinit xinput-calibrator xorg
echo "Done."

# Back to main folder
popd > /dev/null

echo "Creating Makefiles necessary for compiling"
# Create Makefiles
qmake
echo "Done."

echo "All done!"
