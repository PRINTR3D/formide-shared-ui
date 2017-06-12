/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0

SingleListItem {
    id: files
    name: "Empty"
    arrowImagePath: ""
    fileImagePath: ""
    textSize: 24
    y: 0
    wifi: getWifi()

    visible: status === "list"

    function getWifi() {
        if (type === "wifi")
            return true
        else
            return false
    }
}
