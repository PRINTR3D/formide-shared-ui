/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

import QtQuick 2.0
import "utils"
import "../lib/formide"
import "../lib/formide/formideShared.js" as FormideShared

Item {

    width: parent.width
    height: parent.height

    Background{
        y:0
    }

    // Home Icon
    HomeIcon {
        type: "quit"
        onHomeClicked: pagestack.popPagestack()
    }

    MenuItem {
        x: 44
        y: 56
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
        y: 56
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
        y: 56
        label: "Cloud Queue"
        Image {
            width: 72
            height: 72
            source: "images/icons/menu/QueueIcon.png"
        }

        onClicked: {
            pagestack.popPagestack()
            main.viewStackActivePage = "Cloud Queue"
        }
    }

    MenuItem {
        x: 284
        y: 56
        label: "USB Drive"
        Image {
            width: 72
            height: 72
            source: "images/icons/menu/USBIcon.png"
        }

        onClicked: {
            main.viewStackActivePage = "USB Drives"
            pagestack.popPagestack()
        }
    }

    MenuItem {
        x: 364
        y: 56
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
