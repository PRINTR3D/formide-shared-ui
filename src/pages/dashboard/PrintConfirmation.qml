/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../utils"
import "../../../lib/formide/formide.js" as Formide
import "../../../lib/formide/formideShared.js" as FormideShared

PopupWindow {

    property var printerStatus: main.printerStatus
    property var fileIndexSelected: FormideShared.fileIndexSelected
    property var queueItems: main.queueItems

    firstText: "Print the next queued file?" // Text shown as title
    secondText: ""

    cancelButtonText: "Cancel" // Text shown on cancel button
    confirmButtonText: "Print" // Text shown in confirm button

    cancelButton: true
    confirmButton: true

    onConfirmButtonSignal: {
        main.startPrintFromQueueId(
                    queueItems[0].id,
                    queueItems[0].printJob.gcode,
                    function (err, response) {
                        if (err) {
                            pagestack.pushPagestack(
                                        Qt.resolvedUrl(
                                            "../../utils/PrintingError.qml"))
                        }
                    })
        pagestack.pushPagestack(Qt.resolvedUrl("../../utils/PrintingSpinner.qml"))
    }

    onCancelButtonSignal: {
        pagestack.popPagestack()
    }
}
