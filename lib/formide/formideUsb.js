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
        unmount:function(drive, callback){return unmount(drive,callback)}

    }
}


// Native Implementation
function updateDriveFilesFromPath(driveUnit, drivePath, callback){

    var data=
    {
        "path":drivePath
    }

    var driveNameEncoded = encodeURIComponent(driveUnit);

    HttpHelper.doHttpRequest("GET", "/plugins/com.printr.usb-drive/api/drives/"+driveNameEncoded+"/read", data, function (err, list) {

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

    var driveNameEncoded = encodeURIComponent(drive);

    HttpHelper.doHttpRequest("POST", "/plugins/com.printr.usb-drive/drives/"+driveNameEncoded+"/copy", JSON.stringify(data), function (err, list) {

        if(err)
        {
            callback(err,null)
        }

        if(list)
        {
            callback(null,list);
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

    var driveNameEncoded = encodeURIComponent(drive);

    HttpHelper.doHttpRequest("POST", "/plugins/com.printr.usb-drive/api/drives/"+ driveNameEncoded +"/mount", "", function (err, response) {

        if(err)
        {
            callback(err,null);
        }
        if(response)
        {
            callback(null,response);
        }
    });
}

function unmount(drive,callback) {

    var driveNameEncoded = encodeURIComponent(drive);
    HttpHelper.doHttpRequest("POST", "/plugins/com.printr.usb-drive/api/drives/"+ driveNameEncoded +"/unmount", {}, function (err, response) {

        if(err)
        {
            callback(err,null);
        }
        if(response)
        {
            callback(null,response);
        }

    });

}

