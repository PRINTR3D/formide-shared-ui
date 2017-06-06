/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


// Controls
import QtQuick 2.0
import "../../../"
import "../../../utils"
import "../../../utils/keyboard"

Rectangle {

    id: root
    width: parent.width
    height: parent.height

    // Background
    Background{}

    // Home icon
    HomeIcon {
        type: "quit"
        onHomeClicked: pagestack.popPagestack()
    }

    // Flow Rate
    Item {

        // FlowRate Label
        DefaultText {
            width: 106
            height: 24
            x: 59
            y: 56
            horizontalAlignment: TextInput.AlignHCenter
            font.pixelSize: 16

            text: "Flow Rate"
        }

        // FlowRate icon
        Image {
            width: 56
            height: 56
            x: 83
            y: 96
            source: "../../../images/icons/overlays/FlowRateIcon.png"
        }

        KeyboardLetter {
            width: 112
            height: 48
            x: 56
            y: 172
            letter: "Change"

            backgroundColor: "#46b1e6"
            letterColor: "#ffffff"
            letterSize: 16

            onClicked: {
                pagestack.changeTransition("newPageComesFromInside")
                pagestack.pushPagestack(Qt.resolvedUrl("ChangeFlowRate.qml"))
            }
        }
    }

    // Print Speed
    Item {

        // PrintSpeed Label
        DefaultText {
            width: 106
            height: 24
            x: 187
            y: 56
            horizontalAlignment: TextInput.AlignHCenter
            font.pixelSize: 16

            text: "Print Speed"
        }

        // PrintSpeed icon
        Image {
            width: 56
            height: 56
            x: 212.4
            y: 96
            source: "../../../images/icons/overlays/PrintSpeedIcon.png"
        }

        KeyboardLetter {
            width: 112
            height: 48
            x: 184
            y: 172
            letter: "Change"

            backgroundColor: "#46b1e6"
            letterColor: "#ffffff"
            letterSize: 16

            onClicked: {
                pagestack.changeTransition("newPageComesFromInside")
                pagestack.pushPagestack(Qt.resolvedUrl("ChangePrintSpeed.qml"))
            }
        }
    }

    // Fan Speed
    Item {

        // Fan Label
        DefaultText {
            width: 106
            height: 24
            x: 315
            y: 56
            horizontalAlignment: TextInput.AlignHCenter
            font.pixelSize: 16

            text: "Fan Speed"
        }

        // Fan icon
        Image {
            width: 56
            height: 56
            x: 340
            y: 96
            source: "../../../images/icons/overlays/FanSpeedIcon.png"
        }

        KeyboardLetter {
            width: 112
            height: 48
            x: 312
            y: 172
            letter: "Change"

            backgroundColor: "#46b1e6"
            letterColor: "#ffffff"
            letterSize: 16

            onClicked: {
                pagestack.changeTransition("newPageComesFromInside")
                pagestack.pushPagestack(Qt.resolvedUrl("ChangeFanSpeed.qml"))
            }
        }
    }
}
