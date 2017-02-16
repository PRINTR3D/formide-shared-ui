
.pragma library

/*********************
  SHARED VARIABLES
  ********************/

// Used IP
var backendIP = "127.0.0.1" // For production, we use Localhost
//var backendIP = "10.0.1.69" // Sometimes, for development, we use the IP of an Element

var accessToken;

// Temperature change confirmation
var newE1Temperature;
var newE2Temperature;
var newBedTemperature;

// Tune variables
var newFlowRate;
var newSpeedMultiplier;
var newFanSpeed;

// Wi-Fi variables
var ssidToConnect;

// Index variables
var fileIndexSelected;


/**********************
    MOVE TO FELIX UI
/*********************/
// (Keeping it here for now)

// Extruder selected for load/unload function
var extruderSelected=1
