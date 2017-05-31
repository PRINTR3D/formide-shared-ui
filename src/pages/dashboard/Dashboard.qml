/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


import QtQuick 2.0
import "../../utils"
import "../../../lib/formide/formide.js" as Formide

Item {

    // Vars
    property var printerStatus: main.printerStatus
    property var unitMultiplierX:1//main.unitMultiplierX
    property var unitMultiplierY:1//main.unitMultiplierY


    property string e1temp: ""
    property string e2temp: ""
    property string bedtemp: ""

    property bool lock: main.isLocked

    property var queueItems: main.queueItems

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
            return "0 °"
        } else
            return printerStatus.extruders[0].temp + "°"
    }

    function getE1TargetTemp() {
        if (!printerStatus) {
            return "0 °"
        } else
            return printerStatus.extruders[0].targetTemp + "°"
    }

    function getE2Temp() {
        if (!printerStatus) {
            return "0 °"
        } else {
            if (printerStatus.extruders[1])
                return printerStatus.extruders[1].temp + "°"
            else
                return "-"
        }
    }

    function getE2TargetTemp() {
        if (!printerStatus) {
            return "0 °"
        } else {
            if (printerStatus.extruders[1])
                return printerStatus.extruders[1].targetTemp + "°"
            else
                return ""
        }
    }

    function getBedTemp() {
        if (!printerStatus) {
            return "0 °"
        } else
            if (printerStatus.bed.temp)
                return printerStatus.bed.temp + "°"
            else
                return "-"

    }

    function getBedTargetTemp() {
        if (!printerStatus) {
            return "0 °"
        } else
            if (printerStatus.bed.temp)
                return printerStatus.bed.targetTemp + "°"
            else
                return ""
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
            return "-"
        else {
            if (printerStatus.status === "printing"
                    || printerStatus.status === "heating"
                    || printerStatus.status === "paused") {
                if (!main.currentQueueItemName) {
                    console.log("If you see this message continuously, something is going wrong")
                    main.getQueue()
                    return "-"
                } else {
                    return main.currentQueueItemName
                }
            } else {
                return "-"
            }
        }
    }

    function getPrinterStatus() {
        if (!printerStatus)
            return "Idle"
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
            return "-"
        else {
            if (printerStatus.status !== "printing"
                    && printerStatus.status !== "heating"
                    && printerStatus.status !== "paused") {
                return "-"
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
                width: 112 * unitMultiplierX
                height: 24 * unitMultiplierY
                x: 16 * unitMultiplierX
                y: 8 * unitMultiplierY
                text: "Nozzle One"
                font.weight: Font.Black
                font.pixelSize: 16
                horizontalAlignment: TextInput.AlignHCenter
            }

            // Temperatures
            DefaultText {
                width: 112 * unitMultiplierX
                height: 64 * unitMultiplierY
                x: 16 * unitMultiplierX
                y: 32* unitMultiplierY
                font.weight: Font.Black
                text: getE1Temp() + '\n' + getE1TargetTemp() //e1temp
                font.pixelSize: 24
                horizontalAlignment: TextInput.AlignHCenter
            }

            MouseArea {
                width: 112 * unitMultiplierX
                height: 90 * unitMultiplierY
                x: 16 * unitMultiplierX
                y: 4 * unitMultiplierY
                onClicked: {
                    if (lock) {
                        pagestack.changeTransition("newPageComesFromUp")
                        pagestack.pushPagestack(
                                    Qt.resolvedUrl(
                                        "../../utils/keyboard/VirtualKeypad.qml"))
                    } else {
                        if (!printerStatus || !printerStatus.extruders[0]) {
                            return
                        } else {
                            pagestack.changeTransition("newPageComesFromInside")
                            pagestack.pushPagestack(
                                        Qt.resolvedUrl(
                                            "controls/ChangeTemperatureE1.qml"))
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
                width: 112 * unitMultiplierX
                height: 24 * unitMultiplierY
                x: 128 * unitMultiplierX
                y: 8 * unitMultiplierY
                text: "Nozzle Two"
                font.weight: Font.Black
                font.pixelSize: 16
                horizontalAlignment: TextInput.AlignHCenter
            }

            // Temperatures
            DefaultText {
                width: 112 * unitMultiplierX
                height: 64 * unitMultiplierY
                x: 128 * unitMultiplierX
                y: 32 * unitMultiplierY
                font.weight: Font.Black
                text: getE2Temp() + '\n' + getE2TargetTemp() //e1temp
                font.pixelSize: 24
                horizontalAlignment: TextInput.AlignHCenter
                //font.letterSpacing: 1.5
            }

            MouseArea {
                width: 112 * unitMultiplierX
                height: 90 * unitMultiplierY
                x: 128 * unitMultiplierX
                y: 4 * unitMultiplierY
                onClicked: {
                    if (lock) {
                        pagestack.changeTransition("newPageComesFromUp")
                        pagestack.pushPagestack(
                                    Qt.resolvedUrl(
                                        "../../utils/keyboard/VirtualKeypad.qml"))
                    } else {
                        if (!printerStatus || !printerStatus.extruders[1])
                            return
                        pagestack.changeTransition("newPageComesFromInside")
                        pagestack.pushPagestack(
                                    Qt.resolvedUrl(
                                        "controls/ChangeTemperatureE2.qml"))
                    }
                }
            }
        }

        // Heated Bed
        Item {
            id: bed

            // Label
            DefaultText {
                width: 112 * unitMultiplierX
                height: 24 * unitMultiplierY
                x: 240 * unitMultiplierX
                y: 8 * unitMultiplierY
                text: "Heated Bed"
                font.pixelSize: 16
                font.weight: Font.Black
                horizontalAlignment: TextInput.AlignHCenter
            }

            // Temperatures
            DefaultText {
                width: 112 * unitMultiplierX
                height: 64 * unitMultiplierY
                x: 240 * unitMultiplierX
                y: 32 * unitMultiplierY
                font.weight: Font.Black
                text: getBedTemp() + '\n' + getBedTargetTemp() //e1temp
                font.pixelSize: 24
                horizontalAlignment: TextInput.AlignHCenter
                //                font.letterSpacing: 1.5
            }

            MouseArea {
                width: 112 * unitMultiplierX
                height: 90 * unitMultiplierY
                x: 240 * unitMultiplierX
                y: 4 * unitMultiplierY
                onClicked: {
                    if (lock) {
                        pagestack.changeTransition("newPageComesFromUp")
                        pagestack.pushPagestack(
                                    Qt.resolvedUrl(
                                        "../../utils/keyboard/VirtualKeypad.qml"))
                    } else {
                        if (!printerStatus || !printerStatus.bed.temp)
                            return
                        pagestack.changeTransition("newPageComesFromInside")
                        pagestack.pushPagestack(
                                    Qt.resolvedUrl(
                                        "controls/ChangeTemperatureBed.qml"))
                    }
                }
            }
        }

        // Bed Height
        Item {
            id: height

            // Label
            DefaultText {
                width: 112 * unitMultiplierX
                height: 24 * unitMultiplierY
                x: 352 * unitMultiplierX
                y: 8 * unitMultiplierY
                text: "Bed Height"
                font.pixelSize: 16
                font.weight: Font.Black
                horizontalAlignment: TextInput.AlignHCenter
            }

            // Bed Height value
            DefaultText {
                width: 112 * unitMultiplierX
                height: 33 * unitMultiplierY
                x: 352 * unitMultiplierX
                y: 32 * unitMultiplierY
                font.weight: Font.Black
                text: getBedHeight()
                font.pixelSize: 24
                horizontalAlignment: TextInput.AlignHCenter
            }
        }
    }


    // Progress Bar
    ProgressBar {
        width: parent.width - 32 // 448
        height: 16
        x: 16 * unitMultiplierX
        y: 104 * unitMultiplierY

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

            // Status information
            Item {

                // Status label
                DefaultText {
                    width: 56 * unitMultiplierX
                    height: 24 * unitMultiplierY
                    x: 16 * unitMultiplierX
                    y: 136 * unitMultiplierY
                    font.pixelSize: 16
                    font.weight: Font.Black
                    text: "Status"
                }

                // Status description
                DefaultText {
                    width: 160 * unitMultiplierX
                    height: 24 * unitMultiplierY
                    x: 80 * unitMultiplierX
                    y: 136 * unitMultiplierY
                    font.pixelSize: 16
                    font.weight: Font.Medium
                    text: getPrinterStatus()
                }
            }

            // Job info
            Item {

                // Job label
                DefaultText {
                    width: 56 * unitMultiplierX
                    height: 24 * unitMultiplierY
                    x: 16 * unitMultiplierX
                    y: 160 * unitMultiplierY
                    font.pixelSize: 16
                    text: "File"
                    font.weight: Font.Black
                }

                // Job description
                DefaultText {
                    width: 160 * unitMultiplierX
                    height: 24 * unitMultiplierY
                    x: 80 * unitMultiplierX
                    y: 160 * unitMultiplierY
                    clip: true
                    font.pixelSize: 16
                    font.weight: Font.Medium
                    text: getPrintJobName()
                }
            }


            // Time information
            Item {

                // Time label
                DefaultText {
                    width: 56 * unitMultiplierX
                    height: 24 * unitMultiplierY
                    x: 16 * unitMultiplierX
                    y: 184 * unitMultiplierY
                    font.pixelSize: 16
                    font.weight: Font.Black
                    text: "Time"
                }

                // Time description
                DefaultText {
                    width: 160 * unitMultiplierX
                    height: 24 * unitMultiplierY
                    x: 80 * unitMultiplierX
                    y: 184 * unitMultiplierY
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
                    x: 266 * unitMultiplierX
                    y: 136 * unitMultiplierY
                    visible: isPrinting()
                    source: isPaused() ? "../../images/icons/dashboard/StartButtonIcon.png" : "../../images/icons/dashboard/PauseButtonIcon.png"
                }

                // Pause/Resume text
                DefaultText {
                    width: 72
                    height: 24
                    x: 248 * unitMultiplierX
                    y: 184 * unitMultiplierY
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 16
                    font.weight: Font.Black
                    visible: isPrinting()
                    text: isPaused() ? "Resume" : "Pause"
                }

                MouseArea {
                    width: 72 * unitMultiplierX
                    height: 88 * unitMultiplierY
                    x: 248 * unitMultiplierX
                    y: 120 * unitMultiplierY
                    onClicked: {
                        if (lock) {
                            pagestack.changeTransition("newPageComesFromUp")
                            pagestack.pushPagestack(
                                        Qt.resolvedUrl(
                                            "../../utils/keyboard/VirtualKeypad.qml"))
                        } else {
                            if (isPrinting()) {
                                if (isPaused()) {
                                    Formide.printer(printerStatus.port).resume()
                                } else {
                                    Formide.printer(printerStatus.port).pause()
                                }
                            } else {

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
                    x: 336 * unitMultiplierX
                    y: 136 * unitMultiplierY
                    source: isPrinting() ? "../../images/icons/dashboard/StopButtonIcon.png" : "../../images/icons/dashboard/QueueButtonIcon.png"
                }

                // Stop text
                DefaultText {
                    width: 72
                    height: 24
                    x: 320 * unitMultiplierX
                    y: 184 * unitMultiplierY
                    font.weight: Font.Black
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 16
                    text: isPrinting() ? "Stop" : "Print"
                }

                MouseArea {
                    width: 72 * unitMultiplierX
                    height: 88 * unitMultiplierY
                    x: 320 * unitMultiplierX
                    y: 120 * unitMultiplierY
                    onClicked: {
                        if (lock) {
                            pagestack.changeTransition("newPageComesFromUp")
                            pagestack.pushPagestack(
                                        Qt.resolvedUrl(
                                            "../../utils/keyboard/VirtualKeypad.qml"))
                        } else {
                            if (isPrinting()) {
                                pagestack.changeTransition(
                                            "newPageComesFromInside")
                                pagestack.pushPagestack(Qt.resolvedUrl(
                                                            "StopConfirm.qml"))
                            } else {
                                pagestack.changeTransition("newPageComesFromInside")
                                pagestack.pushPagestack(Qt.resolvedUrl("PrintConfirmation.qml"))
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
                    x: 408 * unitMultiplierX
                    y: 136 * unitMultiplierY
                    source: isPrinting() ? "../../images/icons/dashboard/TuneIcon.png" : "../../images/icons/dashboard/ControlButtonIcon.png"
                }

                // Tune text
                DefaultText {
                    width: 72
                    height: 24
                    x: 392 * unitMultiplierX
                    y: 184 * unitMultiplierY
                    horizontalAlignment: TextInput.AlignHCenter
                    font.pixelSize: 16
                    font.weight: Font.Black

                    text: isPrinting() ? "Tune" : "Control"
                }

                MouseArea {
                    width: 72 * unitMultiplierX
                    height: 88 * unitMultiplierY
                    x: 392 * unitMultiplierX
                    y: 120 * unitMultiplierY
                    onClicked: {
                        if (lock) {
                            pagestack.changeTransition("newPageComesFromUp")
                            pagestack.pushPagestack(
                                        Qt.resolvedUrl(
                                            "../../utils/keyboard/VirtualKeypad.qml"))
                        } else {
                            if (isPrinting()) {
                                pagestack.changeTransition(
                                            "newPageComesFromDown")
                                pagestack.pushPagestack(
                                            Qt.resolvedUrl("controls/Tune.qml"))
                            } else {
                                pagestack.changeTransition(
                                            "newPageComesFromDown")
                                pagestack.pushPagestack(
                                            Qt.resolvedUrl(
                                                "controls/Controls.qml"))
                            }
                        }
                    }
                }
            }
        }
    }
}
