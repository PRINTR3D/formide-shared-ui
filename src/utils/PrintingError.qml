/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0

import "../"

PopupWindow {
    id: root

    firstText: "Printing error" // Text shown as title
    secondText: "File could not start printing" // Text shown in subtitle

    confirmButtonText: "Dismiss"
    confirmButton: true // Showing confirm button

    onConfirmButtonSignal: {
        pagestack.popPagestack()
        pagestack.popPagestack()
        main.viewStackActivePage = "Dashboard"
    }
}
