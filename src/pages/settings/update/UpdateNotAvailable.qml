/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


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
        y: 70

        text: "Your software is up to date."
    }
}
