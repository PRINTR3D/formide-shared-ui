/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../../utils"
import "../../../utils/keyboard"
import "../../../../lib/formide/formideShared.js" as FormideShared
import "../../../../lib/formide/formide.js" as Formide

Item {

    id: apPage

    height: parent.height
    width: parent.width

    property var isHotspot: main.isHotspot
    property var macAddress: main.macAddress


    function getAPname(){
        if(macAddress)
            return "The-Element-" + macAddress.slice(-8).replace(/:/g, '')
        else
            return ""
    }

    DefaultText {
        y: 32
        horizontalAlignment: TextInput.AlignHCenter
        width: 448
        x: 16
        height: 33

        font.pixelSize: 18
        text: "Access point name:  " + getAPname()
    }

    DefaultText {
        y: 80
        horizontalAlignment: TextInput.AlignHCenter
        width: 448
        x: 16
        height: 33

        font.pixelSize: 18
        text: isHotspot ? "Disable to no longer emit Wi-Fi" : "Enable to emit Printer's Wi-Fi"
    }

    KeyboardLetter {
        width: 216
        height: 48
        x:132
        y:128

        letter: isHotspot ? "Disable" : "Enable"

        backgroundColor: "#46b1e6"
        letterColor: "white"
        letterSize: 16

        onClicked: {
            pagestack.changeTransition("newPageComesFromInside")

            main.hotspot(!isHotspot,
                        function (err, response) {
                            if (err) {
                                pagestack.popPagestack()
                                pagestack.pushPagestack(Qt.resolvedUrl("AccessPointError.qml"))
                            }
                            else {
                                pagestack.popPagestack()
                                main.viewStackActivePage = "Settings"
                            }
                        })

            if (isHotspot)
                pagestack.pushPagestack(Qt.resolvedUrl("AccessPointDisabling.qml"))
            else
                pagestack.pushPagestack(Qt.resolvedUrl("AccessPointEnabling.qml"))
        }
    }
}
