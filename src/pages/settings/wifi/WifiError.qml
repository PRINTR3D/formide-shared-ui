import QtQuick 2.0

import "../../../utils"

MessageWindow {
    id: root

    firstText: "Failed to connect" // Text shown as title
    secondText: "Could not connect to Wi-Fi network" // Text shown in subtitle

    confirmButtonText: "Dismiss" // Text shown in confirm button

    confirmButton: true // Showing confirm button

    onConfirmButtonSignal: {

        //pagestack.popPagestack()
        //pagestack.popPagestack()
        pagestack.popPagestack()
    }
}
