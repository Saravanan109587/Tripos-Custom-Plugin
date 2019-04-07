//
//  MainViewController.m
//  SampleApp
//
  
 
#import "MainTableViewController.h" 
#import "triPOSConfig.h"
#import "ConfigurationTableViewController.h"

 
@implementation MainTableViewController

  
- (void) setupTriPOSConfig
{
    sharedTriPOSConfig = triPOSConfig.sharedTriPOSConfig;
    _vtpConfiguration = sharedTriPOSConfig.vtpConfiguration;
    
    sharedVtp = triPOSMobileSDK.sharedVtp;
    [sharedVtp addDelegate:self];
}
 
#pragma mark : - SDK Initialization/Deinitialization

- (void)initializeSDK
{
    NSError* error;
    NSString* status ;
    if ([sharedVtp inititializeWithConfiguration:self.vtpConfiguration error:&error])
    {
        status=@"Initialized";
    }
    else
    {
         status= @"Not initialized";
    }
    
    return status;
}

- (void)deinitializeSDK
{
    [UIApplication startNetworkActivityIndicator];
    
    NSError* error;
    
    if ([sharedVtp deinitialize:&error])
    {
        [self setSwitchStatus];
    }
    else
    {
        [self showSdkErrorAlert:error];
    }
    
    [UIApplication stopNetworkActivityIndicator];
}
  
@end
