#import <Cordova/CDV.h>

@interface HWPTripos : CDVPlugin

 VTPSaleRequest* saleRequest;
- (void) greet:(CDVInvokedUrlCommand*)command;
 
- (void) callProcessSales:(CDVInvokedUrlCommand*)command;

- (void) initializeSDK:(CDVInvokedUrlCommand*)command;

@end