/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "../utils"

PopupSettingsCalibration {

    id: root

    firstText: "The Full Calibration process will calibrate the Z, X\nand Y-axes of your 3D printer. This process will\nalso level the build plate for best print results."
    secondText: "Make sure the build plate is clear of obstructions!"

    confirmButtonText: "Not implemented"

    fullCalibrationButtonText: "Cancel"

    onConfirmButtonSignal: {

    }

    onCancelButtonSignal: {
        main.viewStackActivePage = "Settings"
    }
}
