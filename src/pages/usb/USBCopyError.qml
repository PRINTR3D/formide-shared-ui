import QtQuick 2.0
import "../../utils"

PopupWindow {
    id: wifiMessage

    visible: !isConnectedToWifi

    firstText: "Copying file failed" // Text shown as title

    centerText: true

    cancelButton: false
    confirmButton: true
    confirmButtonText: "Dismiss"  // Text shown in confirm button

    onConfirmButtonSignal: {
        pagestack.popPagestack()
        pagestack.popPagestack()
    }
}
