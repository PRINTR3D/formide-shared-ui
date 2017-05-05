import QtQuick 2.0
import "../../../utils"
import "../../../../lib/formide/formideShared.js" as FormideShared
import "../../../../lib/formide/formide.js" as Formide

InsertValue {

    property var printerStatus: main.printerStatus

    buttonText: "Change Temperature E1"
    unit: "°"

    maxValue: 275
    minValue: 0
    newValue: printerStatus.extruders[0].targetTemp

    onConfirmButton: {

        console.log("Sending: " + "M104 T0 S" + newValue)
        Formide.printer(printerStatus.port).tune("M104 T0 S" + newValue)
        pagestack.popPagestack()
    }

    onExitButton: {
        pagestack.popPagestack()
    }
}
