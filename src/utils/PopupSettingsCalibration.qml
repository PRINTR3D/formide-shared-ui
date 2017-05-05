import QtQuick 2.0

Item {
    id: root

    width: 480
    height: 224

    property var firstText: "" // Text shown as title
    property var secondText: "" // Warning

    property var confirmButtonText: "" // Text shown on confirm button

    property var fullCalibrationButtonText: ""

    property bool showExitIcon: true // Showing Home Icon

    signal confirmButtonSignal

    signal // Event emitted when pressing confirm
    cancelButtonSignal

    // Background
    Rectangle {
        anchors.fill: parent
        color: "#141414"
    }

    Text {
        width: 384
        height: 72
        x: 48
        y: 24
        font.family: "OpenSans"
        font.pixelSize: 16
        color: "#ffffff"
        lineHeight: 1.5
        //wrapMode: "WordWrap"
        text: firstText
    }

    Image {
        id: warningicon
        width: 20
        height: 20
        x: 48
        y: 104
        source: "../Images/icons/Settings/Warning.png"
    }

    Text {
        width: 400 - warningicon.x - 2
        height: 24
        y: 104
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "OpenSans"
        font.pixelSize: 16
        color: "#ef4661"
        lineHeight: 1.5
        text: secondText
        anchors.horizontalCenterOffset: 8
    }

    Rectangle {
        x: 48
        y: 144
        width: 184
        height: 48
        radius: 3
        color: "#46b1e6"

        Text {
            font.family: "OpenSans"
            font.pixelSize: 16
            color: "#ffffff"
            anchors.centerIn: parent
            text: confirmButtonText
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                confirmButtonSignal.call()
            }
        }
    }

    Rectangle {
        x: 240
        y: 144
        width: 184
        height: 48
        radius: 3
        color: "#ef4661"

        Text {
            font.family: "OpenSans"
            font.pixelSize: 16
            color: "#ffffff"
            anchors.centerIn: parent
            text: fullCalibrationButtonText
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                cancelButtonSignal.call()
            }
        }
    }
}
