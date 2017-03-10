//


            //  STORAGE
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
        list: function(callback){return list(callback)},
        single: function(filename, callback){return single(filename,callback)},
        remove: function(filename,callback){return remove(filename,callback)},
        download: function(filename,callback){return remove(filename,callback)},

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


function single(filename,callback) {
    HttpHelper.doHttpRequest("GET", "http://localhost:1337/api/storage/"+filename, {}, function (err, response) {
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


function remove(filename,callback) {
    HttpHelper.doHttpRequest("DELETE", "http://localhost:1337/api/storage/"+filename, {}, function (err, response) {
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
    HttpHelper.doHttpRequest("DELETE", "http://localhost:1337/api/storage/"+filename+"/download", {}, function (err, response) {
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

