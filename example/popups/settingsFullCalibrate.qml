import QtQuick 2.0
import "../utils"

PopupSettingsCalibration {

    id: root

    firstText: "The Full Calibration process will calibrate the Z, X\nand Y-axes of your 3D printer. This process will\nalso level the build plate for best print results."
    secondText: "Make sure the build plate is clear of obstructions!"

    confirmButtonText: "Not implemented"

    fullCalibrationButtonText: "Cancel Full Calibration"

    onConfirmButtonSignal: {

    }

    onCancelButtonSignal: {

    }
}
