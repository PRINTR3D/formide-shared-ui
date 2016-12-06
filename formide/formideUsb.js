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
        updateDriveUnit:function(driveU,callback){return updateDriveUnit(driveU,callback)},
        copyFile:function(callback){return copyFile(callback)},
        scanDrives:function(callback){return scanDrives(callback)},

        // Update var values
        updateDrivePath:function(driveP){return updateDrivePath(driveP);},
        updateDriveListing:function(i){return updateDriveListing(i)}

        // Mount has private implementation
        //mount:function(drive,callback){return mount(drive,callback)}

    }
}

/*************
 LIBRARY IMPLEMENTATION
 ************/

// Update drive path to read files
function updateDrivePath(driveP){
    Formide.drivePath=driveP;
}

// Update drive listing
function updateDriveListing(i){
    Formide.driveListing=i;
}


/*************
 NATIVE IMPLEMENTATION
 ************/

function updateDriveFilesFromPath(callback){

    var driveUnit=Formide.driveUnit
    var drivePath=Formide.drivePath

    var data=
    {
        "path":drivePath
    }

    var res = encodeURIComponent(driveUnit);

    HttpHelper.doHttpRequest("GET", "/api/files/read/"+res, data, function (err, list) {


        if(err)
        {
            console.log("Error reading drive: ",err);
            callback(err,null);
        }
        if(list)
        {
            Formide.driveListing=0;

            Formide.driveFiles=list.filter(function(file) {
                if (file.name)
                {
                    if(file.name.toLowerCase().indexO(".gcode") !== -1 || file.name.toLowerCase().indexOf(".stl") !== -1 || file.type=="dir")
                        return file;
                }
            });
            callback(null,list);
        }
    });
}

function copyFile(callback) {

    var drive = Formide.driveUnit;
    var path = Formide.drivePath;

    console.log("Copying file to FORMIDE");

    var data=
    {
        "path":path
    }

    var res = encodeURIComponent(drive);

    HttpHelper.doHttpRequest("POST", "/api/files/copy/"+res, JSON.stringify(data), function (err, list) {

        if(err)
        {
            //console.log("Response ERR: ",JSON.stringify(err));

            Formide.usbError=err.message
            callback(err,null)
        }

        if(list)
        {
            //console.log("Response OK: ",list)
            callback(null,JSON.parse(list));
        }

    });

}

function updateDriveUnit(driveU,callback){
    Formide.driveUnit=driveU;

    mount(driveU,function(err,response){
        if(err)
        {
            console.log("Error mounting drive: ",err);
            callback(err,null);
        }
        if(response)
            //console.log("Response mounting drive: ",response);
            if(response.message=="drive mounted")
            {
                updateDriveFilesFromPath(callback)
            }
    });
}

function scanDrives(callback) {

    //console.log("Scanning drives");
    HttpHelper.doHttpRequest("GET", "/api/files/drives", {}, function (err, list) {

        if(err)
        {
            console.log("Error scanning drives: ",err);
            callback(err,null)
        }
        if(list)
        {
            console.log("Response scanning drives: ",list);
            if(list.length>0 && list[0]!=="platform-musb*part*")
            {
                //console.log("Updating drives list: ",list)
                Formide.driveFiles= list;
            }
            else
            {
                //console.log("Not updating drive")
                Formide.driveFiles = [];
            }
        }

    });

}

function mount(drive,callback) {

    //console.log("Mounting drive");


    var res = encodeURIComponent(drive);
    HttpHelper.doHttpRequest("POST", "/api/files/mount/"+res, "", function (err, response) {

        if(err)
            console.log("Response ERR: ",JSON.stringify(err));
        if(response)
        {
            //console.log("Response mount OK: ",response)
            callback(null,JSON.parse(response));
        }

    });

}

function unmount(drive,callback) {

    //console.log("Unmounting drive");
    HttpHelper.doHttpRequest("POST", "/api/files/unmount/"+drive, {}, function (err, response) {

        if(err)
            console.log("Response ERR: ",err);
        if(response)
        {
            //console.log("Response OK: ",response)
            callback(JSON.parse(response));
        }

    });

}

