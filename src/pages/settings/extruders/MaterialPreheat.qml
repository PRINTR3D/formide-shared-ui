/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "../../../"
import "../../../utils"
import "../../../../lib/formide/formideShared.js" as FormideShared
import "../../../../lib/formide/formide.js" as Formide

Item {

    width: parent.width
    height: parent.height
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


    function setTemperature (){
        Formide.printer(printerStatus.port).gcode(
                            "M104 T" + FormideShared.extruderSelected + " S" + FormideShared.temperature)
        pagestack.popPagestack()
        pagestack.pushPagestack(Qt.resolvedUrl("ExtruderHeating.qml"))
        main.viewStackActivePage = "Extruder Replace"
    }

    // Background
    Background{
        y:0
    }

    HomeIcon {
        visible: visibleHomeIcon
        type: "quit"
        onHomeClicked: {
            pagestack.popPagestack()
        }
    }

    DefaultText {
        x: 48
        y: 48
        font.pixelSize: 24
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
            source: "../../../images/icons/settings/PLA.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {

                    FormideShared.temperature = plaTemperature

                    setTemperature()
                }
            }
        }
        Image {
            width: 72
            height: 72
            source: "../../../images/icons/settings/ABS.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {

                    FormideShared.temperature = absTemperature

                    setTemperature()
                }
            }
        }
        Image {
            width: 72
            height: 72
            source: "../../../images/icons/settings/PET.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {

                    FormideShared.temperature = petTemperature

                    setTemperature()
                }
            }
        }
        Image {
            width: 72
            height: 72
            source: "../../../images/icons/settings/WF.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {

                    FormideShared.temperature = wfTemperature

                    setTemperature()
                }
            }
        }
        Image {
            width: 72
            height: 72
            source: "../../../images/icons/settings/NPA6.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {

                    FormideShared.temperature = npa6Temperature

                    setTemperature()
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
            source: "../../../images/icons/settings/BL.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {

                    FormideShared.temperature = blTemperature

                    setTemperature()
                }
            }
        }
        Image {
            width: 72
            height: 72
            source: "../../../images/icons/settings/LW3.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {

                    FormideShared.temperature = lw3Temperature

                    setTemperature()
                }
            }
        }
        Image {
            width: 72
            height: 72
            source: "../../../images/icons/settings/NF.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {

                    FormideShared.temperature = nfTemperature

                    setTemperature()
                }
            }
        }
        Image {
            width: 72
            height: 72
            source: "../../../images/icons/settings/EWC.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {

                    FormideShared.temperature = ewcTemperature

                    setTemperature()
                }
            }
        }
        Image {
            width: 72
            height: 72
            source: "../../../images/icons/settings/PF.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {

                    FormideShared.temperature = pfTemperature

                    setTemperature()
                }
            }
        }
    }
}
