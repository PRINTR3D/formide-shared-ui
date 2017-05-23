/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


.pragma library
// Includes
.import "Http.js" as HttpHelper
.import "formideShared.js" as Formide


/*************
 EXPOSURE
 ************/
function storage(){
    return{
        list: function(callback){return list(callback)},
        single: function(filename, callback){return single(filename,callback)},
        remove: function(filename,callback){return remove(filename,callback)},
        download: function(filename,callback){return remove(filename,callback)},
        diskSpace: function(callback){return diskspace(callback)}

    }
}


/*************
 NATIVE IMPLEMENTATION
 ************/
function list(callback) {

    // Calls HttpHelper.doHttpRequest
    HttpHelper.doHttpRequest("GET", "/api/storage/", {}, function (err, files)
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

function diskspace(callback) {

    // Calls HttpHelper.doHttpRequest
    HttpHelper.doHttpRequest("GET", "/api/storage/diskspace", {}, function (err, response)
    {
        if(err)
        {
            if(callback)
                callback(err,null);
        }
        if(response)
        {
            if(callback)
                callback(null,response);
        }
    });
}


function single(filename,callback) {
    HttpHelper.doHttpRequest("GET", "/api/storage/"+filename, {}, function (err, response) {
        if(err)
        {
            if(callback)
                callback(err,null);
        }
        if(response)
        {
            if(callback)
                callback(null,response);
        }
    });
}

function remove(name,callback) {
    var file = encodeURIComponent(name);
    var payload = {};

    HttpHelper.doHttpRequest("DELETE", "/api/storage/"+file, JSON.stringify(payload), function (err, response) {

        console.log("Deleting")
        if(err)
        {
            if(callback)
                callback(err,null);
        }
        if(response)
        {
            if(callback)
                callback(null,response);
        }
    });
}

function download(filename,callback) {
    HttpHelper.doHttpRequest("GET", "/api/storage/"+filename+"/download", {}, function (err, response) {
        if(err)
        {
            if(callback)
                callback(err,null);
        }
        if(response)
        {
            if(callback)
                callback(null,response);
        }
    });
}

