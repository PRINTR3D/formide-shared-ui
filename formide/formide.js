
.pragma library

.import "formideAuth.js" as FormideAuth
.import "formideDatabase.js" as FormideDatabase
.import "formideStorage.js" as FormideStorage
.import "formidePrinter.js" as FormidePrinter
.import "formideSlicer.js" as FormideSlicer
.import "formideSystem.js" as FormideSystem
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

function storage(){
    return FormideStorage.storage();
}

function printer(port){
    return FormidePrinter.printer(port);
}

function slice(modelfiles, sliceprofile, materials, printer, override, callback){
    return FormideSlicer.slice(modelfiles, sliceprofile, materials, printer, override, callback);
}

function system(){
    return FormideSystem.system();
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
