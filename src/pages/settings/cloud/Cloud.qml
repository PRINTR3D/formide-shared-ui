/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


import QtQuick 2.0

import "../../../utils"
import "../wifi"

Item {

    property var isConnectedToWifi: main.isConnectedToWifi
    Flickable {

        id: cloudFlickable
        width: parent.width
        height: parent.height
        contentHeight: getContentHeight()
        clip: true
        visible: main.isConnectedToWifi

        function getContentHeight() {
            if (cloud.expanded)
                return 496
            else
                return 416
        }

        WifiExpanded {

            id: cloud
        }
    }

    PopupWindow {
        id: wifiMessage

        visible: !isConnectedToWifi

        firstText: "Connect to Wi-Fi and try again" // Text shown as title

        centerText: true

        confirmButton: false // Showing confirm button
    }
}
