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


    function getInputDisabledValue(){
        return null
    }
    function setInputDisabledValue(value){
        return
    }


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

        // if no global InputDisabled value is passed, just start local InputDisabled timer
        if (getInputDisabledValue() === null) {
            _localInputDisabled = true
            localTimer.restart()
            buttonClicked.call()

        // else start both the InputDisabled for this button and global InputDisabled timer
        // useful when naviagting to disble the buttons on the next page temporally to avoid double clicking
        } else if(!_localInputDisabled && !getInputDisabledValue()) {
            _localInputDisabled = true
            localTimer.restart()

            setInputDisabledValue(true)
            buttonClicked.call()
        }
    }
}
