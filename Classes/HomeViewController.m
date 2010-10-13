//
//  HomeViewController.m
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


#import "HomeViewController.h"
#import "AggregateAppDelegate.h"
#import "Model.h"

@implementation HomeViewController

@synthesize serialNumberLabel;
@synthesize activity;
@synthesize amountLabel;
@synthesize userNameLabel;

- (IBAction)menu_btn_clicked {
	NSString *msg = [NSString stringWithFormat:@"Menu"];
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:msg delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Home" otherButtonTitles:@"Purchase Plugins", @"Add Money to Balance", @"Account History", @"Logout", nil];
	[actionSheet showInView:[self view]];
	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	UIAlertView *alert;
	if (buttonIndex != [actionSheet cancelButtonIndex]) {
		if (buttonIndex == 0) {
			// already at home
		} else if (buttonIndex == 1) {
			AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
			[mainDelegate goFrom:@"Home" to:@"Purchase Plugins"];
		} else if (buttonIndex == 2) {
			AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
			[mainDelegate goFrom:@"Home" to:@"Add Balance"];
		} else if (buttonIndex == 3) {
			AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
			[mainDelegate goFrom:@"Home" to:@"Account History"];
		} else if (buttonIndex == 4) {
			alert = [[UIAlertView alloc] initWithTitle:@"Logout" message:@"Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
			[alert show];
			[alert release];
		}
	}
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        // do stuff
		Model *model = [Model sharedModel];
		[model setIsLoggedIn:@"N"];
		
		AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
		[mainDelegate goFrom:@"Home" to:@"Login"];
    }
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
	

}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	
	[activity setHidden:NO];
	[activity startAnimating];
	
//	Model *model = [Model sharedModel];
//	[[self amountLabel] setText:[model currentAmount]];
}

- (void)viewDidAppear:(BOOL)animated {
	[self performSelector:@selector(doInitialLoad) withObject:NULL afterDelay:0.0];
	
}

- (void)doInitialLoad {
	Model *model = [Model sharedModel];
	
	AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *currentPoints = [mainDelegate getCurrentPoints];
	
	[model setCurrentAmount:currentPoints];
	[[self userNameLabel] setText:[model userName]];
	[[self serialNumberLabel] setText:[model serialNumber]];
	[[self amountLabel] setText:[NSString stringWithFormat:@"%.2f", [currentPoints floatValue]]];
	
	[activity stopAnimating];
	[activity setHidden:YES];
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
	[userNameLabel release];
	[amountLabel release];
	[activity release];
	[serialNumberLabel release];
	
    [super dealloc];
}


@end
