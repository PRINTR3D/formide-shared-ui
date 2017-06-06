/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


import QtQuick 2.0
import "../../../utils"

import "../../../../lib/formide/formide.js" as Formide


MessageWindow {
    id: updatePage

    firstText: "Software Update Available" // Text shown as title

    secondText: "Don't turn off the printer during update. When the update is finished the printer will automatically reboot. This may take a few minutes to complete."

    confirmButtonText: "Start Update"

    onConfirmButtonSignal: {
        console.log("Starting software update")
        main.viewStackActivePage = "Update Active"
    }
}
