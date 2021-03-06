/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


import QtQuick 2.0
import "../"

PushButton {
    width: 106
    height: 48

    buttonText: "Copy to Library"
    backgroundColor: "lightgrey"

    function action(){}

    onPressed: {
        action()
    }

    onPressAndHold: {
        letterRepeat.start()
    }

    onReleased: {
        letterRepeat.stop()
    }

    Timer {
        id:letterRepeat
        interval: 500
        repeat:true
        running:false
        onTriggered: {
            action()
        }

    }
}
