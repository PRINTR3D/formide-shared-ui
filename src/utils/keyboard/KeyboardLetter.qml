/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


import QtQuick 2.0
import "../"

MouseArea {

    id: keyboardLetter

    width: 40
    height: 48

    property var letter: "A"

    property var yValue: 0

    property var backgroundColor: "#fafafa"
    property var letterColor: "black"
    property var letterSize: 20

    y: pressed ? yValue + 2 : yValue

    Rectangle {
        width: keyboardLetter.width
        height: keyboardLetter.height
        radius: 3
        color: keyboardLetter.pressed ? "#878896" : backgroundColor
    }

    DefaultText {

        font.pixelSize: letterSize
        color: keyboardLetter.pressed ? "#ffffff" : letterColor
        anchors.centerIn: parent
        text: letter
    }
}
