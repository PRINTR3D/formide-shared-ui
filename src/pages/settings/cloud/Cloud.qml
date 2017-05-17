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

    DefaultText {
        id: text
        width: 254
        height: 32
        font.pixelSize: 18
        x: 70
        y: 70
        visible: !isConnectedToWiFi
        text: "Please connect to Wi-Fi and try again"
    }
}
