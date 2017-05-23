/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


import QtQuick 2.0
import "../"
import "keyboard"
import "../../lib/formide/formide.js" as Formide

KeyboardLetter {

    id: controlKey
    width: 106
    height: 48
    backgroundColor: "lightgrey"
    letterSize: 16

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
