/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0

import "../../../utils"

MessageWindow {
    id: root

    firstText: "Connecting" // Text shown as title
    secondText: "Please wait while the printer\nconnects to the wireless network." // Text shown in subtitle

    confirmButtonText: "Dismiss" // Text shown in confirm button

    confirmButton: false // Showing confirm button

    Spinner {
        x: parent.width - 60
        y: parent.height - 60
    }
}
