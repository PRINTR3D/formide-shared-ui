import QtQuick 2.0

Rectangle {

    width: 480
    //height: 65
    height: 73
    color: "#141414"

    property var name: "Network name"
    property var fileImagePath: "../Images/icons/Dashboard/Overlays/RaiseIcon.png"
    property var fileImagePathLock: "../Images/icons/Header/LockIcon.png"

    signal clickedSignal

    function getButtonImage() {
        return "../Images/icons/Header/WifiIcon.png"
    }

    Image {
        x: 24
        y: 23
        width: 48
        height: 34.9
        source: getButtonImage()
    }

    // Label
    DefaultText {
        x: 80
        y: 22
        width: 256
        height: 32
        font.weight: Font.Bold
        font.pixelSize: 24

        text: name
    }

    //Lock
    Item {
        width: 26
        height: 32
        x: 382
        y: 24

        Image {
            anchors.fill: parent
            source: fileImagePathLock
        }
    }

    // Arrow
    Item {
        width: 32
        height: 48
        x: 424
        y: 16

        Image {
            anchors.fill: parent
            source: fileImagePath
        }
    }

    // Separator
    Rectangle {
        width: 448
        height: 1
        x: 16
        y: 72
        color: "#d8d8d8"
    }

    // We will use this in the future
    MouseArea {
        anchors.fill: parent
        onClicked: {
            clickedSignal.call()
        }
    }
}
