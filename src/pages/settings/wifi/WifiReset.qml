/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../../utils"
import "../../../../lib/formide/formide.js" as Formide
import "../../../../lib/formide/formideShared.js" as FormideShared

PopupWindow {

    property var printerStatus: main.printerStatus

    firstText: "Disconnect from network?"
    secondText: ""

    cancelButtonText: "Cancel" // Text shown on cancel button
    confirmButtonText: "Disconnect" // Text shown in confirm button

    cancelButton: true
    confirmButton: true

    onConfirmButtonSignal: {

        pagestack.changeTransition("newPageComesFromInside")

        main.reset(
                    function (err, response) {
                        if (err) {
                            pagestack.pushPagestack(
                                        Qt.resolvedUrl(
                                            "../../utils/PrintingError.qml"))
                        }
                        else {
                            pagestack.popPagestack()
                            pagestack.popPagestack()
                        }
                    })
        pagestack.pushPagestack(Qt.resolvedUrl("WifiDisconnecting.qml"))
    }

    onCancelButtonSignal: {
        pagestack.popPagestack()
    }
}
