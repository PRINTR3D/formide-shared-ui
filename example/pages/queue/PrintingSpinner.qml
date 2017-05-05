import QtQuick 2.0

import "../../utils"

MessageWindow {
    id: root

    firstText: "Processing file" // Text shown as title
    secondText: "Your file will start\nprinting immediately." // Text shown in subtitle

    confirmButton: false // Not showing confirm button

    Spinner {
        x: parent.width - 60
        y: parent.height - 60
    }
}
