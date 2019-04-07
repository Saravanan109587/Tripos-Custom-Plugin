#import "HWPTripos.h"

@implementation HWPTripos

- (void)greet:(CDVInvokedUrlCommand*)command
{

    NSString* name = [[command arguments] objectAtIndex:0];
    NSString* msg = [NSString stringWithFormat: @"Hello, %@", name];

    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)startSDK:(CDVInvokedUrlCommand*)command
{

    MainTableViewController *maintable;
    maintable =[MainTableViewController alloc];
    maintable=[maintable init];
    [maintable setupTriPOSConfig];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"SDk Intialized"];
    [self.commandDelegate sendPluginResult:pluginResult
                                callbackId:command.callbackId];
}


@end
