//
//  AddMoneyCardViewController.m
//  Aggregate
//
//  Created by Netmobo on 9/8/10.
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


#import "AddMoneyCardViewController.h"
#import "AddMoneyCardExpirationViewController.h"
#import "Model.h"
#import "AddMoneyCardTextEntryViewController.h"

@implementation AddMoneyCardViewController

@synthesize dataArray;
@synthesize detailArray;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		
		[self setDataArray:[[NSMutableArray alloc] init]];
		[self setDetailArray:[[NSMutableArray alloc] init]];
		
		[detailArray addObject:@"Card Type"];
		[detailArray addObject:@"Card Number"];
		[detailArray addObject:@"Expiration"];
		[detailArray addObject:@"Security Code"];
		[detailArray addObject:@"Email"];
		[detailArray addObject:@"Last Name"];
		[detailArray addObject:@"First Name"];
		[detailArray addObject:@"Phone"];
		[detailArray addObject:@"Street"];
		[detailArray addObject:@"City"];
		[detailArray addObject:@"Country"];
		[detailArray addObject:@"State"];
		[detailArray addObject:@"Zip Code"];
    }
    return self;
}

- (void) doAction {
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) initData {
	Model *model = [Model sharedModel];
	
	[self.dataArray removeAllObjects];
	
	[dataArray addObject:[model currentCardType]];
	[dataArray addObject:[model currentCardNum]];
	// expiration
	NSString *expiration = [NSString stringWithFormat:@"%@ %@", [model currentCardMonth], [model currentCardYear]];
	[dataArray addObject:expiration];
	[dataArray addObject:[model securityCode]];
	[dataArray addObject:[model email]];
	[dataArray addObject:[model lastName]];
	[dataArray addObject:[model firstName]];
	[dataArray addObject:[model phone]];
	[dataArray addObject:[model street]];
	[dataArray addObject:[model city]];
	[dataArray addObject:[model currentCardCountry]];
	[dataArray addObject:[model state]];
	[dataArray addObject:[model zipcode]];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doAction)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	
	[self initData];
	[dataTableView reloadData];
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
	[detailArray release];
	[dataArray release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [dataArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
	cell.detailTextLabel.text = [detailArray objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Model *model = [Model sharedModel];
	
	if ([[detailArray objectAtIndex:indexPath.row] isEqualToString:@"Card Number"] || 
		[[detailArray objectAtIndex:indexPath.row] isEqualToString:@"Security Code"] || 
		[[detailArray objectAtIndex:indexPath.row] isEqualToString:@"Email"] || 
		[[detailArray objectAtIndex:indexPath.row] isEqualToString:@"Last Name"] || 
		[[detailArray objectAtIndex:indexPath.row] isEqualToString:@"First Name"] || 
		[[detailArray objectAtIndex:indexPath.row] isEqualToString:@"Phone"] || 
		[[detailArray objectAtIndex:indexPath.row] isEqualToString:@"Street"] || 
		[[detailArray objectAtIndex:indexPath.row] isEqualToString:@"City"] || 
		[[detailArray objectAtIndex:indexPath.row] isEqualToString:@"Zip Code"]) {
		
		AddMoneyCardTextEntryViewController *detailViewController = [[AddMoneyCardTextEntryViewController alloc] initWithNibName:@"AddMoneyCardTextEntryViewController" bundle:nil whichOne:[detailArray objectAtIndex:indexPath.row]];
		
		[self.navigationController pushViewController:detailViewController animated:YES];
		[detailViewController release];
		
		
	} else if([[detailArray objectAtIndex:indexPath.row] isEqualToString:@"State"]) { 
		if ([[model currentCardCountryCode] isEqualToString:@"US"] || 
			[[model currentCardCountryCode] isEqualToString:@"CA"]) {
			AddMoneyCardExpirationViewController *detailViewController = [[AddMoneyCardExpirationViewController alloc] initWithNibName:@"AddMoneyCardExpirationViewController" bundle:nil whichOne:[detailArray objectAtIndex:indexPath.row]];
			
			[self.navigationController pushViewController:detailViewController animated:YES];
			[detailViewController release];
			
		} else {
			AddMoneyCardTextEntryViewController *detailViewController = [[AddMoneyCardTextEntryViewController alloc] initWithNibName:@"AddMoneyCardTextEntryViewController" bundle:nil whichOne:[detailArray objectAtIndex:indexPath.row]];
			
			[self.navigationController pushViewController:detailViewController animated:YES];
			[detailViewController release];
		}
	} else {
		AddMoneyCardExpirationViewController *detailViewController = [[AddMoneyCardExpirationViewController alloc] initWithNibName:@"AddMoneyCardExpirationViewController" bundle:nil whichOne:[detailArray objectAtIndex:indexPath.row]];
		
		[self.navigationController pushViewController:detailViewController animated:YES];
		[detailViewController release];
	}
}

@end
