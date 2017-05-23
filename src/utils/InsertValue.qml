/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "keyboard/"

Item {

    id: root
    height: parent.height
    width: parent.width

    property var newValue
    property var buttonText: "Change buttonText"
    property var unit: ""

    property var maxValue
    property var minValue

    signal confirmButton
    signal exitButton

    property bool visibleHomeIcon: true

    onNewValueChanged: {

        if (newValue < minValue) {
            newValue = minValue
        }
    }

    Component.onCompleted: {

        if (newValue)
            mousi.contentX = newValue * 20
    }

    function getValueComplete() {

        return newValue + unit
    }
    // Blurry Background
    Image {
        anchors.fill: parent
        source: "../images/blurBackground.jpg"
    }

    Item {
        width: parent.width
        height: /*parent.height - 112*/ 160

        Flickable {
            id: mousi
            width: parent.width
            height: parent.height
            anchors.centerIn: parent

            contentWidth: width + (maxValue * 20)
            contentHeight: parent.height
            boundsBehavior: Flickable.StopAtBounds
            onContentXChanged: newValue = (contentX / 20).toFixed(0)
            clip: true
        }
    }

    Item {
        width: 208
        height: 56
        x: 136
        y: 64

        DefaultText {
            anchors.centerIn: parent
            text: newValue
            horizontalAlignment: TextInput.AlignHCenter
            font.pixelSize: 56
            font.weight: Font.Black
        }
    }

    HomeIcon {
        visible: visibleHomeIcon
        type: "quit"
        onHomeClicked: {
            exitButton.call()
        }
    }

    // Arrow back
    Image {
        width: 36
        height: 56
        x: 100
        y: 64
        source: "../images/icons/dashboard/Overlays/LowerIcon.png"
    }

    // Arrow forward
    Image {
        width: 36
        height: 56
        x: 344
        y: 64
        source: "../images/icons/dashboard/Overlays/RaiseIcon.png"
    }

    KeyboardLetter {
        width: 280
        height: 48
        x: 100
        y: 160
        letter: buttonText

        backgroundColor: "#46b1e6"
        letterColor: "#ffffff"
        letterSize: 16

        onClicked: {
            confirmButton.call()
        }
    }
}
