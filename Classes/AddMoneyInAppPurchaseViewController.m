//
//  AddMoneyInAppPurchaseViewController.m
//  Aggregate
//
//  Created by Vicente Malixi on 9/20/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import "AddMoneyInAppPurchaseViewController.h"
#import "AggregateAppDelegate.h"
#import "Model.h"

@implementation AddMoneyInAppPurchaseViewController

@synthesize inAppPaymentOptionArray;

- (void) purchase:(int) aRow {
	Model *model = [Model sharedModel];
	int productIdentifierInt = aRow + 1;
	NSString *productIdentifier = [NSString stringWithFormat:@"com.netmobo.aurisoftdemo.planmovie_USD_%i", productIdentifierInt];
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
	
	inAppPaymentOptionArray = [[NSMutableArray alloc] init];
//	if ([[model inAppPurchaseAllowed] isEqualToString:@"Y"]) {
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
//	} else {
//		[inAppPaymentOptionArray addObject:@"Parental Control Purchase-locked"];
//	}
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
