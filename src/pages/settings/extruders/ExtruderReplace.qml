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

    // Load functions
    function loadFirst() {
        if (FormideShared.extruderSelected == 0) {
            Formide.printer(printerStatus.port).gcode("G1 E2 F300\n")
        } else {
            console.log('load set')
            FormideShared.extruderSelected = 0
            Formide.printer(printerStatus.port).gcode("T0\nG1 E2 F300\n")
        }
    }

    function loadSecond() {
        if (FormideShared.extruderSelected == 1) {
            Formide.printer(printerStatus.port).gcode("G1 E2 F300\n")
        } else {
            FormideShared.extruderSelected = 1
            Formide.printer(printerStatus.port).gcode("T1\nG1 E2 F300\n")
        }
    }

    function unloadFirst() {
        if (FormideShared.extruderSelected == 0) {
            Formide.printer(printerStatus.port).gcode("G1 E-2 F300\n")
        } else {
            FormideShared.extruderSelected = 0
            Formide.printer(printerStatus.port).gcode("T0\nG1 E-2 F300\n")
        }
    }

    function unloadSecond() {
        if (FormideShared.extruderSelected == 1) {
            Formide.printer(printerStatus.port).gcode("G1 E-2 F300\n")
        } else {
            FormideShared.extruderSelected = 1
            Formide.printer(printerStatus.port).gcode("T1\nG1 E-2 F300\n")
        }
    }


    Timer {
        id: unloadFirstTimer
        running: false
        repeat: true
        interval: 450
        onTriggered: {
            unloadFirst()
        }
    }

    Timer {
        id: unloadSecondTimer
        running: false
        repeat: true
        interval: 450
        onTriggered: {
            unloadSecond()
        }
    }

    Timer {
        id: loadFirstTimer
        running: false
        repeat: true
        interval: 450
        onTriggered: {
            loadFirst()
        }
    }

    Timer {
        id: loadSecondTimer
        running: false
        repeat: true
        interval: 450
        onTriggered: {
            loadSecond()
        }
    }

    DefaultText {
        x: 16
        y: 16
        width: 448
        height: 33
        horizontalAlignment: TextInput.AlignHCenter

        font.pixelSize: 24
        text: extruderSelected == 0 ? "Extruder 1" : "Extruder 2"
    }

    DefaultText {
        x: 16
        y: 65
        width: 448
        height: 33
        horizontalAlignment: TextInput.AlignHCenter

        font.pixelSize: 24
        text: "Extrude or Retract Material"
    }

    KeyboardLetter {

        width: 216
        height: 48
        x: 16
        y: 128

        letter: "Extrude"

        backgroundColor: "#46b1e6"
        letterColor: "white"
        letterSize: 16

        onPressed: {
            if (extruderSelected == 0) {
                loadFirst()
                loadFirstTimer.start()
            }
            if (extruderSelected == 1) {
                loadSecond()
                loadSecondTimer.start()
            }
        }

        onReleased: {

            loadFirstTimer.stop()
            loadSecondTimer.stop()
            unloadFirstTimer.stop()
            unloadSecondTimer.stop()
        }
    }

    KeyboardLetter {

        width: 216
        height: 48
        x: 248
        y: 128

        letter: "Retract"

        backgroundColor: "#46b1e6"
        letterColor: "white"
        letterSize: 16

        onPressed: {
            if (extruderSelected == 0) {
                unloadFirst()
                unloadFirstTimer.start()
            }
            if (extruderSelected == 1) {
                unloadSecond()
                unloadSecondTimer.start()
            }
        }

        onReleased: {

            loadFirstTimer.stop()
            loadSecondTimer.stop()
            unloadFirstTimer.stop()
            unloadSecondTimer.stop()
        }
    }
}
