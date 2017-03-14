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
        images: function(id,hash,callback){return images(id,hash,callback)},
        getPrinters: function(callback){return getPrinters(callback)}
    }
}


/*************
 NATIVE IMPLEMENTATION
 ************/


// TODO: Rewrite image logic, having all in one place
function images(id,hash,callback){

        var url = "http://localhost:1337/api/db/files/"+id+"/images/"+hash+"?access_token="+Formide.accessToken;
        if(callback)
            return callback(null, url);
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
