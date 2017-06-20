/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


import QtQuick 2.0
import "../../"
import "../../utils"

Flickable {

    width: parent.width
    height: parent.height -48
    clip: true

    contentWidth: width
    contentHeight: height +48

    property var macAddress: main.macAddress
    property var singleNetwork: main.singleNetwork
    property var externalIpAddress: main.externalIpAddress
    property var internalIpAddress: main.internalIpAddress
    property var currentClientVersion: main.currentClientVersion
    property var printerStatus: main.printerStatus
    property var totalSpace: main.totalSpace
    property var freeSpace: main.freeSpace


    Component.onCompleted: {
        main.checkStorage()
    }

    function getFirmwareName() {
        if (printerStatus) {
            if (printerStatus.firmware) {
                if (printerStatus.firmware.name) {
                    return printerStatus.firmware.name
                }
            }
        }
        return "Unknown"
    }

    function getMacAddress() {
        if (macAddress) {
            return macAddress
        } else {
            return "Unknown"
        }
    }

    function getCurrentVersion() {
        if (currentClientVersion) {
            return currentClientVersion
        } else {
            return "Unknown"
        }
    }

    Rectangle {
        id: about
        width: parent.width
        height: 344

        Background{}

        Image {
            width: 72
            height: 72
            x: 24
            y: 16

            source: "../../images/icons/PrintrIcon.png"
        }

        DefaultText {
            width: 144
            height: 216
            font.pixelSize: 16
            //font.weight: Font.Medium
            x: 112
            y: 16
            color: "#ffffff"

            lineHeightMode: Text.FixedHeight
            lineHeight: 25

            text: "Network\nCapacity\nAvailable\nOS\nUI Version\nClient Version\nFirmware Version\nMAC Address"
        }

        DefaultText {
            width: 144
            height: 216
            font.pixelSize: 16
            x: 265
            y: 16
            color: "#ffffff"

            lineHeightMode: Text.FixedHeight
            lineHeight: 25

            text: singleNetwork+"\n"+totalSpace+" GB\n"+freeSpace+" GB\nFormide Linux\n" + "1.0.1" + "\n" + getCurrentVersion(
                      ) + "\n" + getFirmwareName() + "\n" + getMacAddress()
        }
    }
}
