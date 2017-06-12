/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


import QtQuick 2.0
import "../../../utils"

import "../../../../lib/formide/formide.js" as Formide

PopupWindow {
    id: root

    firstText: "Updating Printer" // Text shown as title
    secondText: "Don't turn off during update. The printer will automatically reboot when finished."


    confirmButton: false // Showing confirm button

    Spinner {
        x: parent.width - 60
        y: parent.height - 60
    }
}
