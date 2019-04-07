/*global cordova, module*/
var TriposModule={
    greet: function (name, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HWPTripos", "greet", [name]);
    },
    startSDK: function (name, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HWPTripos", "startSDK", [name]);
    }
}
module.exports =  TriposModule;
