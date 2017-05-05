// Controls
import QtQuick 2.0
import "../../../utils"
import "../../../utils/keyboard"

Rectangle {

    id: root
    width: 480
    height: 272

    // Blurry Background
    Image {
        anchors.fill: parent
        source: "../../Images/blurBackground.png"
    }

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
            width: 58
            height: 56.1
            x: 83
            y: 96
            source: "../../Images/icons/Dashboard/Overlays/FlowRateIcon.png"
        }

        KeyboardLetter {
            width: 112
            height: 48
            x: 56
            y: 168
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
            width: 58
            height: 56.1
            x: 212.4
            y: 96
            source: "../../Images/icons/Dashboard/Overlays/PrintSpeedIcon.png"
        }

        KeyboardLetter {
            width: 112
            height: 48
            x: 184
            y: 168
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
            width: 58
            height: 56.1
            x: 340
            y: 96
            source: "../../Images/icons/Dashboard/Overlays/Shape.png"
        }

        KeyboardLetter {
            width: 112
            height: 48
            x: 312
            y: 168
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
