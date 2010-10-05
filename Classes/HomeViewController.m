//
//  HomeViewController.m
//  Aggregate
//
//  Created by Netmobo on 9/3/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

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
