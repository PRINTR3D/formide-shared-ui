/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */



// Controls
import QtQuick 2.0
import "../../../"
import "../../../utils"

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
    Background{}

    // Home Button
    HomeIcon {
        type: "quit"
        onHomeClicked: {
            pagestack.popPagestack()
        }
    }


    // Home All
    PushButton {

        width: 106
        x: 16
        y: 56

        buttonText: "Home All"
        backgroundColor: "#46b1e6"
        textColor: "#ffffff"

        onButtonClicked: {
            Formide.printer(printerStatus.port).gcode("G28\nG91\n")
        }
    }


    // Home X-Axis
    PushButton {

        width: 106
        x: 130
        y: 56

        buttonText: "Home X-Axis"
        backgroundColor: "#46b1e6"
        textColor: "#ffffff"

        onButtonClicked: {
            Formide.printer(printerStatus.port).gcode("G28 X\nG91\n")
        }
    }

    // Home Y-Axis
    PushButton {

        width: 106
        x: 244
        y: 56

        buttonText: "Home Y-Axis"
        backgroundColor: "#46b1e6"
        textColor: "#ffffff"

        onButtonClicked: {
            Formide.printer(printerStatus.port).gcode("G28 Y\nG91\n")
        }
    }

    // Home Z-Axis
    PushButton {

        width: 106
        x: 358
        y: 56

        buttonText: "Home Z-Axis"
        backgroundColor: "#46b1e6"
        textColor: "#ffffff"

        onButtonClicked: {
            Formide.printer(printerStatus.port).gcode("G28 Z\nG91\n")
        }
    }


    // + Y
    ControlKey {
        height: 104
        x: 16
        y: 120
        backgroundColor: "lightgrey"

        buttonText: "+ Y"

        function action () {
            Formide.printer(printerStatus.port).gcode("G1 F1500 Y10\n")
        }


    }

    // + X
    ControlKey {
        x: 130
        y: 120

        buttonText: "+ X"

        function action () {
            Formide.printer(printerStatus.port).gcode("G1 F1500 X10\n")
        }
    }

    // - X
    ControlKey {
        x: 130
        y: 176

        buttonText: "- X"

        function action () {
            Formide.printer(printerStatus.port).gcode("G1 F1500 X-10\n")
        }
    }

    // - Y
    ControlKey {
        height: 104
        x: 244
        y: 120

        buttonText: "- Y"

        function action () {
            Formide.printer(printerStatus.port).gcode("G1 F1500 Y-10\n")
        }
    }

    // + Z
    ControlKey {
        x: 358
        y: 120

        buttonText: "+ Z"

        function action () {
            Formide.printer(printerStatus.port).gcode("G1 F1500 Z5\n")
        }
    }

    // - Z
    ControlKey {
        x: 358
        y: 176
        backgroundColor: "lightgrey"
        buttonText: "- Z"

        function action () {
            Formide.printer(printerStatus.port).gcode("G1 F1500 Z-5\n")
        }
    }
}
