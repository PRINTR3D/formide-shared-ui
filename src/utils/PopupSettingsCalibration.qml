/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0

Item {
    id: root

    width: parent.width
    height: parent.height - 48

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
        lineHeight: 1.3
        //wrapMode: "WordWrap"
        text: firstText
    }

//    Image {
//        id: warningicon
//        width: 20
//        height: 20
//        x: 48
//        y: 104
//        source: "../images/icons/settings/Warning.png"
//    }

    Text {
        width: 384
        height: 24
        y: 108
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "OpenSans"
        font.pixelSize: 16
        color: "#ef4661"
        lineHeight: 1.3
        text: secondText
    }

    Rectangle {

        x: 56
        y: 150
        width: 176
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

    Rectangle {

        x: 248
        y: 150
        width: 176
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
}
