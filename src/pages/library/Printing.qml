/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0

import "../../utils"

MessageWindow {
    id: root

    firstText: "Processing file" // Text shown as title
    secondText: "Your file will start\nprinting immediately." // Text shown in subtitle

    confirmButton: false // Showing confirm button

    Spinner {
        x: parent.width - 60
        y: parent.height - 60
    }
}