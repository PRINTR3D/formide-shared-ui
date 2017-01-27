
.pragma library

.import "formideAuth.js" as FormideAuth
.import "formideDatabase.js" as FormideDatabase
.import "formidePrinter.js" as FormidePrinter
.import "formideSlicer.js" as FormideSlicer
.import "formideUpdate.js" as FormideUpdate
.import "formideUsb.js" as FormideUSB
.import "formideWifi.js" as FormideWifi

.import "formideShared.js" as FormideShared

function auth(){
    return FormideAuth.auth();
}

function database(){
    return FormideDatabase.database();
}

function printer(port){
    return FormidePrinter.printer(port);
}

function slice(modelfiles, sliceprofile, materials, printer, callback){
    return FormideSlicer.slice(modelfiles, sliceprofile, materials, printer, callback);
}

function update(){
    return FormideUpdate.update();
}

function wifi(){
    return FormideWifi.wifi();
}
