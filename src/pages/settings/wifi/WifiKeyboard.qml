import QtQuick 2.0

import "../../../utils/keyboard"
import "../../../../lib/formide/formideShared.js" as FormideShared

VirtualKeyboard {

    onExit: {
        pagestack.popPagestack()
    }

    onSubmitPassword: {

        console.log("Connecting to " + FormideShared.ssidToConnect)
        main.connectToWifi(FormideShared.ssidToConnect, password,
                           function (err, response) {
                               if (err) {
                                   pagestack.popPagestack()
                                   pagestack.popPagestack()
                                   pagestack.pushPagestack(Qt.resolvedUrl(
                                                               "WifiError.qml"))
                               }
                               if (response) {
                                   pagestack.popPagestack()
                                   pagestack.popPagestack()
                               }
                           })

        pagestack.pushPagestack(Qt.resolvedUrl("WifiConnecting.qml"))
    }
}
