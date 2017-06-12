/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


import QtQuick 2.0
import "../../utils"
import "../../../lib/formide/formide.js" as Formide

PopupWindow {

    property var printerStatus: main.printerStatus
    firstText: "Stop Current Print?" // Text shown as title
    secondText: "This will affect the print. Are you sure?" // Text shown in subtitle

    cancelButtonText: "No, Keep Printing" // Text shown on cancel button
    confirmButtonText: "Yes, Stop Print" // Text shown in confirm button

    cancelButton: true
    confirmButton: true

    onConfirmButtonSignal: {

        Formide.printer(printerStatus.port).stop()
        pagestack.changeTransition("newPageComesFromInside")
        pagestack.popPagestack()
        pagestack.pushPagestack(Qt.resolvedUrl("PrintStopping.qml"))
    }

    onCancelButtonSignal: {

        pagestack.popPagestack()
    }
}
