//
//  AddMoneyCardTextEntryViewController.h
//  Aggregate
//
//  Created by Vicente Malixi on 9/8/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddMoneyCardTextEntryViewController : UIViewController {
	NSString *whichOne;
	UILabel *whichOneLabel;
	UITextField *entryField;
}

@property (nonatomic, retain) NSString *whichOne;
@property (nonatomic, retain) IBOutlet UILabel *whichOneLabel;
@property (nonatomic, retain) IBOutlet UITextField *entryField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil whichOne:(NSString *) aWhichOne;

@end
