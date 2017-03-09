
.pragma library

/*********************
  SHARED VARIABLES
  ********************/

// Used IP
var backendIP = "127.0.0.1" // For production, we use Localhost
//var backendIP = "10.1.0.59" // Sometimes, for development, we use the IP of an Element

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

// Extruder pages
var extruderSelected=0;
var temperature;
var replaced=false;
