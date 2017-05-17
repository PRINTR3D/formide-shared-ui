import QtQuick 2.0
import "../../../utils"
import "../../../../lib/formide/formideShared.js" as FormideShared
import "../../../../lib/formide/formide.js" as Formide

InsertValue {

    property var printerStatus: main.printerStatus

    buttonText: "Change Print Speed"
    unit: "%"

    maxValue: 500
    minValue: 25
    newValue: printerStatus.speedMultiplier

    onConfirmButton: {

        Formide.printer(printerStatus.port).tune("M220 S" + newValue)
        pagestack.popPagestack()
    }

    onExitButton: {
        pagestack.popPagestack()
    }
}
