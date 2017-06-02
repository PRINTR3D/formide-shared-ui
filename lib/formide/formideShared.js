/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */

.pragma library

/*********************
  SHARED VARIABLES
  ********************/

// Used IP
//var backendIP = "127.0.0.1" // For production, we use Localhost
var backendIP = "10.0.1.4" // Sometimes, for development, we use the IP of an Element

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
var fileIndexSelected=0;

// Extruder pages
var extruderSelected=0;
var temperature;
var replaced=false;
