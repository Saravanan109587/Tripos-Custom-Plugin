//
//  ConfigurationTableViewController.h
//  SampleApp
//

#import <UIKit/UIKit.h>

#import "triPOSConfig.h"
#import "MultipleSelectionConfigurationTableViewController.h"

@protocol ConfigurationProtocol <NSObject>

- (void)initializeSDK;

@end

@interface ConfigurationTableViewController : UITableViewController <UITextFieldDelegate, MultipleSelectionConfigurationProtocol>
{
    triPOSConfig *sharedTriPOSConfig;
}

@property (nonatomic, assign) id delegate;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBarButtonItem;
@property (strong, nonatomic) IBOutlet UITextField *transactionAmountTextField;

@property (strong, nonatomic) IBOutlet UILabel *deviceTypeDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *environmentTypeDetailLabel;

@property (strong, nonatomic) IBOutlet UITextField *tcpIpTextField;
@property (weak, nonatomic) IBOutlet UILabel *tcpIpLabel;

 
 
@end
