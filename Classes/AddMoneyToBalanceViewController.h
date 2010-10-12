//
//  AddMoneyToBalanceViewController.h
//  Aggregate
//
//  Created by Netmobo on 9/7/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface AddMoneyToBalanceViewController : UIViewController <SKProductsRequestDelegate, SKPaymentTransactionObserver, UITableViewDataSource, UIActionSheetDelegate, UIAlertViewDelegate> {
	IBOutlet UITableView *balanceTableView;
	NSString *amountToRecharge;
	NSString *payVia;
	
	UILabel *serialNumberLabel;
	UILabel *amountLabel;
	UIActivityIndicatorView *activity;
	
	BOOL startedRecharge;
}

@property (nonatomic, retain) NSString *amountToRecharge;
@property (nonatomic, retain) NSString *payVia;

@property (nonatomic, retain) IBOutlet UILabel *serialNumberLabel;
@property (nonatomic, retain) IBOutlet UILabel *amountLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;

@property (nonatomic, assign) BOOL startedRecharge;

- (IBAction)menu_btn_clicked;
- (IBAction) doAction;
- (void) doAction2;
- (void) doRecharge;

@end
