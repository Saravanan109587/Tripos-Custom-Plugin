#import <Cordova/CDV.h>

@interface HWPTripos : CDVPlugin
- (void) greet:(CDVInvokedUrlCommand*)command;
 
- (void) callProcessSales:(CDVInvokedUrlCommand*)command;

- (void) callsetupTriPOSConfig:(CDVInvokedUrlCommand*)command;

@end