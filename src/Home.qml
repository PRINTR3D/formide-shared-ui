/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.3
import QtQuick.Controls 1.2
import "utils"
import "../lib/formide/formide.js" as Formide

Item {

    height: parent.height
    width: parent.width

    // Active page can be: dashboard, library, printjobs or settings. For now.
    property var viewStackActivePage: main.viewStackActivePage

    property var isHotspot: main.isHotspot
    property var isConnectedToWiFi: main.isConnectedToWifi
    property var usbAvailable: main.usbAvailable
    property var isLocked: main.isLocked

    Component.onCompleted: {
        changePage()
    }

    onViewStackActivePageChanged: {

        changePage()
    }

    function changePage() {

        viewStack.pop()

        if (viewStackActivePage == "Dashboard")
            viewStack.push(Qt.resolvedUrl("pages/dashboard/Dashboard.qml"))

        else if (viewStackActivePage == "Cloud Queue")
            viewStack.push(Qt.resolvedUrl("pages/queue/Queue.qml"))

        else if (viewStackActivePage == "Library")
            viewStack.push(Qt.resolvedUrl("pages/library/Library.qml"))

        else if (viewStackActivePage == "Settings")
            viewStack.push(Qt.resolvedUrl("pages/settings/Settings.qml"))

        else if (viewStackActivePage == "Wi-Fi")
            viewStack.push(Qt.resolvedUrl("pages/settings/wifi/Wi-Fi.qml"))

        else if (viewStackActivePage == "About")
            viewStack.push(Qt.resolvedUrl("pages/settings/About.qml"))

        else if (viewStackActivePage == "Cloud")
            viewStack.push(Qt.resolvedUrl("pages/settings/cloud/Cloud.qml"))

        else if (viewStackActivePage == "Update")
            viewStack.push(Qt.resolvedUrl("pages/settings/update/Update.qml"))

        else if (viewStackActivePage == "Update Available")
            viewStack.push(Qt.resolvedUrl(
                               "pages/settings/update/UpdateAvailable.qml"))

        else if (viewStackActivePage == "No Update")
            viewStack.push(Qt.resolvedUrl(
                               "pages/settings/update/UpdateNotAvailable.qml"))

        else if (viewStackActivePage == "Update Active")
            viewStack.push(Qt.resolvedUrl("pages/settings/update/UpdateActive.qml"))

        else if (viewStackActivePage == "Calibration")
            viewStack.push(Qt.resolvedUrl("pages/settings/calibration/Calibrate.qml"))

        else if (viewStackActivePage == "Extruders")
            viewStack.push(Qt.resolvedUrl("pages/settings/extruders/Extruders.qml"))

        else if (viewStackActivePage == "MaterialPreheat")
            viewStack.push(Qt.resolvedUrl(
                               "pages/settings/extruders/MaterialPreheat.qml"))

        else if (viewStackActivePage == "ExtruderReplace")
            viewStack.push(Qt.resolvedUrl(
                               "pages/settings/extruders/ExtruderReplace.qml"))

        else if (viewStackActivePage == "ExtruderReplace")
            viewStack.push(Qt.resolvedUrl(
                               "pages/settings/extruders/ExtruderReplace.qml"))

        else if (viewStackActivePage == "X and Y Calibration")
            viewStack.push(Qt.resolvedUrl("popups/settingsCalibrateXY.qml"))

        else if (viewStackActivePage == "Z Calibration")
            viewStack.push(Qt.resolvedUrl("popups/settingsCalibrateZ.qml"))

        else if (viewStackActivePage == "Bed Calibration")
            viewStack.push(Qt.resolvedUrl("popups/settingsCalibrateBed.qml"))

        else if (viewStackActivePage == "Full Calibration")
            viewStack.push(Qt.resolvedUrl("popups/settingsFullCalibrate.qml"))
        else
            viewStack.push(Qt.resolvedUrl("Background.qml"))
    }

    function getAPIcon() {

        if (isHotspot)
            return Qt.resolvedUrl("images/icons/header/Active States/APA.png")
        else
            return Qt.resolvedUrl("images/icons/header/AP.png")
    }

    function getUSBIcon() {

        if (!printerStatus)
            return Qt.resolvedUrl("images/icons/header/USBIcon.png")
        else {
            if (usbAvailable) {
                return Qt.resolvedUrl("images/icons/header/Active States/USBIconA.png")
            } else {
                return Qt.resolvedUrl("images/icons/header/USBIcon.png")
            }
        }
    }

    function getWifiIcon() {

        if (isConnectedToWiFi) {
            return Qt.resolvedUrl("images/icons/header/Active States/WifiIconA.png")
        } else {
            return Qt.resolvedUrl("images/icons/header/WifiIcon.png")
        }
    }

    function getLockIcon() {

        if (!isLocked) {
            return Qt.resolvedUrl("images/icons/header/LockIcon.png")
        } else {
            if (isLocked) {
                return Qt.resolvedUrl("images/icons/header/Active States/LockIconA.png")
            } else {
                return Qt.resolvedUrl("images/icons/header/LockIcon.png")
            }
        }
    }

    // Top bar
    Rectangle {
        width: parent.width
        height: 48
        color: "#0a0a0a"

        HomeIcon {
            type: getType()

            function getType() {
                //                console.log("ActivePage = ",viewStackActivePage)
                if (viewStackActivePage == "Wi-Fi")
                    return "back"
                else if (viewStackActivePage == "About")
                    return "back"
                else if (viewStackActivePage == "Cloud")
                    return "back"
                else if (viewStackActivePage == "Update")
                    return "back"
                else if (viewStackActivePage == "Update Available")
                    return "back"
                else if (viewStackActivePage == "No Update")
                    return "back"
                else if (viewStackActivePage == "Calibration")
                    return "back"
                else if (viewStackActivePage == "Extruders")
                    return "back"
                else if (viewStackActivePage == "MaterialPreheat")
                    return "back"
                else if (viewStackActivePage == "ExtruderReplace")
                    return "back"
                else if (viewStackActivePage == "X and Y Calibration")
                    return "back"
                else if (viewStackActivePage == "Z Calibration")
                    return "back"
                else if (viewStackActivePage == "Bed Calibration")
                    return "back"
                else if (viewStackActivePage == "Full Calibration")
                    return "back"
                else {
                    //                    console.log("Returning home")
                    return "home"
                }
            }

            onHomeClicked: {

                //                console.log("BUTTONSS")
                if (isLocked) {
                    console.log("Locked screen")
                    pagestack.pushPagestack(
                                Qt.resolvedUrl(
                                    "utils/keyboard/VirtualKeypad.qml"))
                } else {

                    if (viewStackActivePage == "Wi-Fi")
                        main.viewStackActivePage = "Settings"
                    else if (viewStackActivePage == "About")
                        main.viewStackActivePage = "Settings"
                    else if (viewStackActivePage == "Cloud")
                        main.viewStackActivePage = "Settings"
                    else if (viewStackActivePage == "Update")
                        main.viewStackActivePage = "Settings"
                    else if (viewStackActivePage == "Update Available")
                        main.viewStackActivePage = "Settings"
                    else if (viewStackActivePage == "No Update")
                        main.viewStackActivePage = "Settings"
                    else if (viewStackActivePage == "Calibration")
                        main.viewStackActivePage = "Settings"
                    else if (viewStackActivePage == "Extruders")
                        main.viewStackActivePage = "Settings"
                    else if (viewStackActivePage == "MaterialPreheat")
                        main.viewStackActivePage = "Extruders"
                    else if (viewStackActivePage == "ExtruderReplace")
                        main.viewStackActivePage = "Settings"
                    else if (viewStackActivePage == "X and Y Calibration")
                        main.viewStackActivePage = "Calibration"
                    else if (viewStackActivePage == "Z Calibration")
                        main.viewStackActivePage = "Calibration"
                    else if (viewStackActivePage == "Bed Calibration")
                        main.viewStackActivePage = "Calibration"
                    else if (viewStackActivePage == "Full Calibration")
                        main.viewStackActivePage = "Calibration"
                    else {
                        pagestack.changeTransition("newPageComesFromDown")
                        pagestack.pushPagestack(Qt.resolvedUrl("Menu.qml"))
                    }
                }
            }
        }

        // Page title
        DefaultText {
            y: 8
            x: 64//parent.width - 416
            text: viewStackActivePage
            font.pixelSize: 24
            font.weight: Font.Black
        }

        // AP icon
        Image {
            width: 42
            height: 24
            x: /*parent.width - 174*/ 306
            y: 12
            source: getAPIcon()
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (isLocked) {
                        console.log("Locked screen")
                        pagestack.pushPagestack(
                                    Qt.resolvedUrl(
                                        "utils/keyboard/VirtualKeypad.qml"))
                    } else {
                        console.log("AP.qml")
                    }
                }
            }
        }

        // USB icon
        Image {
            width: 39
            height: 24
            x: /*parent.width - 124*/ 356
            y: 12
            source: getUSBIcon()
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (isLocked) {
                        console.log("Locked screen")
                        pagestack.changeTransition("newPageComesFromUp")
                        pagestack.pushPagestack(
                                    Qt.resolvedUrl(
                                        "utils/keyboard/VirtualKeypad.qml"))
                    } else {
                        console.log("USB.qml")
                    }
                }
            }
        }

        // Wi-Fi icon
        Image {
            width: 33
            height: 24
            x: /*parent.width - 77*/ 403
            y: 12
            source: getWifiIcon()
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (isLocked) {
                        console.log("Locked screen")
                        pagestack.changeTransition("newPageComesFromUp")
                        pagestack.pushPagestack(
                                    Qt.resolvedUrl(
                                        "utils/keyboard/VirtualKeypad.qml"))
                    } else {
                        console.log("Wifi.qml")
                        pagestack.changeTransition("newPageComesFromInside")
                        main.viewStackActivePage = "Wi-Fi"
                    }
                }
            }
        }


        // Lock icon

        // GOTO: Use Formide Library to get isLocked
        Image {
            width: 20
            height: 24
            x: /*parent.width - 36*/ 444
            y: 12
            source: getLockIcon()
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("VirtualKeypad.qml")
                    pagestack.pushPagestack(
                                Qt.resolvedUrl(
                                    "utils/keyboard/VirtualKeypad.qml"))
                }
            }
        }
    }

    Rectangle {
        id: background
        width: parent.width
        height: parent.height - 48
        y: 48
        color: "#141414"
    }

    // Second Stack for views under main menu
    StackView {
        id: viewStack
        width: parent.width
        height: parent.height - 48
        //x:(parent.width - width)/2
        y: 48

        Component.onCompleted: {
            main.viewStackActivePage = "Dashboard"
        }

        delegate: StackViewDelegate {
            function transitionFinished(properties) {
                properties.exitItem.opacity = 1
            }

            pushTransition: StackViewTransition {
                PropertyAnimation {
                    target: enterItem
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 250
                }
                PropertyAnimation {
                    target: exitItem
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 300
                }
            }
        }
    }
}
