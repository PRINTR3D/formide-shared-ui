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
            viewStack.push(Qt.resolvedUrl("Dashboard/Dashboard.qml"))
        else if (viewStackActivePage == "Queue")
            viewStack.push(Qt.resolvedUrl("Queue/Queue.qml"))
        else if (viewStackActivePage == "Print Jobs")
            viewStack.push(Qt.resolvedUrl("PrintJobs/PrintJobs.qml"))
        else if (viewStackActivePage == "Library")
            viewStack.push(Qt.resolvedUrl("Library/Library.qml"))
        else if (viewStackActivePage == "Settings")
            viewStack.push(Qt.resolvedUrl("Settings/Settings.qml"))
        else if (viewStackActivePage == "Wi-Fi")
            viewStack.push(Qt.resolvedUrl("Settings/Wifi/Wi-Fi.qml"))
        else if (viewStackActivePage == "About")
            viewStack.push(Qt.resolvedUrl("Settings/About.qml"))
        else if (viewStackActivePage == "Cloud")
            viewStack.push(Qt.resolvedUrl("Settings/Cloud/Cloud.qml"))
        else if (viewStackActivePage == "Update")
            viewStack.push(Qt.resolvedUrl("Settings/Update/Update.qml"))
        else if (viewStackActivePage == "Update Available")
            viewStack.push(Qt.resolvedUrl(
                               "Settings/Update/UpdateAvailable.qml"))
        else if (viewStackActivePage == "No Update")
            viewStack.push(Qt.resolvedUrl(
                               "Settings/Update/UpdateNotAvailable.qml"))
        else if (viewStackActivePage == "Update Active")
            viewStack.push(Qt.resolvedUrl("Settings/Update/UpdateActive.qml"))
        else if (viewStackActivePage == "Calibration")
            viewStack.push(Qt.resolvedUrl("Settings/Calibration/Calibrate.qml"))
        else if (viewStackActivePage == "Extruders")
            viewStack.push(Qt.resolvedUrl("Settings/Extruders/Extruders.qml"))
        else if (viewStackActivePage == "MaterialPreheat")
            viewStack.push(Qt.resolvedUrl(
                               "Settings/Extruders/MaterialPreheat.qml"))
        else if (viewStackActivePage == "ExtruderReplace")
            viewStack.push(Qt.resolvedUrl(
                               "Settings/Extruders/ExtruderReplace.qml"))
        else if (viewStackActivePage == "ExtruderReplace")
            viewStack.push(Qt.resolvedUrl(
                               "Settings/Extruders/ExtruderReplace.qml"))
        else if (viewStackActivePage == "X and Y Calibration")
            viewStack.push(Qt.resolvedUrl("Popups/settingsCalibrateXY.qml"))
        else if (viewStackActivePage == "Z Calibration")
            viewStack.push(Qt.resolvedUrl("Popups/settingsCalibrateZ.qml"))
        else if (viewStackActivePage == "Bed Calibration")
            viewStack.push(Qt.resolvedUrl("Popups/settingsCalibrateBed.qml"))
        else if (viewStackActivePage == "Full Calibration")
            viewStack.push(Qt.resolvedUrl("Popups/settingsFullCalibrate.qml"))
        else
            viewStack.push(Qt.resolvedUrl("Background.qml"))
    }

    function getAPIcon() {

        if (isHotspot)
            return "Images/icons/Header/Active States/APA.png"
        else
            return "Images/icons/Header/AP.png"
    }

    function getUSBIcon() {

        if (!printerStatus)
            return "Images/icons/Header/USBIcon.png"
        else {
            if (usbAvailable) {
                return "Images/icons/Header/Active States/USBIconA.png"
            } else {
                return "Images/icons/Header/USBIcon.png"
            }
        }
    }

    function getWifiIcon() {

        if (isConnectedToWiFi) {
            return "Images/icons/Header/Active States/WifiIconA.png"
        } else {
            return "Images/icons/Header/WifiIcon.png"
        }
    }

    function getLockIcon() {

        if (!isLocked) {
            return "Images/icons/Header/LockIcon.png"
        } else {
            if (isLocked) {
                return "Images/icons/Header/Active States/LockIconA.png"
            } else {
                return "Images/icons/Header/LockIcon.png"
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
            x: 64
            text: viewStackActivePage
            font.pixelSize: 24
            font.weight: Font.Black
        }

        // AP icon
        Image {
            width: 42
            height: 24
            x: 306
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
            x: 356
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
            x: 403
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
            x: 444
            y: 12
            source: getLockIcon()
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("VirtualKeypad.qml")
                    pagestack.pushPagestack(
                                Qt.resolvedUrl(
                                    "/utils/keyboard/VirtualKeypad.qml"))
                }
            }
        }
    }

    Rectangle {
        id: background
        width: parent.width
        height: 224
        y: 48
        color: "#141414"
    }

    // Second Stack for views under main menu
    StackView {
        id: viewStack
        width: parent.width
        height: 224
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
