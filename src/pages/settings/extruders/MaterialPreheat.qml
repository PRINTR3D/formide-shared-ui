import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "../../../utils"
import "../../../../lib/formide/formideShared.js" as FormideShared
import "../../../../lib/formide/formide.js" as Formide

Item {

    width: 480
    height: 272
    id: materialPreheatPage

    property bool visibleHomeIcon: true

    property var extruderSelected: FormideShared.extruderSelected

    property var plaTemperature: 190
    property var absTemperature: 240
    property var petTemperature: 220
    property var wfTemperature: 200
    property var npa6Temperature: 200
    property var blTemperature: 200
    property var lw3Temperature: 200
    property var nfTemperature: 200
    property var ewcTemperature: 200
    property var pfTemperature: 200

    // Blurry Background
    Image {
        anchors.fill: parent
        source: "../../Images/blurBackground.png"
    }

    HomeIcon {
        visible: visibleHomeIcon
        type: "quit"
        onHomeClicked: {
            main.replaced = false
            pagestack.popPagestack()
        }
    }

    DefaultText {
        x: 48
        y: 48
        font.pixelSize: 24
        //font.bold: true
        font.weight: Font.Medium

        text: "Choose Material for preheat"
    }

    Row {
        spacing: 8
        x: 48
        y: 96
        Image {
            width: 72
            height: 72
            source: "../../Images/icons/Settings/PLA.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("PLA")
                    FormideShared.temperature = plaTemperature
                    main.replaced = true
                    pagestack.popPagestack()
                }
            }
        }
        Image {
            width: 72
            height: 72
            source: "../../Images/icons/Settings/ABS.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("PLA")
                    FormideShared.temperature = plaTemperature
                    main.replaced = true
                    pagestack.popPagestack()
                }
            }
        }
        Image {
            width: 72
            height: 72
            source: "../../Images/icons/Settings/PET.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("PLA")
                    FormideShared.temperature = plaTemperature
                    main.replaced = true
                    pagestack.popPagestack()
                }
            }
        }
        Image {
            width: 72
            height: 72
            source: "../../Images/icons/Settings/WF.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("PLA")
                    FormideShared.temperature = plaTemperature
                    main.replaced = true
                    pagestack.popPagestack()
                }
            }
        }
        Image {
            width: 72
            height: 72
            source: "../../Images/icons/Settings/NPA6.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("PLA")
                    FormideShared.temperature = plaTemperature
                    main.replaced = true
                    pagestack.popPagestack()
                }
            }
        }
    }

    Row {
        spacing: 8
        x: 48
        y: 176
        Image {
            width: 72
            height: 72
            source: "../../Images/icons/Settings/BL.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("PLA")
                    FormideShared.temperature = plaTemperature
                    main.replaced = true
                    pagestack.popPagestack()
                }
            }
        }
        Image {
            width: 72
            height: 72
            source: "../../Images/icons/Settings/LW3.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("PLA")
                    FormideShared.temperature = plaTemperature
                    main.replaced = true
                    pagestack.popPagestack()
                }
            }
        }
        Image {
            width: 72
            height: 72
            source: "../../Images/icons/Settings/NF.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("PLA")
                    FormideShared.temperature = plaTemperature
                    main.replaced = true
                    pagestack.popPagestack()
                }
            }
        }
        Image {
            width: 72
            height: 72
            source: "../../Images/icons/Settings/EWC.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("PLA")
                    FormideShared.temperature = plaTemperature
                    main.replaced = true
                    pagestack.popPagestack()
                }
            }
        }
        Image {
            width: 72
            height: 72
            source: "../../Images/icons/Settings/PF.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("PLA")
                    FormideShared.temperature = plaTemperature
                    main.replaced = true
                    pagestack.popPagestack()
                }
            }
        }
    }
}
