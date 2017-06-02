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

    property var printerStatus: main.printerStatus
    property var checking: true

    Component.onCompleted: {

        if (!main.isConnectedToWifi) {
            checking = false
        } else {
            main.checkUpdate(function (callback) {
                if (callback) {
                    main.viewStackActivePage = "Update Available"
                } else {
                    main.viewStackActivePage = "No Update"
                }
            })
        }
    }

    MessageWindow {
        id: checkingMessage

        visible: checking

        firstText: "Checking for update" // Text shown as title

        centerText: true

        confirmButton: false // Showing confirm button
    }

    MessageWindow {
        id: wifiMessage

        visible: !checking

        firstText: "Connect to Wi-Fi and try again" // Text shown as title

        centerText: true

        confirmButton: false // Showing confirm button
    }

    Spinner {

        x: 368
        y: 64
        visible: checking
    }
}
