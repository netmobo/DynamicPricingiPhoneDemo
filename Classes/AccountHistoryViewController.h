//
//  AccountHistoryViewController.h
//  Aggregate
//
//  Created by Netmobo on 9/7/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HistoryTableCell;

@interface AccountHistoryViewController : UIViewController <UITableViewDataSource, UIActionSheetDelegate, UIAlertViewDelegate> {
	HistoryTableCell *historyCell;
	NSMutableArray *historyArray;
	IBOutlet UITableView *historyTableView;
	
	UILabel *amountLabel;
	
	UIActivityIndicatorView *activity;
}

@property (nonatomic, retain) IBOutlet HistoryTableCell *historyCell;
@property (nonatomic, retain) NSMutableArray *historyArray;

@property (nonatomic, retain) IBOutlet UILabel *amountLabel;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;

- (IBAction)menu_btn_clicked;
- (void)doInitialLoad;
-(void) loadData;

@end
