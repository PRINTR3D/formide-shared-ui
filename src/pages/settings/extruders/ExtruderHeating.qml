import QtQuick 2.0
import "../../.."
import "../../../utils"
import "../../../../lib/formide/formideShared.js" as FormideShared
import "../../../../lib/formide/formide.js" as Formide

Item {

    property var printerStatus: main.printerStatus
    property bool replaced: main.replaced
    property var targetTemp: FormideShared.temperature
    property var extruderSelected: FormideShared.extruderSelected

    Background{}

    DefaultText {
        width: 448
        height: 24
        x: 16
        y: 58
        text: "Heating to " + targetTemp + "°, please Wait"
        color: "white"
        font.pixelSize: 24
        horizontalAlignment: TextInput.AlignHCenter
    }

    ProgressBar {
        id: prog
        targetProgress: getProgress()
        width: 384
        height: 16
        x: 16
        y: 122
        showPercentage: false

        function getProgress() {

            var temperature = temp.getTemperature()
            var result = (temperature * 100 / targetTemp).toFixed(0)
            if (result >= 99)
                pagestack.popPagestack()
            return result
        }
    }

    DefaultText {
        id: temp
        width: 56
        height: 32
        x: 416
        y: 112
        text: ((getTemperature()) + "°")
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

    Rectangle{
        x:132
        y:176

        width: 216
        height: 48
        radius: 3
        color: mo.pressed?"#878896": "#ef4661"

        DefaultText{
           font.pixelSize: 16
           anchors.centerIn: parent
           color: "#ffffff"
           text: "Cancel"
        }

        MouseArea{

            id: mo
            anchors.fill: parent
            onClicked:{
                if(!main.inputDisabled) {
                    main.inputDisabled = true

                    // cool extruder
                    Formide.printer(printerStatus.port).gcode(
                                        "M104 T" + FormideShared.extruderSelected + " S0")

                    main.viewStackActivePage = "Extruders"
                    pagestack.popPagestack()
                }
            }
        }
    }

}
