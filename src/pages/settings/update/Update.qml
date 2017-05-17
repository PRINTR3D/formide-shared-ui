import QtQuick 2.0
import "../../../utils"

import "../../../../lib/formide/formide.js" as Formide

Item {

    id: updatePage
    height: parent.height
    width: parent.width

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

    DefaultText {
        id: text
        width: 254
        height: 32
        font.pixelSize: checking ? 24 : 18
        x: checking ? 89 : 70
        y: checking ? 24 : 70

        text: checking ? "Checking for update..." : "Please connect to Wi-Fi and try again"
    }

    Spinner {

        x: 254 + 89 + 16
        y: 24
        visible: checking
    }
}
