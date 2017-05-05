import QtQuick 2.0
import "../fonts"

Text {

    font.family: webFont.name
    font.pixelSize: 14
    color: "#ffffff"

    FontLoader {
        id: webFont
        source: "../fonts/OpenSans-Regular.ttf"
    }
}
