
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

function slice(modelfiles, sliceprofile, materials, printer, override, callback){
    return FormideSlicer.slice(modelfiles, sliceprofile, materials, printer, override, callback);
}

function update(){
    return FormideUpdate.update();
}

function usb(){
    return FormideUSB.usb();
}

function wifi(){
    return FormideWifi.wifi();
}
