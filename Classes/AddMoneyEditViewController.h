//
//  AddMoneyEditViewController.h
//  Aggregate
//
//  Created by Netmobo on 9/8/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddMoneyEditViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
	NSString *whichOne;
	UILabel *whichOneLabel;
	UIPickerView *payViaPicker;
	NSArray *pickerData;
	UITextField *amountField;
}

@property (nonatomic, retain) NSString *whichOne;
@property (nonatomic, retain) IBOutlet UILabel *whichOneLabel;
@property (nonatomic, retain) IBOutlet UIPickerView *payViaPicker;
@property (nonatomic, retain) NSArray *pickerData;
@property (nonatomic, retain) IBOutlet UITextField *amountField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil whichOne:(NSString *) aWhichOne;

@end
