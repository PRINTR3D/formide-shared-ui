/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../../utils"

Item {

    id: calibratePage

    height: parent.height
    width: parent.width

    Item {
        width: parent.width
        height: parent.height - 48

        DefaultText {
            x: 92
            y: 24

            font.pixelSize: 24
            text: "Full or Partial Calibration"
        }

        PushButton {
            x: 16
            y: 73
            buttonText: "Full Calibration"
            inputDisabled: main.inputDisabled

            onButtonClicked: {
                main.viewStackActivePage = "Full Calibration"
            }
        }

        PushButton {
            x: 16
            y: 129
            buttonText: "Calibrate Bed"
            inputDisabled: main.inputDisabled

            onButtonClicked: {
                main.viewStackActivePage = "Bed Calibration"
            }
        }

        PushButton {
            x: 248
            y: 73
            buttonText: "Calibrate Z Axis"
            inputDisabled: main.inputDisabled

            onButtonClicked: {
                main.viewStackActivePage = "Z Calibration"
            }
        }

        PushButton {
            x: 248
            y: 129
            buttonText: "Calibrate X and Y Axes"
            inputDisabled: main.inputDisabled

            onButtonClicked: {
                main.viewStackActivePage = "X and Y Calibration"
                //calibratePage.parent.push(Qt.resolvedUrl("ChangeXYaxes.qml"))
            }
        }
    }
}
