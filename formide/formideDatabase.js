//    _____       _______       ____           _____ ______
//   |  __ \   /\|__   __|/\   |  _ \   /\    / ____|  ____|
//   | |  | | /  \  | |  /  \  | |_) | /  \  | (___ | |__
//   | |  | |/ /\ \ | | / /\ \ |  _ < / /\ \  \___ \|  __|
//   | |__| / ____ \| |/ ____ \| |_) / ____ \ ____) | |____
//   |_____/_/    \_|_/_/    \_|____/_/    \_|_____/|______|
//
//

.pragma library
// Includes
.import "Http.js" as HttpHelper
.import "formideShared.js" as Formide


/*************
 EXPOSURE
 ************/
function database(){
    return{
        getFiles: function(callback){return getFiles(callback)},
        images: function(id,hash,callback){return images(id,hash,callback)},
        getPrintJobs: function(callback){return getPrintJobs(callback)},
        removeFile: function(id,callback){return removeFile(id,callback)},
        removePrintJob: function(id,callback){return removePrintJob(id,callback)},
        removeQueueItem: function(id,callback){return removeQueueItem(id,callback)},
        materials: function(callback){return materials(callback)},
        sliceprofiles: function(callback){return sliceprofiles(callback)},
        getPrinters: function(callback){return getPrinters(callback)}
    }
}


/*************
 NATIVE IMPLEMENTATION
 ************/
function getFiles(callback) {

    // Calls HttpHelper.doHttpRequest
    HttpHelper.doHttpRequest("GET", "/api/db/files", {}, function (err, files)
    {
        if(err)
        {
            if(callback)
                callback(err,null);
        }
        if(files)
        {
            if(callback)
                callback(null,files);
        }
    });
}


// TODO: Rewrite image logic, having all in one place
function images(id,hash,callback){

        var url = "http://localhost:1337/api/db/files/"+id+"/images/"+hash+"?access_token="+Formide.accessToken;
        if(callback)
            return callback(null, url);
}

function getPrintJobs(callback) {
    HttpHelper.doHttpRequest("GET", "/api/db/printjobs", {}, function (err, printjobs) {
        if(err)
        {
            if(callback)
                callback(err,null);
        }
        if(printjobs)
        {
            if(callback)
                callback(null,printjobs);
        }
    });
}



function removeFile(id,callback) {
    HttpHelper.doHttpRequest("DELETE", "/api/db/files/" + id, {}, function (err, response) {
        if(err)
        {
            if(callback)
                callback(err,null)
        }
        if (response)
        {
            if(callback)
                callback(null,response);
        }
    });
}

function removePrintJob(id,callback) {

    HttpHelper.doHttpRequest("DELETE", "/api/db/printjobs/" + id, {}, function (err, response) {
        if(err)
        {
            if(callback)
                callback(err,null)
        }
        if (response)
        {
            if(callback)
                callback(null,response);
        }
    });
}

function removeQueueItem(id,callback) {

    HttpHelper.doHttpRequest("DELETE", "/api/db/queue/" + id, {}, function (err, response) {

        if(err)
        {
            if(callback)
                callback(err,null)
        }
        if(response)
        {

            if(callback)
                callback(null,response)
        }
    });
}


function materials(callback) {
    HttpHelper.doHttpRequest("GET", "/api/db/materials", {}, function (err, materials) {

        if(err)
        {
            if(callback)
                callback(err,null);
        }
        if(materials)
        {
            if(callback)
                callback(null,materials);
        }
    });
}


function sliceprofiles(callback) {
    HttpHelper.doHttpRequest("GET", "/api/db/sliceprofiles", {}, function (err, sliceprofiles) {
        if(err)
        {
            if(callback)
                callback(err,null);
        }
        if(sliceprofiles)
        {
            if(callback)
                callback(null,sliceprofiles)
        }
    });
}


// Get list of printers
function getPrinters(callback) {
    HttpHelper.doHttpRequest("GET", "/api/db/printers", {}, function (err, printers) {
            if(err)
            {
                if(callback)
                    callback(err,null);
            }
            if(printers)
            {
                if(callback)
                    callback(null,printers)
            }
        });

}
