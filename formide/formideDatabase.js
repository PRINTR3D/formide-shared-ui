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
.import "formide.js" as Formide
.import "formidePrinter.js" as FormidePrinter


/*************
 NATIVE IMPLEMENTATION
 ************/

function getFiles(callback) {

    // Calls HttpHelper.doHttpRequest
    HttpHelper.doHttpRequest("GET", "/api/db/files", {}, function (err, files)
    {
        if(err)
        {
            console.log("Error getting files"+err);
            if(callback)
                callback(err,null);
        }
        if(files)
        {
//          console.log("Response get files",JSON.stringify(response));
            Formide.fileItems=files;
            if(callback)
                callback(null,files);
        }
    });
}


// TODO: Rewrite image logic, having all in one place
function images(id,hash,callback){
        var url = "http://localhost:1337/api/db/files/"+id+"/images/"+hash+"?access_token="+accessToken;
        if(callback)
            return callback(null, url);
}

function getPrintJobs(callback) {
    HttpHelper.doHttpRequest("GET", "/api/db/printjobs", {}, function (err, printjobs) {
        if(err)
        {
            console.log("Error getting printjobs"+err);
            if(callback)
                callback(err,null);
        }
        if(printjobs)
        {

//            console.log("Response get printjobs",JSON.stringify(printjobs));
            Formide.printJobs = data.filter(function(printJob) {
                if (printJob.sliceFinished)
                    return printJob;
            });

            if(callback)
                callback(null,printjobs);
        }
    });
}



function removeFile(id,callback) {
    HttpHelper.doHttpRequest("DELETE", "/api/db/files/" + id, {}, function (err, response) {
        if(err)
        {
            //console.log("Error deleting file",err);
            if(callback)
                callback(err,null)
        }
        if (response)
        {
            //console.log('Response deleting file', response)

            // After deleting a file, we fetch them again
            getFiles();

            if(callback)
                callback(null,response);
        }
    });
}

function removePrintJob(id,callback) {

    HttpHelper.doHttpRequest("DELETE", "/api/db/printjobs/" + id, {}, function (err, response) {
        if(err)
        {
            //console.log("Error deleting print job",err);
            if(callback)
                callback(err,null)
        }
        if (response)
        {
            //console.log('Response deleting print job', response)

            // After deleting a print job, we fetch them again
            getPrintJobs();

            if(callback)
                callback(null,response);
        }
    });
}

function removeQueueItem(id,callback) {

    HttpHelper.doHttpRequest("DELETE", "/api/db/queue/" + id, {}, function (err, response) {

        if(err)
        {
            console.log("Error removing queue item"+err)
            if(callback)
                callback(err,null)
        }
        if(response)
        {
            // Console.log("Response remove queue item",response);

            // After removing a queue item, update queue (TODO: Remove it when implementing the socket event for queue item added)
            FormidePrinter.printer(Formide.printerStatus.port).getQueue();
            if(callback)
                callback(null,response)
        }
    });
}


function materials(callback) {
    HttpHelper.doHttpRequest("GET", "/api/db/materials", {}, function (err, materials) {

        if(err)
        {
            console.log("Error get materials: "+err)
            if(callback)
                callback(err,null);
        }
        if(materials)
        {
            //console.log("RESPONSE MATERIALS: " +JSON.stringify(JSON.parse(response)))
            Formide.materials=materials;
            if(callback)
                callback(null,materials);
        }
    });
}


function sliceprofiles(callback) {
    HttpHelper.doHttpRequest("GET", "/api/db/sliceprofiles", {}, function (err, sliceprofiles) {
        if(err)
        {
            console.log("Error getting slice profiles: "+err)
            if(callback)
                callback(err,null);
        }
        if(sliceprofiles)
        {
//            console.log("Response slice profiles",sliceprofiles);
            Formide.sliceProfiles=sliceprofiles
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
                console.log("Error getting printers: "+err)
                if(callback)
                    callback(err,null);
            }
            if(printers)
            {
                //console.log("Response get printers",printers)
                Formide.printers=printers;


                // In this piece of code we make sure that the printer selected
                // and used in this UI is the one connected and online
                for (var i in printers) {
                    if (printers[i].port == Formide.printerStatus.port)
                    {
                        Formide.uniquePrinter=data[i]
                    }
                }

                if(callback)
                    callback(null,printers)
            }
        });

}
