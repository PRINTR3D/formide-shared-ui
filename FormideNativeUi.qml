
//    ______ ____  _____  __  __ _____ _____  ______
//   |  ____/ __ \|  __ \|  \/  |_   _|  __ \|  ____|
//   | |__ | |  | | |__) | \  / | | | | |  | | |__
//   |  __|| |  | |  _  /| |\/| | | | | |  | |  __|
//   | |   | |__| | | \ \| |  | |_| |_| |__| | |____
//   |_|    \____/|_|  \_|_|  |_|_____|_____/|______|
//    _   _       _______ _______      ________   _    _ _____
//   | \ | |   /\|__   __|_   _\ \    / |  ____| | |  | |_   _|
//   |  \| |  /  \  | |    | |  \ \  / /| |__    | |  | | | |
//   | . ` | / /\ \ | |    | |   \ \/ / |  __|   | |  | | | |
//   | |\  |/ ____ \| |   _| |_   \  /  | |____  | |__| |_| |_
//   |_| \_/_/    \_|_|  |_____|   \/   |______|  \____/|_____|


import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import Qt.WebSockets 1.0

import "formide/formide.js" as Formide
import "formide/formideShared.js" as FormideShared

Window {
    visible: true
    width: 480
    height: 272

    /************************************
            MAIN VARIABLES
             ************************************/

    // Events - Signals we can emit (different printers have different behavior)
    signal printerFinished
    signal printerStarted
    signal printerStopped
    signal printerPaused
    signal printerResumed

    signal printerConnected
    signal printerOnline
    signal printerDisconnected

    // UI
    property var backendIP: FormideShared.backendIP
    property var sharedUiVersion: "v1.0.0"

    // Printer status
    property var printerStatus
    // Information about printer status
    property var flowRateValue: 100
    property var speedMultiplierValue: 100

    // Formide Data
    property var printers: []
    property var fileItems: []
    property var queueItems: []
    property bool loadingQueue: false

    // UI Status - general
    property var initialized: false // UI is initialised
    property var loggedIn: false // UI is authenticated

    // UI password for touch screen
    property var isLocked: false
    property var passcode

    // Print Job Status
    property var uniquePrinter
    // Printer used for slicing
    property var currentQueueItemId
    // Current queue item for display
    property var currentQueueItemName

    // Error Data - Error messages that will be displayed
    property var usbError: ""
    property var queueError: ""

    // USB Data
    property var usbAvailable: false
    property var driveFiles: [] // Array of files and dirs found
    property var driveListing
    // Toggle to see if content is file list or drive list
    property var drivePath
    // Current folder path
    property var driveUnit
    // Name of drive unit

    // Update Data
    property var updateInformation
    // Update information from callback
    property var updateAvailable: false // Boolean

    // Wi-Fi Data
    property var ssidToConnect

    // Name of network to connect to
    property var wifiList: [] // Array of SSIDs
    property var isConnectedToWifi: false // Boolean
    property var isHotspot: false
    property var singleNetwork: "" // Network currently connected to
    property var registrationToken: "12345" // Cloud registration token

    // Formide-client Data
    property var currentClientVersion: ""
    property var internalIpAddress
    property var externalIpAddress
    property var macAddress

    // Extruder ratio variables
    property var leftRatioValue: 100
    property var rightRatioValue: 0
    property var timeoutRatio: 1000
    property var oneSecond: 1000
    // Printer status blocked for override
    property var statusBlocked: false

    // Colors
    property var backgroundColor: "#ECECEC"
    property var statusBackgroundColor: "#D2D2D2"
    property var leftStatusBackgroundColor: "#E1E1E1"
    property var temperatureColor: "#6F6E6E"
    property var targetColor: "#8A8A8A"
    property var separatorColor: "#6F6E6E"

    // Extruder selected for load/unload function
    property var extruderSelected: 1

    /************************************
         MAIN LOGIC - General
         ************************************/

    // Run at boot
    Component.onCompleted: {
        login()
        macAddress = mySystem.msg("fiw wlan0 mac")
    }


    /************************************
         MAIN LOGIC - Auth
         ************************************/
    function login() {
        Formide.auth().login('admin@local', 'admin', function (callback) {

            if (callback == true) {
                if (Formide.auth().getAccessToken().length > 29) {
                    console.log("Login completed")
                    loginTimer.repeat = false
                    loginTimer.stop()

                    loggedIn = true

                    // Check if this is optimal
                    getCurrentClientVersion()
                    getFiles()


                    //                    scanDrives()
                    sock.active = true
                }
            }
        })
    }

    function getPrinters() {
        Formide.printer().list(function (err, printrs) {
            if (err) {
                console.log("Error getting printers: ", JSON.stringify(err))
            }
            if (printrs) {
                //console.log("Response get printers",JSON.stringify(printers))
                printers = printrs

                // In this piece of code we make sure that the printer selected
                // and used in this UI is the one connected and online
                for (var i in printers) {

                    if (printers[i] !== undefined
                            && printerStatus !== undefined)
                        if (printers[i].port === printerStatus.port) {
                            uniquePrinter = printers[i]
                        }
                }
            }
        })
    }


    /************************************
         MAIN LOGIC - STORAGE
         ************************************/
    function getFiles() {
        Formide.storage().list(function (err, files) {
            if (err) {
                console.log("Error getting files", JSON.stringify(err))
            }
            if (files) {
                //console.log("Response get files",JSON.stringify(files));
                fileItems = files
            }
        })
    }

    function removeFile(path) {
        Formide.storage().remove(path, function (err, response) {
            if (err) {
                console.log("Error deleting file", JSON.stringify(err))
            }
            if (response) {
                //                console.log('Response deleting file', JSON.stringify(response))

                // After deleting a file, we fetch them again
                getFiles()
            }
        })
    }


    /************************************
         MAIN LOGIC - Printer
         ************************************/
    function getQueue() {
        checkEverythingTimer.restart()
        if (!printerStatus) {
            return
        }

        loadingQueue = true
        Formide.printer(printerStatus.port).getQueue(function (err, response) {

            if (err) {
                console.log("Error loading queue", JSON.stringify(err))
                loadingQueue = false
            }
            if (response) {
                //               console.log("Response get queue",JSON.stringify(response));
                for (var i in response) {
                    if (response[i].id === currentQueueItemId) {
                        currentQueueItemName=response[i].printJob.name
                        break
                    }
                }

                loadingQueue = false

                // Update queue items
                queueItems = response.filter(function (queueItem) {
                    if (queueItem.status == "queued")
                        return queueItem
                })
            }
        })
    }

    function startPrintFromQueueId(queueId, gcode, callback) {

        Formide.printer(printerStatus.port).start(queueId, gcode,
                                                  function (err, response) {
                                                      if (err) {
                                                          console.log("Error starting a print",
                                                                      JSON.stringify(
                                                                          err))
                                                          if (callback)
                                                              callback(err,
                                                                       null)
                                                      }
                                                      if (response) {
                                                          //              console.log("Response starting a print",JSON.stringify(response))
                                                          if (callback)
                                                              callback(null,
                                                                       response)
                                                      }
                                                  })
    }

    function startPrintFromFileSystem(filePath, callback) {
        Formide.printer(printerStatus.port).printFileFromFileSystem(
                    filePath, function (err, response) {
                        if (err) {
                            console.log("Error printing a file from file system",
                                        JSON.stringify(err))
                            if (callback)
                                callback(err, null)
                        }
                        if (response) {
                            //              console.log("Response print a file from file system",JSON.stringify(response))
                            if (callback)
                                callback(null, response)
                        }
                    })
    }


    /************************************
         MAIN LOGIC - Update
         ************************************/
    function checkUpdate(callback) {
        Formide.update().checkUpdate(function (err, response) {

            if (err) {
                console.log("Response ERR check updates ", JSON.stringify(err))
                callback(false)
            }
            if (response) {
                console.log("Response ", JSON.stringify(response))
                if (response.needsUpdate) {
                    updateInformation = response
                    updateAvailable = true
                    callback(true)
                } else {
                    console.log("No update needed")
                    updateAvailable = false
                    callback(false)
                }

                //{"message":"There is no update available at this moment","needsUpdate":false}

                //{"message":"update found","needsUpdate":true,"signature":"D0S4ZyJ3eN4mp3K1dSwxCr/FzJS7uV7ekA9yf+yKnTvROp2tt3uhWYTo1V/dcOsJda0lSnC0pwwmULCBMqgRd5mxK5HYNMyQDCDYfwcO7MeN2idTnx/8lxe0WtK3brJ0RMKEtRdGkqKMxxV9Mj0pVJURYNGcygAP0oiQ57hdy8oBEUDE1yqLijZcEcPZoALZGfBujFxdaQiWdS1IaGQsD2m2crjQq5Kh7XyeDX3+Nzin3yLnLEFzb2yYlBy/HDtt69LnWF3Sv3Dpr88hodHYV1EVJ4vnYf6IPE/bRBAgvkAUx+ZcB8N8dkU3tb4alFpgTdaDC2tcMtEqDh1L9YExybjh4wvoTxN3RiHy1dg0U99qHSp5N+i9eP7uu9CkX8KlbfTSI6zreaYuBv62eyjqRDRqsiptW1IWYGDCEUSfvZpoeZNT7Kc1LsukMX3hcXffMnsmrrAK0XJDgfL8gk80PBS1/VcZrsddo7CEv7QtQntq5lbnKmDgGAqIUfUltqFsWxdTw0ngIweY0u8616yWzu0pyGZd3B0E2PDc3YrLNf348kcED8eO0TKsJ6twcB/vGfPZfkHjZ/ZQTOIf+gNAVh1MMOcOGZ+z0se9CHb+jHdbZz8JEnz9g/zLrekzSc5mU9rIQb9nIQe6SiBDGKfIv0tIiG/QAHqzTDj/KvW7nTM=","version":"1.3.6-387","flavour":"standalone"}
            }
        })
    }

    function status() {

        Formide.update().status(function (err, response) {

            if (err) {
                console.log("Error cloud status", JSON.stringify(err))
            }
            if (response) {
                console.log("Response cloud status", JSON.stringify(response))
            }
        })
    }

    function updateElement(callback) {
        Formide.update().updateElement(function (err, response) {

            if (err) {
                console.log("Error Update Element", JSON.stringify(err))
                if (callback) {
                    callback(err, null)
                }
            }
            if (response) {
                //           console.log('Response Update Element', JSON.stringify(response))
                if (callback)
                    callback(null, response)
            }
        })
    }

    function getCurrentClientVersion() {

        Formide.system().info(function (err, response) {

            if (err) {
                console.log("Error System info", JSON.stringify(err))
            }
            if (response) {
                console.log("Response System info", JSON.stringify(response))
                currentClientVersion = response.version
            }
        })
    }

    function getCurrentUpdateVersion() {
        Formide.update().current(function (err, response) {

            if (err) {
                console.log("Error Cloud Current", JSON.stringify(err))
            }
            if (response) {
                console.log("Response Cloud current", JSON.stringify(response))
                currentClientVersion = response.version
            }
        })
    }


    /************************************
         MAIN LOGIC - USB
         ************************************/
    function scanDrives(callback) {
        Formide.usb().scanDrives(function (err, list) {

            if (err) {
                console.log("Error scanning drives: ", JSON.stringify(err))
                if (callback)
                    callback(err, null)
            }
            if (list) {
                //console.log("Response scanning drives: ",JSON.stringify(list));
                if (list.length > 0 && list[0] !== "platform-musb*part*") {
                    //console.log("Updating drives list: ",list)
                    if (!usbAvailable)
                        usbAvailable = true
                    driveFiles = list
                } else {
                    //console.log("Not updating drive")
                    if (usbAvailable) {
                        usbAvailable = false
                        driveFiles = []
                    }
                }
                if (callback)
                    callback(null, list)
            }
        })
    }

    function updateDriveFilesFromPath(callback) {
        Formide.usb().updateDriveFilesFromPath(driveUnit, drivePath,
                                               function (err, list) {

                                                   if (err) {
                                                       console.log("Error reading drive: ",
                                                                   JSON.stringify(
                                                                       err))
                                                       if (callback)
                                                           callback(err, null)
                                                   }
                                                   if (list) {
                                                       driveListing = 0

                                                       driveFiles = list.filter(
                                                                   function (file) {
                                                                       if (file.name) {
                                                                           if (file.name.toLowerCase().indexO(".gcode") !== -1 || file.name.toLowerCase().indexOf(".stl") !== -1 || file.type == "dir")
                                                                               return file
                                                                       }
                                                                   })

                                                       if (callback)
                                                           callback(null, list)
                                                   }
                                               })
    }

    function copyFile(callback) {
        Formide.usb().copyFile(driveUnit, drivePath, function (err, list) {

            if (err) {
                console.log("Response ERR: ", JSON.stringify(err))

                usbError = err.message

                if (callback)
                    callback(err, null)
            }

            if (list) {

                //console.log("Response OK: ",JSON.stringify(list))
                if (callback)
                    callback(null, list)
            }
        })
    }

    function updateDriveUnit(driveU, callback) {
        driveUnit = driveU
        Formide.usb().mount(driveUnit, function (err, response) {
            if (err) {
                console.log("Error mounting drive: ", JSON.stringify(err))
                if (callback)
                    callback(err, null)
            }
            if (response) {
                //console.log("Response mounting drive: ",JSON.stringify(response));
                if (response.message == "drive mounted") {
                    updateDriveFilesFromPath(callback)
                }
            }
        })
    }

    function unMountDrive(drive, callback) {
        Formide.usb().unmount(drive, function (err, response) {

            if (err) {
                console.log("Response from unmounting: ", JSON.stringify(err))
                if (callback)
                    callback(err, null)
            }
            if (response) {
                //console.log("Response from unmounting: ",JSON.stringify(response))
                if (callback)
                    callback(null, response)
            }
        })
    }


    /************************************
         MAIN LOGIC - Wi-Fi
         ************************************/
    function getRegistrationToken(callback) {
        Formide.system().getRegistrationCode(function (err, response) {
            if (err) {
                console.log("Error registraton token", JSON.stringify(err))
                if (callback)
                    callback(err, null)
            }
            if (response) {
                console.log("Response registration token",
                            JSON.stringify(response))
                registrationToken = response.code.toString()

                if (callback)
                    callback(null, response)
            }
        })
    }

    function checkConnection(callback) {
        Formide.wifi().checkConnection(function (err, response) {

            if (err) {
                console.log("Error checking connection", JSON.stringify(err))
                isConnectedToWifi = false
                internalIpAddress = "Unknown"
                externalIpAddress = "Unknown"
                singleNetwork = ""
                isHotspot = false
                if (callback)
                    callback(err, null)

                wifiTimer.restart()
                getWifiList()
            }
            if (response) {
                if (response.isConnected) {

                    isConnectedToWifi = response.isConnected
                    externalIpAddress = response.publicIp
                    internalIpAddress = response.ip
                    singleNetwork = response.network
                } else {
                    isConnectedToWifi = false
                    internalIpAddress = "Unknown"
                    externalIpAddress = "Unknown"
                    singleNetwork = ""
                }

                if (callback)
                    callback(null, response)

                isHotspot = response.isHotspot

                //console.log("Response checking connection",JSON.stringify(response));
            }
        })
    }

    function getWifiList() {

        Formide.wifi().getList(function (err, list) {

            if (err) {
                console.log("Error getting Wi-Fi list", JSON.stringify(err))
            }

            if (list) {
                console.log("Found " + list.length + " networks")
                wifiList = list
            }
        })
    }

    function reset(callback) {
        Formide.wifi().reset(function (err, response) {

            if (err) {
                console.log("Error reset", JSON.stringify(err))
                if (callback)
                    callback(err, null)
            }
            if (response) {
                //console.log('Response reset', JSON.stringify(response))
                checkConnection()
                singleNetwork = ""
                wifiList = []

                if (callback)
                    callback(null, response)
            }
        })
    }

    function hotspot(enabled, callback) {
        Formide.wifi().hotspot(enabled, function (err, response) {

            if (err) {
                console.log("Error hotspot", JSON.stringify(err))
                if (callback)
                    callback(err, null)
            }
            if (response) {
                //console.log('Response hotspot', JSON.stringify(response))
                checkConnection()

                if (callback)
                    callback(null, response)
            }
        })
    }

    // Check: Maybe we don't need to call it here
    function connectToWifi(ssid, password, callback) {

        Formide.wifi().connect(ssid, password, function (err, response) {

            if (err) {
                console.log("Error connecting to Wi-Fi", JSON.stringify(err))
                checkConnection()
                if (callback)
                    callback(err, null)
            }
            if (response) {
                console.log("Response connecting to network",
                            JSON.stringify(response))
                checkConnection()
                if (callback)
                    callback(null, response)
            }
        })
    }


    /************************************
         WEBSOCKET EVENTS
         ************************************/
    WebSocket {
        active: false

        function socketLogin() {
            console.log("Socket login")
            console.log("Token: ", Formide.auth().getAccessToken())
            sock.sendTextMessage(JSON.stringify({
                                                    channel: "authenticate",
                                                    data: {
                                                        type: "user",
                                                        accessToken: /*savedAccessToken*/ Formide.auth(
                                                                         ).getAccessToken()
                                                    }
                                                }))
        }
        id: sock
        url: "ws://" + backendIP + ":3001"

        onTextMessageReceived: {
            try {
                var data = JSON.parse(message)

                //console.log("received event: " + JSON.stringify(data.channel));

                // For each socket event, we emit a signal, so we can add the implementation
                // outside the library
                if (data.channel === "printer.stopped") {
                    printerStopped(data.data)
                }

                if (data.channel === "printer.started") {
                    printerStarted(data.data)
                }

                if (data.channel === "printer.connected") {
                    printerConnected(data.data)
                }
                if (data.channel === "printer.disconnected") {
                    printerDisconnected(data.data)
                }

                if (data.channel === "printer.status") {
//                    console.log(JSON.stringify(data.data))

                    if (data.data.port === "/dev/virt0") {
                        //                        console.log("Virtual printer return")
                        return
                    }

                    // Only use printer status after printer is Online
                    if (data.data.status !== "connecting"
                            && data.data.status !== "disconnected") {

                        // Make sure printer status has temperature
                        if (data.data.extruders[0].temp > 0) {
                            printerStatus = data.data

                            // If the app is not initialized, we initialize it and get the current client version
                            if (!initialized && loggedIn) {
                                initialized = true

                                getQueue()
                                getFiles()
                                getPrinters()
                            }

                            // If printer is printing, print job id needs to be updated
                            if (data.data.status === "printing"
                                    || data.data.status === "heating"
                                    || data.data.status === "paused") {
                                //                          console.log("currentprintjob: "+currentPrintJob)
                                if (currentQueueItemId !== data.data.queueItemId) {
                                    currentQueueItemId = data.data.queueItemId

                                    console.log("Current queue item id updated: "
                                                + currentQueueItemId)

                                    getQueue()
                                }
                            }
                        }
                    }
                }
            } catch (e) {

                //console.log(e);
            }
        }
        onStatusChanged: {
            console.log("onStatusChanged")
            if (sock.status == WebSocket.Error) {
                console.log(qsTr("Client error: %1").arg(sock.errorString))
            } else if (sock.status == WebSocket.Closed) {
                console.log(qsTr("Client socket closed."))
            } else if (sock.status == WebSocket.Open) {
                console.log("Socket open")
                socketLogin()
            } else {
                console.log("websocket status: " + sock.status)
            }
        }
    }


    /************************************
         TIMERS
         ************************************/
    // note
    // /!\ Printer specific timers need to be implemented out of here, in main.qml
    function touchInput() {
        checkEverythingTimer.restart()
        wifiTimer.restart()
    }

    // Timer to check queue, print jobs and files
    Timer {
        id: checkEverythingTimer
        running: true
        repeat: true
        interval: oneSecond * 15
        onTriggered: {

            if (printerStatus)
                if (printerStatus.status === "online") {
                    getFiles()
                    getQueue()
                }
        }
    }

    Timer {
        id: updateEverythingTimer
        running: false
        repeat: false
        interval: 5000
        onTriggered: {

            getFiles()
            getQueue()
        }
    }

    // Timer for printer status override (Builder specific - move out of here)
    Timer {
        id: statusBlockedTimer
        running: false
        repeat: false
        interval: oneSecond * 5
        onTriggered: {
            statusBlocked = false
        }
    }

    // Timer to check Wi-Fi status
    Timer {
        id: wifiTimer
        interval: 15000
        repeat: true
        running: true
        onTriggered: {
            if (printerStatus)
                if (printerStatus.status === "online"
                        || printerStatus.status === "printing"
                        || printerStatus.status === "heating"
                        || printerStatus.status === "paused") {
                    console.log("Wi-Fi Checking")
                    getWifiList()
                    checkConnection()
                    //                    waiting for client 2: scanDrives() // To check if there are usb connected
                }
        }
    }

    // Initial loop to login in. It stops after connecting with Formide.
    Timer {
        id: loginTimer
        interval: 20000
        repeat: true
        running: true

        onTriggered: {
            console.log("Connecting")
            if (Formide.auth().accesstoken.length < 30)
                login()
            else {
                loginTimer.repeat = false
                loginTimer.running = false
                loginTimer.stop()
            }
        }
    }
}
