//
//  AddMoneyCardExpirationViewController.h
//  Aggregate
//
//  Created by Netmobo on 9/8/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddMoneyCardExpirationViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
	NSString *whichOne;
	UILabel *whichOneLabel;
	UIPickerView *expirationPicker;
	NSArray *monthArray;
	NSMutableArray *yearArray;
	NSMutableArray *countryArray;
	NSArray *cardTypeArray;
	NSMutableArray *stateArray;
}

@property (nonatomic, retain) NSString *whichOne;
@property (nonatomic, retain) IBOutlet UILabel *whichOneLabel;
@property (nonatomic, retain) IBOutlet UIPickerView *expirationPicker;
@property (nonatomic, retain) NSArray *monthArray;
@property (nonatomic, retain) NSMutableArray *yearArray;
@property (nonatomic, retain) NSMutableArray *countryArray;
@property (nonatomic, retain) NSArray *cardTypeArray;
@property (nonatomic, retain) NSMutableArray *stateArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil whichOne:(NSString *) aWhichOne;

@end
