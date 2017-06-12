/*
 *	This code was created for Printr B.V. It is open source under the formide-touch package.
 *	Copyright (c) 2017, All rights reserved, Printr B.V.
 */


.pragma library

.import "formideAuth.js" as FormideAuth
.import "formideStorage.js" as FormideStorage
.import "formidePrinter.js" as FormidePrinter
.import "formideSystem.js" as FormideSystem
.import "formideUpdate.js" as FormideUpdate
.import "formideUsb.js" as FormideUSB
.import "formideWifi.js" as FormideWifi

.import "formideShared.js" as FormideShared

function auth(){
    return FormideAuth.auth();
}


function storage(){
    return FormideStorage.storage();
}

function printer(){
    return FormidePrinter.printer("NO_PRINTER");
}

function printer(port){
    return FormidePrinter.printer(port);
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
