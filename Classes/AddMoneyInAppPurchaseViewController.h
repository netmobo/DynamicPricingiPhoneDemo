//
//  AddMoneyInAppPurchaseViewController.h
//  Aggregate
//
//  Created by Vicente Malixi on 9/20/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMoneyInAppPurchaseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	NSMutableArray *inAppPaymentOptionArray;
}

@property (nonatomic, retain) NSMutableArray *inAppPaymentOptionArray;

- (void) purchase:(int) aRow;

@end
