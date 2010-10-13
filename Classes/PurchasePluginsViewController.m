//
//  PurchasePluginsViewController.m
//  Aggregate
//
//  Created by Netmobo on 9/7/10.
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


#import "PurchasePluginsViewController.h"
#import "AggregateAppDelegate.h"
#import "Model.h"
#import "DescriptionAndNumber.h"
#import "DescriptionAndNumberCell.h"
#import "PurchaseProducts.h"

@implementation PurchasePluginsViewController

@synthesize tableDataArray;
@synthesize descriptionAndNumberCell;
@synthesize amountLabel;
@synthesize activity;

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
			AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
			[mainDelegate goFrom:@"Purchase Plugins" to:@"Home"];
		} else if (buttonIndex == 1) {
			// already there
		} else if (buttonIndex == 2) {
			AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
			[mainDelegate goFrom:@"Purchase Plugins" to:@"Add Balance"];
		} else if (buttonIndex == 3) {
			AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
			[mainDelegate goFrom:@"Purchase Plugins" to:@"Account History"];
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
		[mainDelegate goFrom:@"Purchase Plugins" to:@"Login"];
    }
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	
	[activity setHidden:NO];
	[activity startAnimating];
	

}

- (void)viewDidAppear:(BOOL)animated {
	[self performSelector:@selector(doInitialLoad) withObject:NULL afterDelay:0.0];
	
}

-(void) loadData {
	AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
	[tableDataArray addObjectsFromArray:[mainDelegate getProducts]];
}

- (void)doInitialLoad {
	tableDataArray = [[NSMutableArray alloc] init];
	
	[self loadData];

	
	[dataTableView reloadData];
	
	[activity stopAnimating];
	[activity setHidden:YES];
}


- (void)doAction:(PurchaseProducts *) aProduct {
	Model *model = [Model sharedModel];
	
	if ([[aProduct points] floatValue] <= [[model currentAmount] floatValue]) {
		
		NSNumber *aBrandID = [NSNumber numberWithInt:[[model brandID] intValue]];
		NSString *aAccountID = [model accountID];
		NSString *aServiceName = [aProduct serviceName];
		NSString *aProductCode = [aProduct productCode];
		// "Claim Rewards: " + bp.getDescription() + " (" + bp.getProductCode() + ")";
		NSString *aItem = [NSString stringWithFormat:@"Claim Products: %@ (%@)", [aProduct item], aProductCode];;
		
		AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
		[mainDelegate chargeAccountWithBrandID:aBrandID accountID:aAccountID serviceName:aServiceName productCode:aProductCode item:aItem];
		
		NSString *currentPoints = [mainDelegate getCurrentPoints];
		[model setCurrentAmount:currentPoints];
		[[self amountLabel] setText:currentPoints];
		
		NSString *msg = [NSString stringWithFormat:@"%@ for %.2f points", [aProduct item], [[aProduct points] floatValue] ];
		
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Products Claimed" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	} else {
		NSString *msg = @"You do not have enough in your balance";
		
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	[activity stopAnimating];
	[activity setHidden:YES];
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

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	Model *model = [Model sharedModel];
	[[self amountLabel] setText:[NSString stringWithFormat:@"%.2f", [[model currentAmount] floatValue]]];
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
	[tableDataArray release];
	[descriptionAndNumberCell release];
	[amountLabel release];
	[activity release];
	
    [super dealloc];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [tableDataArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ProductCellId";
    
    DescriptionAndNumberCell *cell = (DescriptionAndNumberCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"PurchasePluginsCell" owner:self options:nil];
        cell = self.descriptionAndNumberCell;
    }    
    
    DescriptionAndNumber *descriptionAndNumber = [tableDataArray objectAtIndex:indexPath.row];
	[cell configureWith:descriptionAndNumber];
	
	
	return cell; 
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[activity setHidden:NO];
	[activity startAnimating];
	
	DescriptionAndNumber *descriptionAndNumberTemp = [tableDataArray objectAtIndex:indexPath.row];
	
	[self performSelector:@selector(doAction:) withObject:descriptionAndNumberTemp afterDelay:0.0];
	
}

@end
