//
//  PurchasePluginsViewController.h
//  Aggregate
//
//  Created by Netmobo on 9/7/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DescriptionAndNumberCell;

@interface PurchasePluginsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIAlertViewDelegate> {
	DescriptionAndNumberCell *descriptionAndNumberCell;
	NSMutableArray *tableDataArray;
	IBOutlet UITableView *dataTableView;
	
	UILabel *amountLabel;
	
	UIActivityIndicatorView *activity;
}

@property (nonatomic, retain) IBOutlet DescriptionAndNumberCell *descriptionAndNumberCell;
@property (nonatomic, retain) NSMutableArray *tableDataArray;

@property (nonatomic, retain) IBOutlet UILabel *amountLabel;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;

- (IBAction)menu_btn_clicked;
- (void)doInitialLoad;
-(void) loadData;

@end
