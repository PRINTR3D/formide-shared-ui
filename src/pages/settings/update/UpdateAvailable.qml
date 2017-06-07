/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


import QtQuick 2.0
import "../../../utils"

import "../../../../lib/formide/formide.js" as Formide


MessagePage {
    id: updatePage

    firstText: "Software Update Available" // Text shown as title

    secondText: "Don't turn off during update. The printer will automatically reboot when finished."

    confirmButtonText: "Start Update"

    onConfirmButtonSignal: {
        console.log("Starting software update")
        main.updateElement()
        pagestack.changeTransition("newPageComesFromInside")
        pagestack.pushPagestack(Qt.resolvedUrl("UpdateActive.qml"))
    }
}
