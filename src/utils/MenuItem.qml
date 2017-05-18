/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0

MouseArea {

    width: 72
    height: 72 + 4 + 20
    property var label

    Rectangle {
        width: 72
        height: 72
        radius: 3
    }

    DefaultText {

        width: 72
        height: 20
        y: 76
        font.pixelSize: 12
        horizontalAlignment: TextInput.AlignHCenter
        lineHeight: 1.67

        text: label
    }
}
