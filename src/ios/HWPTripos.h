#import <Cordova/CDV.h>

@interface HWPTripos : CDVPlugin

- (void) greet:(CDVInvokedUrlCommand*)command;
- (void) startSDK:(CDVInvokedUrlCommand*)command;
  
@end