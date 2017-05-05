import QtQuick 2.0
import "../../utils"
import "../../../lib/formide/formide.js" as Formide

Item {

    // Vars
    property var printerStatus: main.printerStatus

    property string e1temp: ""
    property string e2temp: ""
    property string bedtemp: ""

    property bool lock: main.isLocked

    function isPrinting() {
        if (!printerStatus)
            return false

        if (printerStatus.status === "printing"
                || printerStatus.status === "heating"
                || printerStatus.status === "paused")
            return true
        else
            return false
    }

    function isPaused() {
        if (!printerStatus)
            return false

        if (printerStatus.status === "paused")
            return true
        else
            return false
    }

    function getE1Temp() {
        if (!printerStatus) {
            return "000 °"
        } else
            return printerStatus.extruders[0].temp + "°"
    }

    function getE1TargetTemp() {
        if (!printerStatus) {
            return "000 °"
        } else
            return printerStatus.extruders[0].targetTemp + "°"
    }

    function getE2Temp() {
        if (!printerStatus) {
            return "000 °"
        } else {
            if (printerStatus.extruders[1])
                return printerStatus.extruders[1].temp + "°"
            else
                return "000 °"
        }
    }

    function getE2TargetTemp() {
        if (!printerStatus) {
            return "000 °"
        } else {
            if (printerStatus.extruders[1])
                return printerStatus.extruders[1].targetTemp + "°"
            else
                return "000 °"
        }
    }

    function getBedTemp() {
        if (!printerStatus) {
            return "000 °"
        } else
            return printerStatus.bed.temp + "°"
    }

    function getBedTargetTemp() {
        if (!printerStatus) {
            return "000 °"
        } else
            return printerStatus.bed.targetTemp + "°"
    }

    function getBedHeight() {
        if (!printerStatus)
            return "0.00"
        else {
            if ((printerStatus.coordinates.z).toFixed(2) < 0.01)
                return "0.00"
            else
                return (printerStatus.coordinates.z).toFixed(2)
        }
    }

    function getPrintJobName() {
        if (!printerStatus)
            return "..."
        else {
            if (printerStatus.status === "printing"
                    || printerStatus.status === "heating"
                    || printerStatus.status === "paused") {
                if (!main.currentQueueItemName) {
                    console.log("If you see this message continuously, something is going wrong")
                    main.getQueue()
                    return "..."
                } else {
                    return main.currentQueueItemName
                }
            } else {
                return "..."
            }
        }
    }

    function getPrinterStatus() {
        if (!printerStatus)
            return "Unknown"
        else {
            if (printerStatus.status === "online")
                return "Idle"
            if (printerStatus.status === "heating")
                return "Heating"
            if (printerStatus.status === "paused")
                return "Paused"
            if (printerStatus.status === "printing")
                return "Printing"
            else
                return ""
        }
    }

    function getPrintingTime() {
        if (!printerStatus)
            return "Unknown"
        else {
            if (printerStatus.status !== "printing"
                    && printerStatus.status !== "heating"
                    && printerStatus.status !== "paused") {
                return "..."
            }

            var totalSec = printerStatus.remainingPrintingTime

            if (totalSec === 0)
                return ""

            var days = 0 //(parseInt( totalSec / 3600 ) / 24).toFixed(0);
            var hours = (parseInt(totalSec / 3600)).toFixed(0)
            var minutes = (parseInt(totalSec / 60) % 60).toFixed(0)
            var seconds = (totalSec % 60).toFixed(0)

            //var result = (days<1?"":days +"d ") + (hours < 10 ? "0" + hours : hours) + ":" + (minutes < 10 ? "0" + minutes : minutes) + "h"/*+ ":" + (seconds  < 10 ? "0" + seconds : seconds)*/;
            var result = (hours < 10 ? "0" + hours : hours) + "h "
                    + (minutes < 10 ? "0" + minutes : minutes) + "m"


            //console.log("TIME: " + result)
            return result
        }
    }

    // Dashboard and temperatures
    Item {

        // Heater one
        Item {
            id: e1

            // Label
            DefaultText {
                width: 112
                height: 24
                x: 16
                y: 8
                text: "Nozzle One"
                font.weight: Font.Black
                font.pixelSize: 16
                horizontalAlignment: TextInput.AlignHCenter
            }

            // Temperatures
            DefaultText {
                width: 112
                height: 64
                x: 16
                y: 32
                font.weight: Font.Black
                text: getE1Temp() + '\n' + getE1TargetTemp() //e1temp
                font.pixelSize: 24
                horizontalAlignment: TextInput.AlignHCenter
            }

            MouseArea {
                width: 112
                height: 90
                x: 16
                y: 4
                onClicked: {
                    if (lock) {
                        pagestack.changeTransition("newPageComesFromUp")
                        pagestack.pushPagestack(
                                    Qt.resolvedUrl(
                                        "../utils/keyboard/VirtualKeypad.qml"))
                    } else {
                        if (!printerStatus) {
                            return
                        } else {
                            pagestack.changeTransition("newPageComesFromInside")
                            pagestack.pushPagestack(
                                        Qt.resolvedUrl(
                                            "Controls/ChangeTemperatureE1.qml"))
                        }
                    }
                }
            }
        }

        // Heater two
        Item {
            id: e2

            // Label
            DefaultText {
                width: 112
                height: 24
                x: 128
                y: 8
                text: "Nozzle Two"
                font.weight: Font.Black
                font.pixelSize: 16
                horizontalAlignment: TextInput.AlignHCenter
            }

            // Temperatures
            DefaultText {
                width: 112
                height: 64
                x: 128
                y: 32
                font.weight: Font.Black
                text: getE2Temp() + '\n' + getE2TargetTemp() //e1temp
                font.pixelSize: 24
                horizontalAlignment: TextInput.AlignHCenter
                //font.letterSpacing: 1.5
            }

            MouseArea {
                width: 112
                height: 90
                x: 128
                y: 4
                onClicked: {
                    if (lock) {
                        pagestack.changeTransition("newPageComesFromUp")
                        pagestack.pushPagestack(
                                    Qt.resolvedUrl(
                                        "../utils/keyboard/VirtualKeypad.qml"))
                    } else {
                        if (!printerStatus)
                            return
                        pagestack.changeTransition("newPageComesFromInside")
                        pagestack.pushPagestack(
                                    Qt.resolvedUrl(
                                        "Controls/ChangeTemperatureE2.qml"))
                    }
                }
            }
        }

        // Heated Bed
        Item {
            id: bed

            // Label
            DefaultText {
                width: 112
                height: 24
                x: 240
                y: 8
                text: "Heated Bed"
                font.pixelSize: 16
                font.weight: Font.Black
                horizontalAlignment: TextInput.AlignHCenter
            }

            // Temperatures
            DefaultText {
                width: 112
                height: 64
                x: 240
                y: 32
                font.weight: Font.Black
                text: getBedTemp() + '\n' + getBedTargetTemp() //e1temp
                font.pixelSize: 24
                horizontalAlignment: TextInput.AlignHCenter
                //                font.letterSpacing: 1.5
            }

            MouseArea {
                width: 112
                height: 90
                x: 240
                y: 4
                onClicked: {
                    if (lock) {
                        pagestack.changeTransition("newPageComesFromUp")
                        pagestack.pushPagestack(
                                    Qt.resolvedUrl(
                                        "../utils/keyboard/VirtualKeypad.qml"))
                    } else {
                        if (!printerStatus)
                            return
                        pagestack.changeTransition("newPageComesFromInside")
                        pagestack.pushPagestack(
                                    Qt.resolvedUrl(
                                        "Controls/ChangeTemperatureBed.qml"))
                    }
                }
            }
        }

        // Bed Height
        Item {
            id: height

            // Label
            DefaultText {
                width: 112
                height: 24
                x: 352
                y: 8
                text: "Bed Height"
                font.pixelSize: 16
                font.weight: Font.Black
                horizontalAlignment: TextInput.AlignHCenter
            }

            // Bed Height value
            DefaultText {
                width: 112
                height: 33
                x: 352
                y: 32
                font.weight: Font.Black
                text: getBedHeight()
                font.pixelSize: 24
                horizontalAlignment: TextInput.AlignHCenter
            }
        }
    }


    // Progress Bar
    ProgressBar {
        width: 448
        height: 16
        x: 16
        y: 104

        targetProgress: getProgress()

        function getProgress() {
            if (!printerStatus)
                return 0
            else
                return printerStatus.progress
        }
    }

    // Information and controls
    Item {

        // Information
        Item {
            // Job info
            Item {

                // Job label
                DefaultText {
                    width: 56
                    height: 24
                    x: 16
                    y: 136
                    font.pixelSize: 16
                    text: "File"
                    font.weight: Font.Black
                }

                // Job description
                DefaultText {
                    width: 160
                    height: 24
                    x: 80
                    y: 136
                    clip: true
                    font.pixelSize: 16
                    font.weight: Font.Medium
                    text: getPrintJobName()
                }
            }

            // Status information
            Item {

                // Status label
                DefaultText {
                    width: 56
                    height: 24
                    x: 16
                    y: 160
                    font.pixelSize: 16
                    font.weight: Font.Black
                    text: "Status"
                }

                // Status description
                DefaultText {
                    width: 160
                    height: 24
                    x: 80
                    y: 160
                    font.pixelSize: 16
                    font.weight: Font.Medium
                    text: getPrinterStatus()
                }
            }

            // Time information
            Item {

                // Time label
                DefaultText {
                    width: 56
                    height: 24
                    x: 16
                    y: 184
                    font.pixelSize: 16
                    font.weight: Font.Black
                    text: "Time"
                }

                // Time description
                DefaultText {
                    width: 160
                    height: 24
                    x: 80
                    y: 184
                    font.pixelSize: 16
                    font.weight: Font.Medium
                    text: getPrintingTime()
                }
            }
        }

        // Controls
        Item {

            // Pause/Resume button
            Item {

                // Pause/Resume icon
                Image {
                    width: 40
                    height: 40
                    x: 266
                    y: 136
                    source: isPrinting(
                                ) ? isPaused(
                                        ) ? "../Images/icons/Dashboard/StartButtonIcon.png" : "../Images/icons/Dashboard/PauseButtonIcon.png" : "../Images/icons/Dashboard/StartButtonIcon.png"
                }

                // Pause/Resume text
                DefaultText {
                    width: 72
                    height: 24
                    x: 248
                    y: 184
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 16
                    font.weight: Font.Black

                    text: isPrinting() ? isPaused(
                                             ) ? "Resume" : "Pause" : "Start"
                }

                MouseArea {
                    width: 72
                    height: 88
                    x: 248
                    y: 120
                    onClicked: {
                        if (lock) {
                            pagestack.changeTransition("newPageComesFromUp")
                            pagestack.pushPagestack(
                                        Qt.resolvedUrl(
                                            "../utils/keyboard/VirtualKeypad.qml"))
                        } else {
                            if (isPrinting()) {
                                if (isPaused()) {
                                    Formide.printer(printerStatus.port).resume()
                                } else {
                                    Formide.printer(printerStatus.port).pause()
                                }
                            } else {
                                main.viewStackActivePage = "Queue"
                            }
                        }
                    }
                }
            }

            // Stop Button
            Item {

                // Stop icon
                Image {
                    width: 40
                    height: 40
                    x: 336
                    y: 136
                    source: "../Images/icons/Dashboard/StopButtonIcon.png"
                }

                // Stop text
                DefaultText {
                    width: 72
                    height: 24
                    x: 320
                    y: 184
                    font.weight: Font.Black
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 16

                    text: "Stop"
                }

                MouseArea {
                    width: 72
                    height: 88
                    x: 320
                    y: 120
                    onClicked: {
                        if (lock) {
                            pagestack.changeTransition("newPageComesFromUp")
                            pagestack.pushPagestack(
                                        Qt.resolvedUrl(
                                            "../utils/keyboard/VirtualKeypad.qml"))
                        } else {
                            if (isPrinting()) {
                                pagestack.changeTransition(
                                            "newPageComesFromInside")
                                pagestack.pushPagestack(Qt.resolvedUrl(
                                                            "StopConfirm.qml"))
                            } else {
                                console.log("no stop because it's not printing!")
                            }
                        }
                    }
                }
            }

            // Control Button
            Item {

                // Control icon
                Image {
                    width: 40
                    height: 40
                    x: 408
                    y: 136
                    source: isPrinting(
                                ) ? "../Images/icons/Dashboard/TuneIcon.png" : "../Images/icons/Dashboard/ControlButtonIcon.png"
                }

                // Tune text
                DefaultText {
                    width: 72
                    height: 24
                    x: 392
                    y: 184
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 16
                    font.weight: Font.Black

                    text: isPrinting() ? "Tune" : "Control"
                }

                MouseArea {
                    width: 72
                    height: 88
                    x: 392
                    y: 120
                    onClicked: {
                        if (lock) {
                            pagestack.changeTransition("newPageComesFromUp")
                            pagestack.pushPagestack(
                                        Qt.resolvedUrl(
                                            "../utils/keyboard/VirtualKeypad.qml"))
                        } else {
                            if (isPrinting()) {
                                pagestack.changeTransition(
                                            "newPageComesFromDown")
                                pagestack.pushPagestack(
                                            Qt.resolvedUrl("Controls/Tune.qml"))
                            } else {
                                pagestack.changeTransition(
                                            "newPageComesFromDown")
                                pagestack.pushPagestack(
                                            Qt.resolvedUrl(
                                                "Controls/Controls.qml"))
                            }
                        }
                    }
                }
            }
        }
    }
}
