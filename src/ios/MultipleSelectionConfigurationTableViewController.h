//
//  MultipleSelectionConfigurationTableViewController.h
//  SampleApp
//
//  Copyright © 2018 Worldpay, LLC. and/or its affiliates. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MultipleSelectionConfigurationProtocol <NSObject>

- (void)setDetailLabelForIndexPath:(NSIndexPath *)indexPath selectedRow:(NSInteger)selectedRow;

@end

@interface MultipleSelectionConfigurationTableViewController : UITableViewController

@property (nonatomic, assign) id delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic) NSInteger selectedRow;

@property (nonatomic, strong) NSMutableArray *options;
@property (nonatomic, strong) NSString *sectionTitle;

@end
