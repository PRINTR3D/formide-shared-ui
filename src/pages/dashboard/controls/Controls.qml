// Controls
import QtQuick 2.0
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

    // Blurry Background
    Image {
        anchors.fill: parent
        source: "../../../images/blurBackground.jpg"
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
            source: "../../../images/icons/dashboard/Overlays/HomeButtonOut.png"
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
        y: 46

        onClicked: {
            Formide.printer(printerStatus.port).gcode("G28\nG91\n")
        }
    }

    // Home X-Axis
    KeyboardLetter {
        width: 106
        height: 48
        x: 130
        y: 46
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
        y: 46
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
        y: 46
        letter: "Home Z-Axis"
        backgroundColor: "#46b1e6"
        letterColor: "#ffffff"
        letterSize: 15

        onClicked: {
            Formide.printer(printerStatus.port).gcode("G28 Z\nG91\n")
        }
    }

    // + Y
    KeyboardLetter {
        width: 106
        height: 104
        x: 16
        y: 120
        backgroundColor: "lightgrey"
        letterSize: 16

        letter: "+ Y"

        onClicked: {
            Formide.printer(printerStatus.port).gcode("G1 F1500 Y10\n")
        }
    }

    // + X
    KeyboardLetter {
        width: 106
        height: 48
        x: 130
        y: 120
        backgroundColor: "lightgrey"
        letterSize: 16

        letter: "+ X"

        onClicked: {
            Formide.printer(printerStatus.port).gcode("G1 F1500 X10\n")
        }
    }

    // - X
    KeyboardLetter {
        width: 106
        height: 48
        x: 130
        y: 176
        backgroundColor: "lightgrey"
        letterSize: 16

        letter: "- X"

        onClicked: {
            Formide.printer(printerStatus.port).gcode("G1 F1500 X-10\n")
        }
    }

    // - Y
    KeyboardLetter {
        width: 106
        height: 104
        x: 244
        y: 120
        backgroundColor: "lightgrey"
        letterSize: 16

        letter: "- Y"
        onClicked: {
            Formide.printer(printerStatus.port).gcode("G1 F1500 Y-10\n")
        }
    }

    // + Z
    KeyboardLetter {
        width: 106
        height: 48
        x: 358
        y: 120
        backgroundColor: "lightgrey"
        letterSize: 16

        letter: "+ Z"

        onClicked: {
            Formide.printer(printerStatus.port).gcode("G1 F1500 Z5\n")
        }
    }

    // - Z
    KeyboardLetter {
        width: 106
        height: 48
        x: 358
        y: 176
        backgroundColor: "lightgrey"
        letterSize: 16

        letter: "- Z"

        onClicked: {
            Formide.printer(printerStatus.port).gcode("G1 F1500 Z-5\n")
        }
    }
}
