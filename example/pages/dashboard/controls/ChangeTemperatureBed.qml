import QtQuick 2.0
import "../../../utils"
import "../../../../lib/formide/formideShared.js" as FormideShared
import "../../../../lib/formide/formide.js" as Formide

InsertValue {

    property var printerStatus: main.printerStatus

    buttonText: "Change Bed Temperature"
    unit: "°"

    maxValue: 110
    minValue: 0
    newValue: printerStatus.bed.targetTemp

    onConfirmButton: {

        console.log("Sending: " + "M140 S" + newValue)
        Formide.printer(printerStatus.port).tune("M140 S" + newValue)
        pagestack.popPagestack()
    }

    onExitButton: {
        pagestack.popPagestack()
    }
}
