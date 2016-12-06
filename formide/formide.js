
.pragma library

.import "formideAuth.js" as FormideAuth
.import "formideDatabase.js" as FormideDatabase
.import "formidePrinter.js" as FormidePrinter
.import "formideSlicer.js" as FormideSlicer
.import "formideUpdate.js" as FormideAUpdate
.import "formideUsb.js" as FormideUSB
.import "formideWifi.js" as FormideWifi

.import "formideShared.js" as FormideShared

//Qt.include("formideAuth.js");

//Qt.include("formideDatabase.js");
//Qt.include("formidePrinter.js");
//Qt.include("formideSlicer.js");
//Qt.include("formideUpdate.js");
//Qt.include("formideUsb.js");
//Qt.include("formideWifi.js");



// Printer status
var printerStatus=FormideShared.printerStatus
var amountValue=FormideShared.amountValue
var speedValue=FormideShared.speedValue

// Printer status blocked for override
var statusBlocked=FormideShared.statusBlocked

// Formide Data
var materials=FormideShared.materials
var printers=FormideShared.printers
var sliceProfiles=FormideShared.sliceProfiles
var fileItems=FormideShared.fileItems
var queueItems=FormideShared.queueItems
var printJobs=FormideShared.printJobs

// UI Status - general
var initialized=FormideShared.initialized
var loggedIn=FormideShared.loggedIn

// UI password for touch screen
var isLocked=FormideShared.isLocked
var passcode=FormideShared.passcode

// Print Job Status
var uniquePrinter=FormideShared.uniquePrinter
var uniquePrintJob=FormideShared.uniquePrintJob
var currentPrintJobId =FormideShared.currentPrintJobId
var currentPrintJob =FormideShared.currentPrintJob
var currentQueueItemId=FormideShared.currentQueueItemId

// Slice Data
var slicing=FormideShared.slicing
var fileNameSelected=FormideShared.fileNameSelected
var modelFileSelected=FormideShared.modelFileSelected
var materialSelected=FormideShared.materialSelected
var qualitySelected=FormideShared.qualitySelected
var printerSelected=FormideShared.printerSelected

// Error Data - Error messages that will be displayed
var usbError=FormideShared.usbError
var slicerError=FormideShared.slicerError
var queueError=FormideShared.queueError

// USB Data
var driveFiles=FormideShared.driveFiles
var driveListing=FormideShared.driveListing
var drivePath =FormideShared.drivePath
var driveUnit =FormideShared.driveUnit

// Update Data
var updateInformation=FormideShared.updateInformation
var updateAvailable=FormideShared.updateAvailable

// Wi-Fi Data
var ssidToConnect=FormideShared.ssidToConnect
var wifiList=FormideShared.wifiList
var isConnectedToWifi=FormideShared.isConnectedToWifi
var singleNetwork=FormideShared.singleNetwork
var registrationToken=FormideShared.registrationToken
var wifiAction=FormideShared.wifiAction

// Formide-client Data
var currentClientVersion=FormideShared.currentClientVersion
var ipAddress=FormideShared.ipAddress
var macAddress=FormideShared.macAddress


// Intermitent variables
var loadingQueue=FormideShared.loadingQueue


/* MOVE TO BUILDER UI */
/***********************/
// (Keeping it here for now)

// Extruder ratio variables
var leftRatioValue=FormideShared.leftRatioValue
var rightRatioValue=FormideShared.rightRatioValue
var timeoutRatio=FormideShared.timeoutRatio

// Colors
var backgroundColor=FormideShared.backgroundColor
var statusBackgroundColor=FormideShared.statusBackgroundColor
var leftStatusBackgroundColor=FormideShared.leftStatusBackgroundColor
var temperatureColor=FormideShared.temperatureColor
var targetColor=FormideShared.targetColor
var separatorColor=FormideShared.separatorColor

/* MOVE TO FELIX UI */
/*********************/
// (Keeping it here for now)

// Extruder selected for load/unload function
var extruderSelected=FormideShared.extruderSelected

function auth(){
    return FormideAuth.auth();
}

function database(){
    return FormideDatabase.database();
}

function printers(port){
    return FormidePrinter.printer(port);
}

function slice(modelfiles, sliceprofile, materials, printer, callback){
    return FormideSlicer.slice(modelfiles, sliceprofile, materials, printer, callback);
}
