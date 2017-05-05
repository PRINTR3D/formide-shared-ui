import QtQuick 2.0


// Home icon
Item {
    width: 80
    height: 48

    signal homeClicked

    property string type: "home"

    function getImage() {
        if (type === "home") {
            return "../Images/icons/Header/HomeButtonIn.png"
        }

        if (type === "quit") {
            return "../Images/icons/Dashboard/Overlays/HomeButtonOut.png"
        }
        if (type === "back") {
            return "../Images/gif/backarrow.png"
        }
    }

    Image {
        width: 34
        height: 34
        x: 16
        y: 8
        source: getImage()
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            homeClicked.call()
        }
    }
}
