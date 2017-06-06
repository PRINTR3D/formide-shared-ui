/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


import QtQuick 2.0
import "../../../utils"

import "../../../../lib/formide/formide.js" as Formide

Item {

    id: updatePage
    height: parent.height
    width: parent.width

    MessageWindow {
        id: wifiMessage

        visible: !checking

        firstText: "Your software is up to date" // Text shown as title

        centerText: true

        confirmButton: false // Showing confirm button
    }

}
