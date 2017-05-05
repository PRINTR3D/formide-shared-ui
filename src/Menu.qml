import QtQuick 2.0
import "utils"
import "../lib/formide"
import "../lib/formide/formideShared.js" as FormideShared

Item {

    width: 480
    height: 272

    // Blurry Background
    Image {
        anchors.fill: parent
        source: "images/blurBackground.png"
    }

    // Home Icon
    HomeIcon {
        type: "quit"
        onHomeClicked: pagestack.popPagestack()
    }

    MenuItem {
        x: 44
        y: 48
        label: "Dashboard"
        Image {
            width: 72
            height: 72
            source: "images/icons/menu/DashboardIcon.png"
        }

        onClicked: {
            pagestack.popPagestack()
            main.viewStackActivePage = "Dashboard"
        }
    }

    MenuItem {
        x: 124
        y: 48
        label: "Library"
        Image {
            width: 72
            height: 72
            source: "images/icons/menu/LibraryIcon.png"
        }

        onClicked: {
            pagestack.popPagestack()
            main.viewStackActivePage = "Library"
        }
    }

    MenuItem {
        x: 204
        y: 48
        label: "Queue"
        Image {
            width: 72
            height: 72
            source: "images/icons/menu/QueueIcon.png"
        }

        onClicked: {
            pagestack.popPagestack()
            main.viewStackActivePage = "Queue"
        }
    }

    MenuItem {
        x: 284
        y: 48
        label: "Settings"
        Image {
            width: 72
            height: 72
            source: "images/icons/menu/SettingsIcon.png"
        }

        onClicked: {
            main.settingsIndexSelected = 0
            main.viewStackActivePage = "Settings"
            pagestack.popPagestack()
        }
    }
}
