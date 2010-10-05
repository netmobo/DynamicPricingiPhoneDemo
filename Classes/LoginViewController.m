//
//  LoginViewController.m
//  Aggregate
//
//  Created by Netmobo on 9/3/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import "LoginViewController.h"
#import "AggregateAppDelegate.h"
#import "SignUpViewController.h"
#import "Model.h"

@implementation LoginViewController

@synthesize username;
@synthesize pw;

- (IBAction) processLogin:(id) sender {
	[self.pw resignFirstResponder];
	
	NSString *usernameStr = [self.username text];
	NSString *passwordStr = [self.pw text];
	
	AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	NSString *errorCodeMsg = [mainDelegate loginWithUser:usernameStr andPassword:passwordStr];
	
	Model *model = [Model sharedModel];
	
	if ([errorCodeMsg isEqualToString:@"none"]) {
		[model setIsLoggedIn:@"Y"];
		
		[mainDelegate goHome];
	} else {
		[model setIsLoggedIn:@"N"];
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"Wrong username or password" delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

- (IBAction) goSignup {
	SignUpViewController *textEntryViewController = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
	[self.navigationController pushViewController:textEntryViewController animated:YES];
	[textEntryViewController release];
}
 

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.navigationController setNavigationBarHidden:YES];
	
	[self.pw setDelegate:self];
    [self.pw setReturnKeyType:UIReturnKeyDone];
    [self.pw addTarget:self
				action:@selector(processLogin:)
	  forControlEvents:UIControlEventEditingDidEndOnExit];
	
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:NO];
	
	[self.navigationController setNavigationBarHidden:YES];
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[username release];
	[pw release];
    [super dealloc];
}



@end
