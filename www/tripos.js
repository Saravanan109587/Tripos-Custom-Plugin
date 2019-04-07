/*global cordova, module*/
var TriposModule={
    greet: function (name, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HWPTripos", "greet", [name]);
    },


    callsetUpTriPos: function (successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "HWPTripos", "callsetupTriPOSConfig", []);
    }
}
module.exports =  TriposModule;
