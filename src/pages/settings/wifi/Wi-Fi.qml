import QtQuick 2.0
import "../../../utils"
import "../../../../lib/formide"
import "../../../../lib/formide/formideShared.js" as FormideShared

Item {

    id: mainLibrary
    height: parent.height
    width: parent.width

    property var isConnectedToWifi: main.isConnectedToWifi

    function getImage() {
        return "../../Images/icons/noIcon.png"
    }

    Component.onCompleted: {
        main.checkConnection()
    }

    FileList {

        id: list

        type: "wifi"
        property var fileIndexSelected
        listModel: main.wifiList //["Flare & Talent","HP-Print-5E-Officejet Pro 8610","ICON-18c8ea","KK60-EWH","KK65-Guest","KPN-VGV7519C175EB","LAF Boven","PARKEAGLE","printr","printr-guest","The-Element-7514f7"]

        onItemSelected: {

            console.log("Wi-Fi selected: " + listModel[indexSelected])
            FormideShared.ssidToConnect = listModel[indexSelected]

            if (name === main.singleNetwork)
                main.viewStackActivePage = "Cloud"
            else
                pagestack.pushPagestack(Qt.resolvedUrl("WifiKeyboard.qml"))
        }
    }
}
