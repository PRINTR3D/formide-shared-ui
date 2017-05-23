/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../../utils"
import "../../../utils/keyboard"

Item {

    id: calibratePage
    height: parent.height
    width: parent.width

    DefaultText {
        width: 384
        height: 32
        font.pixelSize: 24
        x: 48
        y: 16

        text: "Calibration Finished"
    }

    DefaultText {
        width: 384
        height: 48
        font.pixelSize: 16
        x: 48
        y: 56

        text: "Your 3D printer is successfully calibrated, you can\nstart printing all the models in the world."
    }

    KeyboardLetter {

        width: 280
        height: 48
        x: 100
        y: 120
        letter: "Start Printing"
        backgroundColor: "#46b1e6"
        letterColor: "#ffffff"
        letterSize: 16

        onClicked: {
            console.log("Starting Printing")
        }
    }
}
