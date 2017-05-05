import QtQuick 2.0
import "../../../lib/formide/formideShared.js" as FormideShared
import "../../utils"

Item {

    id: root

    property var printerStatus:main.printerStatus
    width: 480
    height: 272

    Flickable {
        id: flick
        width: 480
        height: 224
        contentWidth: width
        contentHeight: 402

        property var index: main.settingsIndexSelected

        clip: true

        Component.onCompleted: {
            if (index > 3)
                index = 3
            contentY = 65 * index
        }

        property int currentContentY: 0
        property int targetContentY: 0
        property string targetName

        function animateContentY(target) {
            targetName = target

            main.viewStackActivePage = flick.targetName
        }

        PropertyAnimation {
            id: contentYAnimation
            target: flick
            property: "contentY"
            from: flick.currentContentY
            to: flick.targetContentY
            duration: 200

            onStopped: {
                main.viewStackActivePage = flick.targetName
            }
        }

        SingleListItem {
            y: 8
            name: "About"

            Image {
                width: 48
                height: 48
                x: 24
                y: 8
                source: "../../images/icons/settings/AboutIcon.png"
            }

            onClickedSignal: {
                flick.animateContentY("About")
                main.settingsIndexSelected = 0
            }
        }
        SingleListItem {
            y: 73
            name: "Wi-Fi"

            Image {
                width: 48
                height: 48
                x: 24
                y: 8
                source: "../../images/icons/settings/WiFiIcon.png"
            }

            onClickedSignal: {
                //main.viewStackActivePage="Wi-Fi"
                main.settingsIndexSelected = 1
                flick.animateContentY("Wi-Fi")
            }
        }
        SingleListItem {
            y: 138
            name: "Cloud"

            Image {
                width: 48
                height: 48
                x: 24
                y: 8
                source: "../../images/icons/settings/CloudIcon.png"
            }
            onClickedSignal: {
                main.settingsIndexSelected = 2
                flick.animateContentY("Cloud")
            }
        }
        SingleListItem {

            y: 203
            name: "Update"

            Image {
                width: 48
                height: 48
                x: 24
                y: 8
                source: "../../images/icons/settings/UpdateIcon.png"
            }

            onClickedSignal: {
                main.settingsIndexSelected = 3
                flick.animateContentY("Update")
            }
        }
        SingleListItem {

            y: 268
            name: "Calibration"

            Image {
                width: 48
                height: 48
                x: 24
                y: 8
                source: "../../images/icons/settings/CalibrationIcon.png"
            }

            onClickedSignal: {
                main.settingsIndexSelected = 4
                flick.animateContentY("Calibration")
            }
        }

        SingleListItem {

            y: 333
            name: "Extruders"

            Image {
                width: 48
                height: 48
                x: 24
                y: 8
                source: "../../images/icons/settings/ExtrudersIcon.png"
            }

            onClickedSignal: {

                if (printerStatus.status === "printing"
                        || printerStatus.status === "heating"
                        || printerStatus.status === "paused")
                {
                    pagestack.changeTransition("newPageComesFromInside")
                    pagestack.pushPagestack(Qt.resolvedUrl("extruders/ExtrudersNotAvailable.qml"))
                }

                else
                {
                    main.settingsIndexSelected = 5
                    flick.animateContentY("Extruders")
                    main.replaced = false
                }
            }
        }
    }
}
