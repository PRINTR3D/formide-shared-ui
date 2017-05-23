/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0

Item {

    property var progress: 0
    property var targetProgress: 0
    property var printerStatus: main.printerStatus

    id: progressBar
    width: parent.width
    height: 16

    property bool lock: main.isLocked

    onTargetProgressChanged: {

        progressAnimation.start()
    }

    SequentialAnimation {
        id: progressAnimation
        NumberAnimation {
            target: progressBar
            from: progress
            property: "progress"
            to: targetProgress
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }

    Rectangle {
        id: barEmpty
        width: parent.width
        height: parent.height
        radius: 3
        color: "#fff"
    }

    Rectangle {
        id: bar
        //property var targetProgress: parent.width * progress / 100
        width: parent.width * progress / 100
        height: parent.height
        radius: 3
        color: "#46b1e6"
    }

    DefaultText {
        id: barLabel
        x: getX()
        y: -2
        font.pixelSize: 14
        font.weight: Font.Black
        text: getText()
        color: getColor()

        function getText() {
            if (targetProgress == 0)
                return ""
            else
                return targetProgress + "%"
        }

        function getColor() {
            if (targetProgress < 10)
                return "#46b1e6"
            else
                return "#fff"
        }

        function getX() {
            if (targetProgress < 10)
                return parent.width / 100 * progress + 8
            else
                return 8
        }
    }
}
