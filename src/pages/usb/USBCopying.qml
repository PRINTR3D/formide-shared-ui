/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0

import "../../utils"

MessageWindow {
    id: root

    firstText: "Copying File" // Text shown as title
    secondText: "Copying file from USB drive to Library" // Text shown in subtitle

    confirmButton: false // Not showing confirm button

    Spinner {
        x: parent.width - 60
        y: parent.height - 60
    }
}
