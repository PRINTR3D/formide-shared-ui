/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0

PopupWindow {
    id: root

    firstText: "Printer not connected" // Text shown as title
    secondText: "Printer could not be found. Please check connection before continuing." // Text shown in subtitle

    confirmButtonText: "Dismiss" // Text shown in confirm button

    confirmButton: true // Showing confirm button

    onConfirmButtonSignal: {
        pagestack.popPagestack()
    }
}
