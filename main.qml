//    ___  ___      _
//    |  \/  |     (_)
//    | .  . | __ _ _ _ __
//    | |\/| |/ _` | | '_ \
//    | |  | | (_| | | | | |
//    \_|  |_/\__,_|_|_| |_|
//


import QtQuick 2.3
import QtQuick.Controls 1.2

import "formide/formide.js" as Formide

FormideNativeUi {

    id:main
    visible: true
    title: qsTr("Formide Native UI")

    Label {
        text: "Please build a beautiful UI"
        anchors.centerIn: parent
    }
}
