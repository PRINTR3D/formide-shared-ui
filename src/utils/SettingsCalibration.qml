/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../"

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

    Background{}

    Text {
        width: 384
        height: 72
        x: 48
        y: 40
        font.family: "OpenSans"
        font.pixelSize: 16
        color: "#ffffff"
        lineHeight: 1.2
        text: firstText
    }

    PushButton {
        x:132
        y: 150

        buttonText: confirmButtonText

        backgroundColor: "#46b1e6"
        textColor: "#ffffff"

        inputDisabled: main.inputDisabled

        onButtonClicked: {
            confirmButtonSignal.call()
        }
    }
}
