/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


import QtQuick 2.0
import "../../../utils"
import "../../../../lib/formide"
import "../../../../lib/formide/formideShared.js" as FormideShared

Item {

    id: mainLibrary
    height: parent.height
    width: parent.width

    property var isConnectedToWifi: main.isConnectedToWifi

    function getImage() {
        return Qt.resolvedUrl("../../../images/icons/noIcon.png")
    }

    Component.onCompleted: {
        main.getWifiList()
        main.resetCheckConnections()
        main.checkConnection()
    }

    Timer {
        id: checkEverythingTimer
        running: true
        repeat: true
        interval: 15000
        onTriggered: {
            main.getWifiList()
        }
    }

    FileList {

        id: list
        visible: main.wifiList.length > 0

        type: "wifi"
        property var fileIndexSelected
        listModel: main.wifiList //["Flare & Talent","HP-Print-5E-Officejet Pro 8610","ICON-18c8ea","KK60-EWH","KK65-Guest","KPN-VGV7519C175EB","LAF Boven","PARKEAGLE","printr","printr-guest","The-Element-7514f7"]

        onItemSelected: {

            console.log("Wi-Fi selected: " + listModel[indexSelected])
            FormideShared.ssidToConnect = listModel[indexSelected]

            pagestack.changeTransition("newPageComesFromInside")

            if (name === main.singleNetwork)
                pagestack.pushPagestack(Qt.resolvedUrl("WifiReset.qml"))
            else
                pagestack.pushPagestack(Qt.resolvedUrl("WifiKeyboard.qml"))
        }
    }

    MessageWindow {
        id: emptyList

        visible: main.wifiList.length == 0

        firstText: "No Wi-Fi networks found" // Text shown as title

        centerText: true

        confirmButton: false // Showing confirm button
    }

}
