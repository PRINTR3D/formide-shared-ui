/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../../utils"

Item {
    id: mainLibraryExtended
    height: parent.height
    width: parent.width

    signal fileClicked

    property var singleNetwork: main.singleNetwork
    property var expanded: false
    property var internalIpAddress: main.internalIpAddress
    property var externalIpAddress: main.externalIpAddress
    property var isConnectedToWifi: main.isConnectedToWifi
    property var registrationToken: main.registrationToken
    property var registrationTokenString: ""

    function getIpAddress() {
        if (isConnectedToWifi) {
            return internalIpAddress
        } else {
            return ""
        }
    }

    function getWifiImage() {}

    SingleListItem {
        y: 8

        name: singleNetwork
        wifiActive: true
        fileImagePath: Qt.resolvedUrl("../../../images/icons/header/Active States/WifiIconA.png")

        MouseArea {
            anchors.fill: parent
            onClicked: {
                fileClicked.call()
            }
        }
    }

    DefaultText {
        width: 442
        height: 24
        x: 22
        y: 89
        font.pixelSize: 16
        lineHeight: 1.5
        horizontalAlignment: TextInput.AlignHCenter
        text: "Pair 3D printer with Formide through a verification code"
    }

    PushButton {
        x: 132
        y: 129
        buttonText: "Generate Code"

        backgroundColor: "#46b1e6"
        textColor: "#ffffff"

        onClicked: {
            // Expand a bit and Generate Code
            expanded = true

            main.getRegistrationToken(function (err, response) {
                if (err) {
                    expanded = false
                    pagestack.changeTransition("newPageComesFromInside")
                    pagestack.pushPagestack(Qt.resolvedUrl(
                                                "../cloud/CloudError.qml"))
                }
                if (response) {
                    registrationTokenString = registrationToken
                }
            })
        }
    }

    // 5 Digit Code
    Item {
        visible: expanded

        Rectangle {
            color: "#1F1F1F"
            border.color: "#ffffff"
            border.width: 2
            radius: 3
            width: 72
            height: 72
            x: 44
            y: 193

            DefaultText {
                anchors.centerIn: parent
                font.pixelSize: 48
                color: "#ffffff"
                text: registrationTokenString.substr(0, 1)
            }
        }

        Rectangle {
            color: "#1F1F1F"
            border.color: "#ffffff"
            border.width: 2
            radius: 3
            width: 72
            height: 72
            x: 124
            y: 193

            DefaultText {
                anchors.centerIn: parent
                font.pixelSize: 48
                color: "#ffffff"
                text: registrationTokenString.substr(1, 1)
            }
        }

        Rectangle {
            color: "#1F1F1F"
            border.color: "#ffffff"
            border.width: 2
            radius: 3
            width: 72
            height: 72
            x: 204
            y: 193

            DefaultText {
                anchors.centerIn: parent
                font.pixelSize: 48
                color: "#ffffff"
                text: registrationTokenString.substr(2, 1)
            }
        }

        Rectangle {
            color: "#1F1F1F"
            border.color: "#ffffff"
            border.width: 2
            radius: 3
            width: 72
            height: 72
            x: 284
            y: 193

            DefaultText {
                anchors.centerIn: parent
                font.pixelSize: 48
                color: "#ffffff"
                text: registrationTokenString.substr(3, 1)
            }
        }

        Rectangle {
            color: "#1F1F1F"
            border.color: "#ffffff"
            border.width: 2
            radius: 3
            width: 72
            height: 72
            x: 364
            y: 193

            DefaultText {
                anchors.centerIn: parent
                font.pixelSize: 48
                color: "#ffffff"
                text: registrationTokenString.substr(4, 1)
            }
        }
    }

    Item {
        id: movingBlock
        y: expanded ? 88 : 0

        // Separator
        Rectangle {
            width: parent.width - 32
            height: 1
            x: 16
            y: 193
            color: "#d8d8d8"
        }

        DefaultText {
            width: 442
            height: 24
            x: 22
            y: 210
            font.pixelSize: 16
            lineHeight: 1.5
            horizontalAlignment: TextInput.AlignHCenter
            text: "Print via the cloud at"
        }

        DefaultText {
            width: 442
            height: 24
            x: 22
            y: 242
            font.pixelSize: 16
            lineHeight: 1.5
            horizontalAlignment: TextInput.AlignHCenter
            text: "www.formide.com"
        }

        // Separator
        Rectangle {
            width: parent.width - 32
            height: 1
            x: 16
            y: 282
            color: "#d8d8d8"
        }

        DefaultText {
            width: 442
            height: 24
            x: 22
            y: 299
            font.pixelSize: 16
            lineHeight: 1.5
            horizontalAlignment: TextInput.AlignHCenter
            text: "Print via local network at"
        }

        DefaultText {
            width: 442
            height: 24
            x: 22
            y: 331
            font.pixelSize: 16
            lineHeight: 1.5
            horizontalAlignment: TextInput.AlignHCenter
            text: getIpAddress()
        }
    }
}
