/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */



// Controls
import QtQuick 2.0
import "../../../"
import "../../../utils"
import "../../../utils/keyboard"

import "../../../../lib/formide/formide.js" as Formide

Rectangle {

    id: root
    width: parent.width
    height: parent.height

    property var printerStatus: main.printerStatus

    Component.onCompleted: {
        Formide.printer(printerStatus.port).gcode("G91")
    }

    // Background
    Background{
        y:0
    }

    // Home Button
    Item {
        width: 80
        height: 48

        Image {
            width: 32
            height: 32
            x: 16
            y: 8
            source: "../../../images/icons/overlays/CloseButton.png"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                pagestack.popPagestack()
            }
        }
    }

    // Home All
    KeyboardLetter {
        width: 106
        height: 48
        backgroundColor: "#46b1e6"
        letterColor: "#ffffff"
        letterSize: 16
        letter: "Home All"
        x: 16
        y: 56

        onClicked: {
            Formide.printer(printerStatus.port).gcode("G28\nG91\n")
        }
    }

    // Home X-Axis
    KeyboardLetter {
        width: 106
        height: 48
        x: 130
        y: 56
        backgroundColor: "#46b1e6"
        letterColor: "#ffffff"
        letterSize: 15
        letter: "Home X-Axis"

        onClicked: {
            Formide.printer(printerStatus.port).gcode("G28 X\nG91\n")
        }
    }

    // Home Y-Axis
    KeyboardLetter {
        width: 106
        height: 48
        x: 244
        y: 56
        backgroundColor: "#46b1e6"
        letterColor: "#ffffff"
        letterSize: 15
        letter: "Home Y-Axis"

        onClicked: {
            Formide.printer(printerStatus.port).gcode("G28 Y\nG91\n")
        }
    }

    // Home Z-Axis
    KeyboardLetter {
        width: 106
        height: 48
        x: 358
        y: 56
        letter: "Home Z-Axis"
        backgroundColor: "#46b1e6"
        letterColor: "#ffffff"
        letterSize: 15

        onClicked: {
            Formide.printer(printerStatus.port).gcode("G28 Z\nG91\n")
        }
    }


    // + Y
    ControlKey {
        height: 104
        x: 16
        y: 120
        backgroundColor: "lightgrey"
        letterSize: 16

        letter: "+ Y"

        function action () {
            Formide.printer(printerStatus.port).gcode("G1 F1500 Y10\n")
        }


    }

    // + X
    ControlKey {
        x: 130
        y: 120

        letter: "+ X"

        function action () {
            Formide.printer(printerStatus.port).gcode("G1 F1500 X10\n")
        }
    }

    // - X
    ControlKey {
        x: 130
        y: 176

        letter: "- X"

        function action () {
            Formide.printer(printerStatus.port).gcode("G1 F1500 X-10\n")
        }
    }

    // - Y
    ControlKey {
        height: 104
        x: 244
        y: 120

        letter: "- Y"

        function action () {
            Formide.printer(printerStatus.port).gcode("G1 F1500 Y-10\n")
        }
    }

    // + Z
    ControlKey {
        x: 358
        y: 120

        letter: "+ Z"

        function action () {
            Formide.printer(printerStatus.port).gcode("G1 F1500 Z5\n")
        }
    }

    // - Z
    ControlKey {
        x: 358
        y: 176
        backgroundColor: "lightgrey"
        letterSize: 16

        letter: "- Z"

        function action () {
            Formide.printer(printerStatus.port).gcode("G1 F1500 Z-5\n")
        }
    }
}
