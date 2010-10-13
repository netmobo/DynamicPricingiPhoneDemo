//
//  LoginViewController.m
//  Aggregate
//
//  Created by Netmobo on 9/3/10.
//  Copyright 2010 Netmobo. All rights reserved.
//
/*
 Copyright (c) 2010, NETMOBO LLC
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of NETMOBO LLC nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


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
