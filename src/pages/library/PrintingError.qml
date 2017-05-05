import QtQuick 2.0

import "../../utils"

MessageWindow {
    id: root

    firstText: "Printing error" // Text shown as title
    secondText: "File could not start printing." // Text shown in subtitle

    confirmButtonText: "Dismiss"
    confirmButton: true // Showing confirm button

    onConfirmButtonSignal: {
        pagestack.popPagestack()
        pagestack.popPagestack()
        main.viewStackActivePage = "Dashboard"
    }
}
