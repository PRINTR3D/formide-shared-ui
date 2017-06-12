/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

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
