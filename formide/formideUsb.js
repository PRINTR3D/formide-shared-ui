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

        // Need callback implementation
        updateDriveFilesFromPath:function(callback){return updateDriveFilesFromPath(callback);},
//        updateDriveUnit:function(driveU,callback){return updateDriveUnit(driveU,callback)},
        copyFile:function(callback){return copyFile(callback)},
        scanDrives:function(callback){return scanDrives(callback)},

        // Update var values
//        updateDrivePath:function(driveP){return updateDrivePath(driveP);},
//        updateDriveListing:function(i){return updateDriveListing(i)}

        // Mount has private implementation
        //mount:function(drive,callback){return mount(drive,callback)}

    }
}

/*********************
 LIBRARY IMPLEMENTATION
 **********************/

//// Update drive path to read files
//function updateDrivePath(driveP){
//    Formide.drivePath=driveP;
//}

//// Update drive listing
//function updateDriveListing(i){
//    Formide.driveListing=i;
//}


/*************
 NATIVE IMPLEMENTATION
 ************/

function updateDriveFilesFromPath(driveUnit, drivePath, callback){

    var data=
    {
        "path":drivePath
    }

    var res = encodeURIComponent(driveUnit);

    HttpHelper.doHttpRequest("GET", "/api/files/read/"+res, data, function (err, list) {

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

    HttpHelper.doHttpRequest("POST", "/api/files/copy/"+res, JSON.stringify(data), function (err, list) {

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

//function updateDriveUnit(driveU,callback){
//    Formide.driveUnit=driveU;

//    mount(driveU,function(err,response){
//        if(err)
//        {
//            callback(err,null);
//        }
//        if(response)
//        {
//            callback(null,response)
//        }
//    });
//}

function scanDrives(callback) {

    //console.log("Scanning drives");
    HttpHelper.doHttpRequest("GET", "/api/files/drives", {}, function (err, list) {

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
    HttpHelper.doHttpRequest("POST", "/api/files/mount/"+res, "", function (err, response) {

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
    HttpHelper.doHttpRequest("POST", "/api/files/unmount/"+drive, {}, function (err, response) {

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

