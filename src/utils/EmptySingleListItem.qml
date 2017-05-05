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
