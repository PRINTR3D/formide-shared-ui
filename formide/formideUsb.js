//    _    _  _____ ____
//   | |  | |/ ____|  _ \
//   | |  | | (___ | |_) |
//   | |  | |\___ \|  _ <
//   | |__| |____) | |_) |
//    \____/|_____/|____/
//
//


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

/*************
 NATIVE IMPLEMENTATION
 ************/

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

