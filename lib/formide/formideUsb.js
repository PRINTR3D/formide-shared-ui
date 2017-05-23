/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


.pragma library
// Includes
.import "Http.js" as HttpHelper
.import "formideShared.js" as Formide


function usb(){
    return{

        // New
        scanDrives:function(callback){return scanDrives(callback)},
        updateDriveFilesFromPath:function(drive, path, callback){return updateDriveFilesFromPath(drive, path, callback);},
        copyFile:function(drive, path, callback){return copyFile(drive, path, callback)},
        mount:function(drive, callback){return mount(drive,callback)},
        unmount:function(drive, callback){return unmount(drive,callback)},
        enableUsbEvents:function(callback){return enableUsbEvents(callback)},
        switchUsbMode:function(target,callback){return switchUsbMode(target,callback)}


    }
}

function switchUsbMode (target,callback){

    var mode = {
        "mode":target
    }

    HttpHelper.doHttpRequest("POST","/api/printer/control_mode",JSON.stringify(mode),function(err, response){

        if(err)
        {
            console.log("Error (formide.js) switch usb mode: ",err)
            callback(err,null)
        }
        if(response)
        {
            console.log("Response (formide.js) switch usb mode: ",response)
            callback(null,JSON.parse(response))
        }

    });
}

// Enable usb events
function enableUsbEvents (callback){

    HttpHelper.doHttpRequest("POST","/api/printer/control_mode/enable",JSON.stringify({}),function(err, response){

        if(err)
        {
            console.log("Error (formide.js) enable usb events: ",err)
            callback(err,null)
        }
        if(response)
        {
            console.log("Response (formide.js) enable usb events: ",response)
            callback(null,JSON.parse(response))
        }

    });
}


// Native Implementation
function updateDriveFilesFromPath(driveUnit, drivePath, callback){

    var data=
    {
        "path":drivePath
    }

    var res = encodeURIComponent(driveUnit);

    HttpHelper.doHttpRequest("GET", "/plugins/com.printr.usb-drive/api/drives/"+res+"/read", data, function (err, list) {

        if(err)
        {
            callback(err,null);
        }
        if(list)
        {
            callback(null,list);
        }
    });
}

function copyFile(drive, path, callback) {

    //console.log("Copying file to FORMIDE");

    var data=
    {
        "path":path
    }

    var res = encodeURIComponent(drive);

    HttpHelper.doHttpRequest("POST", "/plugins/com.printr.usb-drive/drives/"+res+"/copy", JSON.stringify(data), function (err, list) {

        if(err)
        {
            callback(err,null)
        }

        if(list)
        {
            callback(null,JSON.parse(list));
        }

    });

}

function scanDrives(callback) {

    //console.log("Scanning drives");
    HttpHelper.doHttpRequest("GET", "/plugins/com.printr.usb-drive/api/drives", {}, function (err, list) {

        if(err)
        {
            callback(err,null)
        }
        if(list)
        {
            callback(null,list)
        }

    });

}

function mount(drive,callback) {

    //console.log("Mounting drive");


    var res = encodeURIComponent(drive);
    HttpHelper.doHttpRequest("POST", "/plugins/com.printr.usb-drive/api/drives/"+ res +"/mount", "", function (err, response) {

        if(err)
        {
            callback(err,null);
        }
        if(response)
        {
            callback(null,JSON.parse(response));
        }
    });
}

function unmount(drive,callback) {

    //console.log("Unmounting drive");
    var res = encodeURIComponent(drive);
    HttpHelper.doHttpRequest("POST", "/plugins/com.printr.usb-drive/api/drives/"+ res +"/unmount", {}, function (err, response) {

        if(err)
        {
            callback(err,null);
        }
        if(response)
        {
            callback(JSON.parse(response));
        }

    });

}
