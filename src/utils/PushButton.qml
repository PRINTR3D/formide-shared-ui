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

    property var buttonText:""

    property var backgroundColor: "#dcdcde"
    property var textColor: "4a4a4a"
    property var textSize:16


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
