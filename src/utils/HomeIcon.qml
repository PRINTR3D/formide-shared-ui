/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0


// Home icon
Item {
    width: 80
    height: 48

    signal homeClicked

    property string type: "home"

    function getImage() {
        if (type === "home") {
            return Qt.resolvedUrl("../images/icons/header/MenuButton.png")
        }

        if (type === "quit") {
            return Qt.resolvedUrl("../images/icons/overlays/CloseButton.png")
        }
        if (type === "back") {
            return Qt.resolvedUrl("../images/icons/header/BackButton.png")
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
