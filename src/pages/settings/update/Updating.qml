/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../../utils"

import "../../../../lib/formide/formide.js" as Formide

Item {

    id: updatePage
    height: parent.height
    width: parent.width

    DefaultText {
        width: 218
        height: 32
        font.pixelSize: 24
        x: 89
        y: 24

        text: "Installing Update..."
    }

    Image {
        width: 32
        height: 32
        x: 218 + 89 + 16
        y: 24

        source: "../../../images/icons/settings/Spinner.png"
    }

    Timer {
        running: true
        repeat: false
        interval: 3000
        onTriggered: {
            main.viewStackActivePage = "Software Update"
        }
    }
}
