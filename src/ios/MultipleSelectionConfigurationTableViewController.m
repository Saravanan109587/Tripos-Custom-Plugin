//
//  MultipleSelectionConfigurationTableViewController.m
//  SampleApp
//

#import "MultipleSelectionConfigurationTableViewController.h"

@interface MultipleSelectionConfigurationTableViewController ()

@end

@implementation MultipleSelectionConfigurationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _options.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"optionRow" forIndexPath:indexPath];
    
    cell.textLabel.text = _options[indexPath.row];
    
    if (indexPath.row == _selectedRow)
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate setDetailLabelForIndexPath:_indexPath selectedRow:indexPath.row];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
