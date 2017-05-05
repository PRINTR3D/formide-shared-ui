import QtQuick 2.0
import "../../../utils"
import "../../../utils/keyboard"

import "../../../../lib/formide/formide.js" as Formide

Item {

    id: updatePage
    height: parent.height
    width: parent.width

    DefaultText {
        width: 318
        height: 32
        font.pixelSize: 24
        x: 81
        y: 24

        text: "Restarting..."
    }

    Component.onCompleted: {
        main.updateElement()
    }
}
