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
        id: bar
        //property var targetProgress: parent.width * progress / 100
        width: parent.width * progress / 100
        height: parent.height
        radius: 3
        color: "#46b1e6"
    }
}
