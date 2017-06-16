/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


import QtQuick 2.0
import "../../../utils"
import "../../../../lib/formide/formideShared.js" as FormideShared
import "../../../../lib/formide/formide.js" as Formide

InsertValue {

    insertButtonText: "Change Print Speed"
    unit: "%"

    maxValue: 500
    minValue: 25
    newValue: main.speedMultiplierValue

    onConfirmButton: {

        main.speedMultiplierValue = newValue

        Formide.printer(printerStatus.port).tune("M220 S" + newValue)
        pagestack.popPagestack()
    }

    onExitButton: {
        pagestack.popPagestack()
    }
}
