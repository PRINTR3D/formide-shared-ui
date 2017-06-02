/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0

import "../../../utils"

MessageWindow {
    id: root

    firstText: "Calibration is not available" // Text shown as title
    secondText: "Printer is currently busy printing..." // Text shown in subtitle

    confirmButtonText: "Dismiss" // Text shown in confirm button

    confirmButton: true // Showing confirm button

    onConfirmButtonSignal: {
        pagestack.popPagestack()
    }
}
