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
    property bool replaced: main.replaced
    property var targetTemp: 0
    property var extruderSelected: FormideShared.extruderSelected
    property var temperature: FormideShared.temperature

    onReplacedChanged: {
        temperature = FormideShared.temperature
        extruderSelected = FormideShared.extruderSelected
        main.printerStatus.extruders[extruderSelected].targetTemp = temperature
        targetTemp = temperature
        Formide.printer(printerStatus.port).gcode(
                    "M104 T" + extruderSelected + " S" + temperature)
        checkTemperatureTimer.start()
    }

    Timer {
        id: checkTemperatureTimer
        running: false
        repeat: false
        interval: 4000
        onTriggered: {
            heatingTimer.start()
        }
    }

    Timer {
        id: heatingTimer
        running: false
        repeat: true
        interval: 2000
        onTriggered: {
            if ((printerStatus.extruders[extruderSelected].targetTemp
                 - printerStatus.extruders[extruderSelected].temp) <= 10) {
                heatingTimer.stop()
                main.viewStackActivePage = "ExtruderReplace"
            }
        }
    }

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

    Item {
        visible: replaced

        onVisibleChanged: {
            if (visible) {
                prog.visible = false
                progTimer.restart()
            } else {
                prog.visible = false
                progTimer.stop()
            }
        }

        DefaultText {
            width: 448
            height: 24
            x: 16
            y: 136
            text: "Heating up, please Wait"
            color: "white"
            font.pixelSize: 16
            horizontalAlignment: TextInput.AlignHCenter
        }

        Timer {
            id: progTimer
            running: false
            repeat: false
            interval: 500
            onTriggered: {
                prog.visible = true
            }
        }

        ProgressBar {
            id: prog
            targetProgress: getProgress()
            width: 368
            height: 16
            x: 16
            y: 176

            function getProgress() {

                var temperature = temp.getTemperature()
                var result = (temperature * 100 / targetTemp).toFixed(0)
                if (result > 100)
                    return 100
                return result
            }
        }

        DefaultText {
            id: temp
            width: 56
            height: 32
            x: 408
            y: 168
            text: ((getTemperature()) + " °")
            font.pixelSize: 24

            function getTemperature() {
                if (extruderSelected === 0) {
                    return (printerStatus.extruders[0].temp)
                }
                if (extruderSelected === 1) {
                    return (printerStatus.extruders[1].temp)
                }
            }
        }
    }
}
