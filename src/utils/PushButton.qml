/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0


MouseArea {

    id: pushButton

    enabled: true

    width:216
    height:48

    signal buttonClicked

    // disable this button when clicked
    property bool _localInputDisabled: false
    // diable all buttons when clicked if passed
    property bool inputDisabled: null

    property var buttonText:""

    property var backgroundColor: "#dcdcde"
    property var textColor: "4a4a4a"
    property var textSize:16

    Timer {
        id: localTimer

        interval: 500
        repeat: false
        running: false

        onTriggered: {
            _localInputDisabled = false
        }
    }

    Rectangle{
        width:pushButton.width
        height:pushButton.height
        radius:3
        color:pushButton.pressed || !pushButton.enabled?"#878896":backgroundColor
    }

    DefaultText{

        font.pixelSize: textSize
        color:pushButton.pressed?"#ffffff":textColor
        anchors.centerIn: parent
        text:buttonText
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
