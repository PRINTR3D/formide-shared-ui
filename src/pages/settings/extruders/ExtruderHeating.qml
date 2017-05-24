import QtQuick 2.0
import "../../../utils"
import "../../../utils/keyboard"
import "../../../../lib/formide/formideShared.js" as FormideShared
import "../../../../lib/formide/formide.js" as Formide

Item {

    property var printerStatus: main.printerStatus
    property bool replaced: main.replaced
    property var targetTemp: FormideShared.temperature
    property var extruderSelected: FormideShared.extruderSelected

    // Background
    Rectangle {
        anchors.fill: parent
        color: "#141414"
    }

    DefaultText {
        width: 448
        height: 24
        x: 16
        y: 80
        text: "Heating to " + targetTemp + " °, please Wait"
        color: "white"
        font.pixelSize: 24
        horizontalAlignment: TextInput.AlignHCenter
    }

    ProgressBar {
        id: prog
        targetProgress: getProgress()
        width: 368
        height: 16
        x: 16
        y: 150

        function getProgress() {

            var temperature = temp.getTemperature()
            var result = (temperature * 100 / targetTemp).toFixed(0)
            if (result >= 100)
                pagestack.popPagestack()
            return result
        }
    }

    DefaultText {
        id: temp
        width: 56
        height: 32
        x: 408
        y: 142
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
