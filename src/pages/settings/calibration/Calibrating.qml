import QtQuick 2.0
import "../../../utils"

Item {

    id: calibratePage
    height: parent.height
    width: parent.width

    DefaultText {
        width: 152
        height: 32
        font.pixelSize: 24
        x: 140
        y: 24

        text: "Calibrating..."
    }

    Image {
        width: 32
        height: 32
        x: 152 + 140 + 16
        y: 24

        source: "../../../images/icons/settings/Spinner.png"
    }

    Timer {
        running: true
        repeat: false
        interval: 3000
        onTriggered: {
            main.viewStackActivePage = "Calibration"
            calibratePage.parent.push(Qt.resolvedUrl("CalibrationFinished.qml"))
        }
    }
}
