import QtQuick 2.0

import "../../../utils"

MessageWindow {
    id: root

    firstText: "Page not available" // Text shown as title
    secondText: "Printer is currently printing..." // Text shown in subtitle

    confirmButtonText: "Dismiss" // Text shown in confirm button

    confirmButton: true // Showing confirm button

    onConfirmButtonSignal: {

        pagestack.popPagestack()
    }
}
