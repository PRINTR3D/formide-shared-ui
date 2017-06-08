/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


import QtQuick 2.0
import "../../utils"
import "../../../lib/formide/formide.js" as Formide

PopupWindow {

    property var printerStatus: main.printerStatus
    property var queueHubsItems: main.queueHubsItems

    firstText: "Starting print from 3D Hubs" // Text shown as title
    secondText: "File:  " + queueHubsItems[0].printJob.name // Text shown in subtitle

    cancelButton: false
    confirmButton: false

    AnimatedImage{
        x: parent.width - 190
        y: parent.height - 120
        width: 160
        height: 90
        source: "../../images/gif/hubsLogo.gif"
    }

    Timer {
        id: hubsprint

        interval: 6000
        repeat: false
        running: true

        onTriggered: {
            pagestack.clearScreenFast()
        }
    }
}
