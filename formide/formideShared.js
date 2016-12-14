
.pragma library

//
var sharedUiVersion

// Printer status
var printerStatus={}    // Information about printer status
var flowRateValue=100
var speedMultiplierValue=100

// Printer status blocked for override
var statusBlocked=false

// Formide Data
var materials=[]
var printers=[]
var sliceProfiles=[]
var fileItems=[]
var queueItems=[]
var printJobs=[]

// UI Status - general
var initialized=false       // UI is initialised
var accessToken=''
var loggedIn=false          // UI is authenticated

// UI password for touch screen
var isLocked=false
var passcode

// Print Job Status
var uniquePrinter           // Printer used for slicing
var currentPrintJobId       // Current print job for display
var currentPrintJob         // Current print job for display
var currentQueueItemId      // Current queue item for display

// Slice Data
var slicing= false
var fileNameSelected
var modelFileSelected
var materialSelected
var qualitySelected
var printerSelected

// Error Data - Error messages that will be displayed
var usbError=""
var slicerError=""
var queueError=""

// USB Data
var driveFiles=[]           // Array of files and dirs found
var driveListing            // Toggle to see if content is file list or drive list
var drivePath               // Current folder path
var driveUnit               // Name of drive unit

// Update Data
var updateInformation       // Update information from callback
var updateAvailable=false   // Boolean

// Wi-Fi Data
var ssidToConnect           // Name of network to connect to
var wifiList=[]             // Array of SSIDs
var isConnectedToWifi=false // Boolean
var singleNetwork           // Network currently connected to
var registrationToken=""    // Cloud registration token

// Formide-client Data
var currentClientVersion=""
var ipAddress
var macAddress

/* MOVE TO BUILDER UI */
/***********************/
// (Keeping it here for now)

// Extruder ratio variables
var leftRatioValue=100
var rightRatioValue=0
var timeoutRatio=1000

// Colors
var backgroundColor="#ECECEC"
var statusBackgroundColor="#D2D2D2"
var leftStatusBackgroundColor="#E1E1E1"
var temperatureColor="#6F6E6E"
var targetColor="#8A8A8A"
var separatorColor="#6F6E6E"

/* MOVE TO FELIX UI */
/*********************/
// (Keeping it here for now)

// Extruder selected for load/unload function
var extruderSelected=1
