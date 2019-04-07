//
//  MainViewController.h
//  SampleApp
//

#import <UIKit/UIKit.h>
#import "ConfigurationTableViewController.h"
#import "triPOSConfig.h"
#import <triPOSMobileSDK/triPOSMobileSDK.h>

@interface MainTableViewController : UITableViewController<VTPDelegate, UITableViewDelegate, UITableViewDataSource, ConfigurationProtocol> {
    VTP* sharedVtp;
    triPOSConfig* sharedTriPOSConfig;
    
    UISwitch* statusSwitch;
    NSMutableArray* tableData;
}

@property (retain, nonatomic) VTPConfiguration* vtpConfiguration;

@end
