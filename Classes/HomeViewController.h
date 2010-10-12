//
//  HomeViewController.h
//  Aggregate
//
//  Created by Netmobo on 9/3/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeViewController : UIViewController <UIActionSheetDelegate, UIAlertViewDelegate> {
	UILabel *serialNumberLabel;
	UILabel *amountLabel;
	UILabel *userNameLabel;
	
	UIActivityIndicatorView *activity;
}

@property (nonatomic, retain) IBOutlet UILabel *serialNumberLabel;
@property (nonatomic, retain) IBOutlet UILabel *amountLabel;
@property (nonatomic, retain) IBOutlet UILabel *userNameLabel;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;

- (IBAction)menu_btn_clicked;

@end
