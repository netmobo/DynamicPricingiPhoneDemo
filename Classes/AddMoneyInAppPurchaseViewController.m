//
//  AddMoneyInAppPurchaseViewController.m
//  Aggregate
//
//  Created by Vicente Malixi on 9/20/10.
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


#import "AddMoneyInAppPurchaseViewController.h"
#import "AggregateAppDelegate.h"
#import "Model.h"

@implementation AddMoneyInAppPurchaseViewController

@synthesize inAppPaymentOptionArray;

- (void) purchase:(int) aRow {
	Model *model = [Model sharedModel];
	int productIdentifierInt = aRow + 1;
	NSString *productIdentifier = [NSString stringWithFormat:@"com.netmobo.Netmobodemo.planmovie_USD_%i", productIdentifierInt];
	[model setCurrentProductIdentifier:productIdentifier];
	
	float tempAmount = (aRow + 1) - 0.01;
	[model setCurrentRechargeAmount:[NSString stringWithFormat:@"%.2f", tempAmount]];
	
	[self.navigationController popToRootViewControllerAnimated:YES];
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
	
	[self.navigationController setNavigationBarHidden:NO];
	
	Model *model = [Model sharedModel];
	inAppPaymentOptionArray = [[NSMutableArray alloc] init];
	if ([[model inAppPurchaseAllowed] isEqualToString:@"Y"]) {
//		NSLog(@"Parental-controls are disabled");
		[inAppPaymentOptionArray addObject:@"Recharge by $0.99"];
		[inAppPaymentOptionArray addObject:@"Recharge by $1.99"];
		[inAppPaymentOptionArray addObject:@"Recharge by $2.99"];
		[inAppPaymentOptionArray addObject:@"Recharge by $3.99"];
		[inAppPaymentOptionArray addObject:@"Recharge by $4.99"];
		[inAppPaymentOptionArray addObject:@"Recharge by $5.99"];
		[inAppPaymentOptionArray addObject:@"Recharge by $6.99"];
		[inAppPaymentOptionArray addObject:@"Recharge by $7.99"];
		[inAppPaymentOptionArray addObject:@"Recharge by $8.99"];
		[inAppPaymentOptionArray addObject:@"Recharge by $9.99"];
	} else {
		[inAppPaymentOptionArray addObject:@"Parental Control Purchase-locked"];
	}
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
	[inAppPaymentOptionArray release];
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
    return [inAppPaymentOptionArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	[cell.textLabel setText:[inAppPaymentOptionArray objectAtIndex:indexPath.row]];
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self purchase:indexPath.row];
}

@end
