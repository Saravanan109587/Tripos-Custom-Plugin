/*global cordova, module*/

var TriposModule=function(){};
 
   TriposModule.greet= function (name, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "Tripos", "greet", [name]);
    }

    TriposModule.greet2= function (name, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "Tripos", "greet", [name]);
    }
 
module.exports =  TriposModule;
