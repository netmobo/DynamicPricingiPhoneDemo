//
//  AddMoneyToBalanceViewController.m
//  Aggregate
//
//  Created by Netmobo on 9/7/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import "AddMoneyToBalanceViewController.h"
#import "AggregateAppDelegate.h"
#import "Model.h"
#import "AddMoneyEditViewController.h"
#import "AddMoneyInAppPurchaseViewController.h"

@implementation AddMoneyToBalanceViewController

@synthesize amountToRecharge, payVia;
@synthesize serialNumberLabel;
@synthesize amountLabel;
@synthesize activity;
@synthesize startedRecharge;

- (IBAction) doAction {
	[activity setHidden:NO];
	[activity startAnimating];
	
	[self setStartedRecharge:YES];
	
	[self doAction2];
}

- (void) doAction2 {
	[self performSelector:@selector(doRecharge) withObject:NULL afterDelay:0.0];
}

- (void) doRecharge {
	AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
	Model *model = [Model sharedModel];
	if ([[model currentPayVia] isEqualToString:@"Credit Card"]) {
		[mainDelegate rechargeViaCreditCard];
		
		[activity stopAnimating];
		[activity setHidden:YES];
		
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Recharge Successful" message:[NSString stringWithFormat:@"Balance recharged: %@", [model currentRechargeAmount]] delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[alert show];
		[alert release];
		
		[mainDelegate goFrom:@"Add Balance" to:@"Home"];
		
	} else {
		SKPayment *payment = [SKPayment paymentWithProductIdentifier:[model currentProductIdentifier]];
		[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
		[[SKPaymentQueue defaultQueue] addPayment:payment];
	}
	
//	[model setCurrentAmount:[mainDelegate getCurrentPoints]];
//	[[self amountLabel] setText:[model currentAmount]];
	
	
}


/*
 - (void) doAction {
 AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
 [mainDelegate rechargeViaCreditCard];
 
 Model *model = [Model sharedModel];
 NSString *tempAmt = [mainDelegate getCurrentPoints];
 [model setCurrentAmount:tempAmt];
 [[self amountLabel] setText:tempAmt];
 
 }
 */

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
			[mainDelegate goFrom:@"Add Balance" to:@"Home"];
		} else if (buttonIndex == 1) {
			AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
			[mainDelegate goFrom:@"Add Balance" to:@"Purchase Plugins"];
		} else if (buttonIndex == 2) {
			// already there
		} else if (buttonIndex == 3) {
			AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
			[mainDelegate goFrom:@"Add Balance" to:@"Account History"];
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
		[mainDelegate goFrom:@"Add Balance" to:@"Login"];
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
	
	[self.navigationController setNavigationBarHidden:YES];
	// so if user wants to cancel when editing, will see "Cancel" back button in AddMoneyEditView
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];
	
	Model *model = [Model sharedModel];
	[model setCurrentCardType:@"no entry"];
	[model setCurrentCardNum:@"no entry"];
	[model setSecurityCode:@"no entry"];
	[model setCurrentCardMonth:@"no entry"];
	[model setCurrentCardYear:@""];
	[model setEmail:@"no entry"];
	[model setLastName:@"no entry"];
	[model setFirstName:@"no entry"];
	[model setPhone:@"no entry"];
	[model setStreet:@"no entry"];
	[model setCity:@"no entry"];
	[model setState:@"no entry"];
	[model setCurrentCardCountry:@"no entry"];
	[model setZipcode:@"no entry"];
	
	[[self serialNumberLabel] setText:[model serialNumber]];
	[[self amountLabel] setText:[model currentAmount]];
	
	if ([SKPaymentQueue canMakePayments]) {
		[model setInAppPurchaseAllowed:@"Y"];
	} else {
		[model setInAppPurchaseAllowed:@"N"];
	}
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	
	[self.navigationController setNavigationBarHidden:YES];
	
	Model *model = [Model sharedModel];
	[self setAmountToRecharge:[NSString stringWithFormat:@"%.2f", [[model currentRechargeAmount] floatValue]]];
	[self setPayVia:[model currentPayVia]];
	
	[balanceTableView reloadData];
	
	if ([[model currentPayVia] isEqualToString:@"Apple In-App Purchase"]) {
		if ([SKPaymentQueue canMakePayments]) {
			[model setInAppPurchaseAllowed:@"Y"];
			
			NSSet *productIDs = [NSSet setWithObjects:@"com.netmobo.aurisoftdemo.planmovie_USD_1", 
								 @"com.netmobo.aurisoftdemo.planmovie_USD_2", 
								 @"com.netmobo.aurisoftdemo.planmovie_USD_3", 
								 @"com.netmobo.aurisoftdemo.planmovie_USD_4", 
								 @"com.netmobo.aurisoftdemo.planmovie_USD_5", 
								 @"com.netmobo.aurisoftdemo.planmovie_USD_6", 
								 @"com.netmobo.aurisoftdemo.planmovie_USD_7", 
								 @"com.netmobo.aurisoftdemo.planmovie_USD_8", 
								 @"com.netmobo.aurisoftdemo.planmovie_USD_9", 
								 @"com.netmobo.aurisoftdemo.planmovie_USD_10", nil];
			
			SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:productIDs];
			request.delegate = self;
			[request start];
		} else {
			[model setInAppPurchaseAllowed:@"N"];
		}
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
	[serialNumberLabel release];
	[amountLabel release];
	[activity release];
	[amountToRecharge release];
	[payVia release];
    [super dealloc];
}

#pragma mark SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
	Model *model = [Model sharedModel];
	if ([[model currentPayVia] isEqualToString:@"Apple In-App Purchase"]) {
		SKProduct *validProduct = nil;
		int count = [response.products count];
		if (count > 0) {
			validProduct = [response.products objectAtIndex:0];
//			NSLog(@"product identifier: %@ description: %@", [validProduct productIdentifier], [validProduct description]);
		} else {
			NSLog(@"no valid products available");
		}
		if ([response.invalidProductIdentifiers count]) {
			NSLog(@"received invalid product identifiers: %@", response.invalidProductIdentifiers);
		}
	}
}

#pragma mark SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
	Model *model = [Model sharedModel];
	AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
	for (SKPaymentTransaction *transaction in transactions) {
		switch (transaction.transactionState) {
			case SKPaymentTransactionStatePurchasing:
				break;
			case SKPaymentTransactionStatePurchased:
				// do web service, update balance
				//				[confirmLabel setText:@"Netmobo increment purchased"];
				[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
				
				if ([self startedRecharge] == YES) {
					[self setStartedRecharge:NO];

					[mainDelegate rechargeViaInAppPurchaseWithAmount:[NSNumber numberWithFloat:[[model currentRechargeAmount] floatValue]] 
														  andReceipt:[transaction transactionIdentifier]];
					
					[activity stopAnimating];
					[activity setHidden:YES];
					
					UIAlertView *alert;
					alert = [[UIAlertView alloc] initWithTitle:@"Recharge Successful" message:[NSString stringWithFormat:@"Balance recharged: %@", [model currentRechargeAmount]] delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
					[alert show];
					[alert release];
					
					[mainDelegate goFrom:@"Add Balance" to:@"Home"];
				}
				
				break;
			case SKPaymentTransactionStateRestored:
				//				[confirmLabel setText:@"Netmobo increment purchased"];
				[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
				
				break;
			case SKPaymentTransactionStateFailed:
				if (transaction.error.code != SKErrorPaymentCancelled) {
					NSLog(@"an error encountered");
				}
				[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
				
				break;
		}
	}
	
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	
	
	if (indexPath.row == 0) {
		cell.textLabel.text = [self payVia];
		cell.detailTextLabel.text = @"Pay via";
	} else {
		cell.textLabel.text = [self amountToRecharge];
		cell.detailTextLabel.text = @"Amount to add";
	}
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *whichOne;
	Model *model = [Model sharedModel];
	
	if (indexPath.row == 0) {
		whichOne = @"Pay via";
	} else {
		whichOne = @"Amount to add";
	}
	
	if ([whichOne isEqualToString:@"Amount to add"]) {
		if ([[model currentPayVia] isEqualToString:@"Credit Card"]) {
			AddMoneyEditViewController *detailViewController = [[AddMoneyEditViewController alloc] initWithNibName:@"AddMoneyEditViewController" bundle:nil whichOne:whichOne];
			
			[self.navigationController pushViewController:detailViewController animated:YES];
			[detailViewController release];
		} else {
			AddMoneyInAppPurchaseViewController *detailViewController = [[AddMoneyInAppPurchaseViewController alloc] initWithNibName:@"AddMoneyInAppPurchaseViewController" bundle:nil];
			[self.navigationController pushViewController:detailViewController animated:YES];
			[detailViewController release];
		}
	} else {
		AddMoneyEditViewController *detailViewController = [[AddMoneyEditViewController alloc] initWithNibName:@"AddMoneyEditViewController" bundle:nil whichOne:whichOne];
		
		[self.navigationController pushViewController:detailViewController animated:YES];
		[detailViewController release];
	}
	
}

@end
