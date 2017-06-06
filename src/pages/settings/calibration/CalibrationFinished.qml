/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../../../utils"

MessagePage {
    id: calibratePage

    firstText: "Calibration Finished" // Text shown as title

    secondText: "Your 3D printer is successfully calibrated, you can start printing all the models in the world"

    confirmButtonText: "Start Printing"

    onConfirmButtonSignal: {
        console.log("Starting Printing")
    }
}
