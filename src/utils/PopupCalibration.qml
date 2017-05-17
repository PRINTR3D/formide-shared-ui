import QtQuick 2.0

Item {
    id: root

    width: 480
    height: 272

    property var firstText: "" // Text shown as title
    property var secondText: "" // Text shown in subtitle

    property var confirmButtonText: "" // Text shown on cancel button

    property bool progressBarSignal: true // Showing Progress Bar

    property bool confirmButton: true // Showing confirm button

    property bool showExitIcon: true // Showing Home Icon

    signal confirmButtonSignal
    // Event emitted when pressing confirm

    // Blurry Background
    Image {
        anchors.fill: parent
        source: "../images/blurBackground.jpg"
    }

    // Home icon
    HomeIcon {
        type: "quit"
        onHomeClicked: root.parent.pop()
    }

    DefaultText {

        width: 392
        height: 30
        x: 44
        y: 32
        font.family: "OpenSans"
        font.pixelSize: 20
        lineHeightMode: Text.FixedHeight
        lineHeight: 1.5
        color: "#ffffff"

        text: firstText
    }

    Text {
        width: 392
        height: 22
        x: 44
        y: 157

        font.family: "OpenSans"
        font.pixelSize: 14
        lineHeightMode: Text.FixedHeight
        lineHeight: 1.14
        color: "#ffffff"

        text: secondText
    }

    ProgressBar {
        visible: progressBarSignal
        width: 392
        height: 15
        //radius: 3
        x: 44
        y: 129
    }

    Rectangle {
        visible: confirmButton
        x: 164
        y: 195

        width: 152
        height: 50
        radius: 3
        color: "#46b1e6"

        Text {
            font.family: "OpenSans"
            font.pixelSize: 14
            anchors.centerIn: parent
            color: "#ffffff"
            text: confirmButtonText
        }

        MouseArea {

            anchors.fill: parent
            onClicked: {
                confirmButtonSignal.call()
            }
        }
    }
}
