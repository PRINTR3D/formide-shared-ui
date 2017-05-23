/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../"

MouseArea {

    id: keypadLetter

    width: 80
    height: 60

    property var letter: "A"
    property var smallLetter: "ABC"

    property var yValue: 0

    property var backgroundColor: "#282828"
    property var letterColor: "#ffffff"
    property var letterSize: 24
    property var smallLetterSize: 16

    y: pressed ? yValue + 2 : yValue

    Rectangle {
        width: keypadLetter.width
        height: keypadLetter.height
        border.color: "#1e1e1e"
        border.width: 1

        color: keypadLetter.pressed ? "#46b1e6" : backgroundColor
    }

    DefaultText {

        x: 8
        y: getOffset()

        font.pixelSize: (letter === "clear") ? 16 : letterSize
        color: keypadLetter.pressed ? "#ffffff" : letterColor
        anchors.horizontalCenter: parent.horizontalCenter
        text: getLetter()

        function getLetter() {
            if (letter === "back")
                return ""
            else
                return letter
        }

        function getOffset() {
            if (letter === "clear" || letter === "back" || letter === "0"
                    || letter === "1")
                return 18
            else
                return 2
        }
    }

    DefaultText {

        y: 34

        font.pixelSize: smallLetterSize
        color: keypadLetter.pressed ? "#ffffff" : letterColor
        anchors.horizontalCenter: parent.horizontalCenter
        text: getSmallLetter()

        function getSmallLetter() {
            if (letter === "clear" || letter === "back" || letter === "0"
                    || letter === "1")
                return ""
            else
                return smallLetter
        }
        function getOffset() {
            if (letter === "clear" || letter === "back")
                return 0
            else
                return 34
        }
    }
}
