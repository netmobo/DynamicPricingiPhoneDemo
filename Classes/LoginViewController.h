//
//  LoginViewController.h
//  Aggregate
//
//  Created by Netmobo on 9/3/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController <UITextFieldDelegate> {
	UITextField *username;
	UITextField *pw;
}

@property (nonatomic, retain) IBOutlet UITextField *username;
@property (nonatomic, retain) IBOutlet UITextField *pw;

- (IBAction) processLogin:(id) sender;
- (IBAction) goSignup;

@end
