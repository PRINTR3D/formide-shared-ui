/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.3
import QtQuick.Controls 1.2
import "utils"
import "../lib/formide/formide.js" as Formide
import "../lib/formide/formideShared.js" as FormideShared

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

        else if (viewStackActivePage == "Access Point")
            viewStack.push(Qt.resolvedUrl("pages/settings/accesspoint/AccessPoint.qml"))

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

        else if (viewStackActivePage == "Material Preheat")
            viewStack.push(Qt.resolvedUrl(
                               "pages/settings/extruders/MaterialPreheat.qml"))

        else if (viewStackActivePage == "Extruder Replace")
            viewStack.push(Qt.resolvedUrl(
                               "pages/settings/extruders/ExtruderReplace.qml"))

        else if (viewStackActivePage == "Extruder Replace")
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

        else if (viewStackActivePage == "USB Drives")
            viewStack.push(Qt.resolvedUrl("pages/usb/USB.qml"))

        else if (viewStackActivePage == "USB Drive")
            viewStack.push(Qt.resolvedUrl("pages/usb/USBDrive.qml"))

        else
            viewStack.push(Qt.resolvedUrl("Background.qml"))
    }

    function getPageTitle(){
        if(viewStackActivePage == "No Update")
            return "Update"
        if(viewStackActivePage == "Update Available")
            return "Update"
        else
            return viewStackActivePage
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
        height: 50
        color: "#000000"

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
                else if (viewStackActivePage == "Access Point")
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
                else if (viewStackActivePage == "Material Preheat")
                    return "back"
                else if (viewStackActivePage == "Extruder Replace")
                    return "back"
                else if (viewStackActivePage == "X and Y Calibration")
                    return "back"
                else if (viewStackActivePage == "Z Calibration")
                    return "back"
                else if (viewStackActivePage == "Bed Calibration")
                    return "back"
                else if (viewStackActivePage == "Full Calibration")
                    return "back"
                else if (viewStackActivePage == "USB Drive")
                    return "back"
                else {
                    //                    console.log("Returning home")
                    return "home"
                }
            }

            onHomeClicked: {

                if (isLocked) {
                    pagestack.changeTransition("newPageComesFromDown")
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
                    else if (viewStackActivePage == "Access Point")
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
                    else if (viewStackActivePage == "Material Preheat")
                        main.viewStackActivePage = "Extruders"

                    else if (viewStackActivePage == "Extruder Replace") {
                        // cool extruder
                        Formide.printer(printerStatus.port).gcode(
                                            "M104 T" + FormideShared.extruderSelected + " S0")

                        main.viewStackActivePage = "Settings"
                    }

                    else if (viewStackActivePage == "X and Y Calibration")
                        main.viewStackActivePage = "Calibration"
                    else if (viewStackActivePage == "Z Calibration")
                        main.viewStackActivePage = "Calibration"
                    else if (viewStackActivePage == "Bed Calibration")
                        main.viewStackActivePage = "Calibration"
                    else if (viewStackActivePage == "Full Calibration")
                        main.viewStackActivePage = "Calibration"

                    else if (viewStackActivePage == "USB Drive"){
                        if(main.drivePath.length > 1){
                            main.drivePath.pop()
                            main.updateDriveFilesFromPath()
                        }
                        else{
                            main.scanDrives(function(){
                                main.viewStackActivePage = "USB Drives"
                            })
                        }
                    }

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
            text: getPageTitle()
            font.pixelSize: 24
            font.weight: Font.Black
        }


        // USB icon
        Image {
            width: 34
            height: 24
            x: parent.width - (34 + 24 + 34 + 24 + 20 + 16)
            y: 12
            source: getUSBIcon()
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (isLocked) {
                        pagestack.changeTransition("newPageComesFromUp")
                        pagestack.pushPagestack(
                                    Qt.resolvedUrl(
                                        "utils/keyboard/VirtualKeypad.qml"))
                    } else {
                        main.viewStackActivePage = "USB Drives"
                    }
                }
            }
        }

        // Wi-Fi icon
        Image {
            width: 34
            height: 24
            x: parent.width - (34 + 24 + 20 + 16)
            y: 12
            source: getWifiIcon()
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (isLocked) {
                        pagestack.changeTransition("newPageComesFromUp")
                        pagestack.pushPagestack(
                                    Qt.resolvedUrl(
                                        "utils/keyboard/VirtualKeypad.qml"))
                    } else {
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
            x: parent.width - (20 + 16)
            y: 12
            source: getLockIcon()
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (isLocked) {
                        pagestack.changeTransition("newPageComesFromUp")
                    } else {
                        pagestack.changeTransition("newPageComesFromDown")
                    }

                    pagestack.pushPagestack(
                                Qt.resolvedUrl(
                                    "utils/keyboard/VirtualKeypad.qml"))
                }
            }
        }
    }

    Background{
        y:50
    }

    // Second Stack for views under main menu
    StackView {
        id: viewStack
        width: parent.width
        height: parent.height - 50
        y: 50

        Component.onCompleted: {
            main.viewStackActivePage = "Dashboard"
        }

        delegate: StackViewDelegate {
            pushTransition: StackViewTransition {}
        }
    }
}
