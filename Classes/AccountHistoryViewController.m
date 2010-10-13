//
//  AccountHistoryViewController.m
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


#import "AccountHistoryViewController.h"
#import "AggregateAppDelegate.h"
#import "Model.h"
#import "History.h"
#import "HistoryTableCell.h"

@implementation AccountHistoryViewController

@synthesize historyCell;
@synthesize historyArray;
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
			[mainDelegate goFrom:@"Account History" to:@"Home"];
		} else if (buttonIndex == 1) {
			AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
			[mainDelegate goFrom:@"Account History" to:@"Purchase Plugins"];
		} else if (buttonIndex == 2) {
			AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
			[mainDelegate goFrom:@"Account History" to:@"Add Balance"];
		} else if (buttonIndex == 3) {
			// already there
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
		[mainDelegate goFrom:@"Account History" to:@"Login"];
    }
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	
	[activity setHidden:NO];
	[activity startAnimating];
	
	Model *model = [Model sharedModel];
	[[self amountLabel] setText:[model currentAmount]];
}

- (void)viewDidAppear:(BOOL)animated {
	[self performSelector:@selector(doInitialLoad) withObject:NULL afterDelay:0.0];
	
}

-(void) loadData {
	AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
	[historyArray addObjectsFromArray:[mainDelegate getPointHistory]];
}

- (void)doInitialLoad {
	historyArray = [[NSMutableArray alloc] init];
	
	[self loadData];
	
	[historyTableView reloadData];
	
	[activity stopAnimating];
	[activity setHidden:YES];
}

- (void)doAction:(History *) aHistory {
	
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
	[[self amountLabel] setText:[model currentAmount]];
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
	[activity release];
	[amountLabel release];
	[historyArray release];
	[historyCell release];
	
    [super dealloc];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [historyArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ProductCellId";
    
    HistoryTableCell *cell = (HistoryTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"AccountHistoryCell" owner:self options:nil];
        cell = self.historyCell;
    }    
    
    History *aHistory = [historyArray objectAtIndex:indexPath.row];
	[cell configureWith:aHistory];
	
	
	return cell; 
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[activity setHidden:NO];
	[activity startAnimating];
	
	History *aHistory = [historyArray objectAtIndex:indexPath.row];
	
	[self performSelector:@selector(doAction:) withObject:aHistory afterDelay:0.0];
	
}

@end
