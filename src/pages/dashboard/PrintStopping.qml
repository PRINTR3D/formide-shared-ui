/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0

import "../../utils"

PopupWindow {
    id: root

    firstText: "Stopping Print" // Text shown as title
    secondText: "Your file will stop printing shortly" // Text shown in subtitle

    confirmButton: false // Not showing confirm button

    Spinner {
        x: parent.width - 60
        y: parent.height - 60
    }
}
