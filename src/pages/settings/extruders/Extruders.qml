/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../../utils"
import "../../../utils/keyboard"
import "../../../../lib/formide/formideShared.js" as FormideShared
import "../../../../lib/formide/formide.js" as Formide

Item {

    id: extrudersPage

    height: parent.height
    width: parent.width

    property var printerStatus: main.printerStatus
    property var extruderSelected: FormideShared.extruderSelected



    DefaultText {
        x: 61
        y: 16
        width: 216
        height: 33

        font.pixelSize: 24
        text: "Extruder 1"
    }

    DefaultText {
        x: 293
        y: 16

        font.pixelSize: 24
        text: "Extruder 2"
    }

    KeyboardLetter {
        width: 216
        height: 48
        x: 16
        y: 73

        letter: "Change Material"

        backgroundColor: "#46b1e6"
        letterColor: "white"
        letterSize: 16

        onClicked: {
            FormideShared.extruderSelected = 0
            pagestack.changeTransition("newPageComesFromInside")
            pagestack.pushPagestack(Qt.resolvedUrl("MaterialPreheat.qml"))
        }
    }

    KeyboardLetter {

        width: 216
        height: 48
        x: 248
        y: 73

        letter: "Change Material"

        backgroundColor: "#46b1e6"
        letterColor: "white"
        letterSize: 16

        onClicked: {
            replaced = false
            FormideShared.extruderSelected = 1
            pagestack.changeTransition("newPageComesFromInside")
            pagestack.pushPagestack(Qt.resolvedUrl("MaterialPreheat.qml"))
        }
    }
}
