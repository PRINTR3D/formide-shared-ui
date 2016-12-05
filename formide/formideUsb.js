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
//.import "Http.js" as HttpHelper
//.import "formide.js" as Formide


function usb(){
    return{

        updateDriveFilesFromPath:function(callback){return updateDriveFilesFromPath(callback);},
        updateDrivePath:function(driveP){return updateDrivePath(driveP);},
        updateDriveListing:function(i){return updateDriveListing(i)},
        updateDriveUnit:function(driveU){return updateDriveUnit(driveU)}

        // TO be finished






    }
}

/*************
 LIBRARY IMPLEMENTATION
 ************/

function updateDriveFilesFromPath(callback){

    var driveUnit=Formide.driveUnit
    var drivePath=Formide.drivePath


    readDrive(driveUnit,drivePath,function(err,list){
        if(err)
        {
            console.log("Error: ",err);
            callback(err,null);
        }
        if(list)
        {
            //console.log("Response: ",list);
            Formide.driveListing=0;

            Formide.driveFiles=list.filter(function(file) {
                if (file.name)
                {
                    if(file.name.toLowerCase().indexOf(".gcode") !== -1 || file.name.toLowerCase().indexOf(".stl") !== -1 || file.type=="dir")
                        return file;
                }
            });

            callback(null,list);
        }
    });
}

// Update drive path to read files
function updateDrivePath(driveP){
    Formide.drivePath=driveP;

}

// Update drive listing
function updateDriveListing(i){
    Formide.driveListing=i;
}

// Update drive unit which we read from
function updateDriveUnit(driveU){
    Formide.driveUnit=driveU;

    Formide.usb().mount(driveU,function(err,response){
        if(err)
            console.log("Error: ",err);
        if(response)
            //console.log("Response: ",response);
            if(response.message=="drive mounted")
            {
                updateDriveFilesFromPath()
            }
    });
}

// Scan drive units
function scanDrives()
{
    Formide.usb().scanDrives(function(list)
    {

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
    });
}


/*************
 NATIVE IMPLEMENTATION
 ************/

function readDrive(drive,path,callback) {

    //console.log("Reading drive");

    var data=
    {
        "path":path
    }

    var res = encodeURIComponent(drive);

    //console.log("URL: ",res);

    HttpHelper.doHttpRequest("GET", "/api/files/read/"+res, data, function (err, list) {

        if(err)
            console.log("Response ERR: ",err);
        if(list)
        {
            //console.log("Response OK: ",list)
            callback(null,JSON.parse(list));
        }

    });

}

// Needs callback implementation
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


function scanDrives(callback) {

    //console.log("Scanning drives");
    HttpHelper.doHttpRequest("GET", "/api/files/drives", {}, function (err, list) {

        if(err)
            console.log("Response ERR: ",err);
        if(list)
        {
            console.log("Response: ",list);
            callback(JSON.parse(list));
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

