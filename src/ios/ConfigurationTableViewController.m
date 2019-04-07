//
//  ConfigurationTableViewController.m
//  SampleApp
//

#import "ConfigurationTableViewController.h"
#import "MultipleSelectionConfigurationTableViewController.h"

@interface ConfigurationTableViewController ()
{
    NSArray *configurationSectionTitles;
    
    NSArray *sectionDescriptions;

    NSIndexPath *selectedIndexPath;
    NSString *previousTransactionAmount;
    NSString *previousTcpIpAddress;

    NSMutableArray *deviceTypeArray;
    
    NSMutableArray *environmentArray;
    
    NSInteger currentRow;
    NSInteger previousRow;
    
    NSInteger currentEnvironment;
    NSInteger previousEnvironment;
}

@end

@implementation ConfigurationTableViewController
 
-(void)addGestureRecognizer:(UIView *)view
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [view addGestureRecognizer:tap];
}

-(void)dismissKeyboard
{
    [self resignAllFirstResponders];
}

-(void)resignAllFirstResponders
{
    [_tcpIpTextField resignFirstResponder];
    [_transactionAmountTextField resignFirstResponder];
}

#pragma mark - TextField Delegate Methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string
{
    if (textField == _transactionAmountTextField)
    {
        double currentValue = [[textField.text substringFromIndex:1] doubleValue];
        
        double cents = round(currentValue * 100.0f);
        
        if (string.length)
        {
            for (size_t i = 0; i < string.length; i++)
            {
                unichar c = [string characterAtIndex:i];
                if (isnumber(c))
                {
                    cents *= 10;
                    cents += c - '0';
                }
            }
        }
        else
        {
            cents = floor(cents / 10);
        }
        
        textField.text = [NSString stringWithFormat:@"%.2f", cents / 100.0f];
        textField.text = [NSString stringWithFormat:@"$%@", textField.text];
        
        return NO;
    }
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _transactionAmountTextField)
    {
        textField.text = @"$0.00";
    }
}


#pragma mark - IBActions

- (IBAction)touchUpSaveBarButtonItem:(id)sender
{
    BOOL shouldReInitializeSDK = NO;
    
    if ([self transactionAmountDidChange])
    {
        [self saveTransactionAmountToDefaults];
        sharedTriPOSConfig.transactionAmount = _transactionAmountTextField.text;
    }
    
    VTPDeviceType selectedDevice = VTPDeviceTypeNull;
    
    if ([self environmentDidChange])
    {
        // Set the selected device in triPOSConfig
        sharedTriPOSConfig.deviceType = selectedDevice;
        
        [[NSUserDefaults standardUserDefaults] setInteger:currentEnvironment forKey:@"selectedEnvironmentKey"];
        
        shouldReInitializeSDK = YES;
    }
    
    if (shouldReInitializeSDK)
    {
        // Relinitialize triPOS Mobile SDK
        [sharedTriPOSConfig setupVtpConfiguration];
        [_delegate initializeSDK];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return configurationSectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) // Transaction
    {
        return 1;
    }
    else if (section == 1) // Environment
    {
        return 1;
    }
    else if (section == 2) // Logo
    {
        return 1;
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [configurationSectionTitles objectAtIndex:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return sectionDescriptions[section];
}

#pragma mark - Segue management

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MultipleSelectionConfigurationTableViewController *vcToPushTo = segue.destinationViewController;
    
    vcToPushTo.delegate = self;
    
    vcToPushTo.indexPath = [self.tableView indexPathForCell:sender];
    
    NSString *optionTitle;
    
    if (vcToPushTo.indexPath.section == 1)
    {
        vcToPushTo.selectedRow = currentEnvironment;

        optionTitle = @"Environment Type";
        
        vcToPushTo.options = environmentArray;
    }
    
    vcToPushTo.title = optionTitle;
    vcToPushTo.sectionTitle = optionTitle;
}
 
#pragma mark - Setup view methods

-(void)setupTransactionAmountTextField
{
    if (_transactionAmountTextField)
    {
        _transactionAmountTextField.delegate = self;
        
        NSString *mostRecentlyUsedTransactionAmount = [[NSUserDefaults standardUserDefaults] stringForKey:@"transactionAmountKey"];
        
        _transactionAmountTextField.text = mostRecentlyUsedTransactionAmount == nil ? @"$1.00" : mostRecentlyUsedTransactionAmount;
    }
}

-(void)setupEnvironmentTypeDetailLabel
{
    NSInteger theCurrentEnvironment;
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"selectedEnvironmentKey"])
    {
        theCurrentEnvironment = 0;
    }
    else
    {
        theCurrentEnvironment = [[NSUserDefaults standardUserDefaults] integerForKey:@"selectedEnvironmentKey"];
    }
    
    currentEnvironment = theCurrentEnvironment;
    previousEnvironment = theCurrentEnvironment;
    
    _environmentTypeDetailLabel.text = environmentArray[currentEnvironment];
}

-(void)replaceDetailWithTextFieldForCell:(UITableViewCell *)cell textField:(UITextField *)textField
{
    cell.detailTextLabel.hidden = YES;
    
    [[cell viewWithTag:3] removeFromSuperview];
    
    if (textField == nil)
    {
        textField = [[UITextField alloc] init];
    }
    
    textField.tag = 3;
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [cell.contentView addSubview:textField];
    
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:cell.textLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:8]];
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:8]];
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-8]];
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:cell.detailTextLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    
    textField.textAlignment = NSTextAlignmentRight;
    textField.delegate = self;
}

#pragma mark - Support Methods

- (void)saveTransactionAmountToDefaults
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    [standardUserDefaults setObject:_transactionAmountTextField.text forKey:@"transactionAmountKey"];
}

-(BOOL)environmentDidChange
{
    return currentEnvironment != previousEnvironment;
}

 
+ (VTPApplicationMode)getEnvironmentTypeForIndex:(NSInteger)index
{
    switch (index)
    {
        case 1:
            return VTPApplicationModeProduction;
        case 0:
        default:
            return VTPApplicationModeTestCertification;
    }
}

- (void)setDetailLabelForIndexPath:(NSIndexPath *)indexPath selectedRow:(NSInteger)selectedRow;
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        currentEnvironment = selectedRow;
        
    cell.detailTextLabel.text = environmentArray[selectedRow];
}

@end
