/*global cordova, module*/
var TriposModule={
    greet: function (name, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "Tripos", "greet", [name]);
    }
}
module.exports =  TriposModule;
