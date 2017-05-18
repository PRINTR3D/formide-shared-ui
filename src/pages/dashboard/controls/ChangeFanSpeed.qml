/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../../utils"
import "../../../../lib/formide/formideShared.js" as FormideShared
import "../../../../lib/formide/formide.js" as Formide

InsertValue {

    property var printerStatus: main.printerStatus
    property var maxFan: 255

    buttonText: "Change Fan Speed"
    unit: "%"

    maxValue: 100
    minValue: 0
    newValue: printerStatus.fanSpeed

    onConfirmButton: {
        if (newValue == "0")
            Formide.printer(printerStatus.port).tune("M107")
        else
            Formide.printer(printerStatus.port).tune("M106 S" + newValue)

        pagestack.popPagestack()
    }

    onExitButton: {
        pagestack.popPagestack()
    }
}
