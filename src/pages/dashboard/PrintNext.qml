/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../utils"
import "../../../lib/formide/formide.js" as Formide
import "../../../lib/formide/formideShared.js" as FormideShared


Item {

    property var isConnectedToWifi: main.isConnectedToWifi

    PopupWindow {

        visible: isConnectedToWifi

        property var printerStatus: main.printerStatus
        property var fileIndexSelected: FormideShared.fileIndexSelected
        property var queueItems: main.queueItems

        firstText: getName(0) ? "Print the next queued file?" : "No queue items found"
        secondText: getName(0) ? "File: " + getName(0) : ""

        cancelButtonText: "Cancel" // Text shown on cancel button
        confirmButtonText: getName(0) ? "Print" : "Dismiss"  // Text shown in confirm button

        cancelButton: getName(0) ? true : false
        confirmButton: true

        centerText: getName(0) ? false : true

        onConfirmButtonSignal: {

            if(getName(0)){
                pagestack.changeTransition("newPageComesFromInside")

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
            else{
                pagestack.popPagestack()
            }
        }

        onCancelButtonSignal: {
            pagestack.popPagestack()
        }

        function getName(index) {
            if (queueItems[index])
                return queueItems[index].printJob.name
            else
                return false
        }
    }

    PopupWindow {
        id: wifiMessage

        visible: !isConnectedToWifi

        firstText: "Connect to Wi-Fi and try again" // Text shown as title

        centerText: true

        cancelButton: false
        confirmButton: true
        confirmButtonText: "Dismiss"  // Text shown in confirm button

        onConfirmButtonSignal: {
            pagestack.popPagestack()
        }
    }

}
