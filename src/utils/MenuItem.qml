/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0

MouseArea {

    width: 72
    height: 72 + 4 + 20

    property var label

    signal buttonClicked

    // disable this button when clicked
    property bool _localInputDisabled: false
    // diable all buttons when clicked if passed
    property bool inputDisabled: null

    Timer {
        id: localTimer

        interval: 500
        repeat: false
        running: false

        onTriggered: {
            _localInputDisabled = false
        }
    }

    Rectangle {
        width: 72
        height: 72
        radius: 3
    }

    DefaultText {

        width: 72
        height: 20
        y: 76
        font.pixelSize: 12
        horizontalAlignment: TextInput.AlignHCenter
        lineHeight: 1.67

        text: label
    }

    onClicked: {

        if (inputDisabled === null) {
            _localInputDisabled = true
            localTimer.restart()
            buttonClicked.call()

        } else if(!_localInputDisabled && !inputDisabled) {
            _localInputDisabled = true
            localTimer.restart()

            inputDisabled = true
            buttonClicked.call()
        }
    }
}
