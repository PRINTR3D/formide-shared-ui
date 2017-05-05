import QtQuick 2.0
import "../../../utils"
import "../../../utils/keyboard"

import "../../../../lib/formide/formide.js" as Formide

Item {

    id: updatePage
    height: parent.height
    width: parent.width

    DefaultText {
        width: 384
        height: 32
        font.pixelSize: 24
        x: 48
        y: 16

        text: "Software Update Available"
    }

    DefaultText {
        width: 384
        height: 72
        font.pixelSize: 16
        x: 48
        y: 56

        //wrapMode: "WordWrap"
        text: "Don't turn off the printer during update. When\nthe update is finished the printer will automatically\nreboot. This may take a few minutes to complete."
    }

    KeyboardLetter {

        width: 280
        height: 48
        x: 100
        y: 144
        letter: "Start Update"
        backgroundColor: "#46b1e6"
        letterColor: "#ffffff"
        letterSize: 16

        onClicked: {
            console.log("Starting software update")
            main.viewStackActivePage = "Update Active"
        }
    }
}
