//
//  AddMoneyEditViewController.m
//  Aggregate
//
//  Created by Netmobo on 9/8/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import "AddMoneyEditViewController.h"
#import "Model.h"
#import "AddMoneyCardViewController.h"
#import "AddMoneyInAppPurchaseViewController.h"

@implementation AddMoneyEditViewController

@synthesize whichOne, whichOneLabel, payViaPicker, pickerData, amountField;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil whichOne:(NSString *) aWhichOne {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		[self setWhichOne:aWhichOne];
    }
    return self;
}

- (void) doAction {
	Model *model = [Model sharedModel];
	if ([whichOne isEqualToString:@"Amount to add"]) {
		[amountField resignFirstResponder];
		[model setCurrentRechargeAmount:[amountField text]];
		[self.navigationController popViewControllerAnimated:YES];
	} else {
		NSInteger row = [payViaPicker selectedRowInComponent:0];
		[model setCurrentPayVia:[pickerData objectAtIndex:row]];
		
		if ([[model currentPayVia] isEqualToString:@"Credit Card"]) {
			AddMoneyCardViewController *detailViewController = [[AddMoneyCardViewController alloc] initWithNibName:@"AddMoneyCardViewController" bundle:nil];
			[self.navigationController pushViewController:detailViewController animated:YES];
			[detailViewController release];
		} else {
			AddMoneyInAppPurchaseViewController *detailViewController = [[AddMoneyInAppPurchaseViewController alloc] initWithNibName:@"AddMoneyInAppPurchaseViewController" bundle:nil];
			[self.navigationController pushViewController:detailViewController animated:YES];
			[detailViewController release];
		}
	}
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self doAction];
    
    return YES;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	Model *model = [Model sharedModel];
	
	[self.navigationController setNavigationBarHidden:NO];
	
	if ([whichOne isEqualToString:@"Amount to add"]) {
		if ([[model currentPayVia] isEqualToString:@"Credit Card"]) {
			UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doAction)];
			self.navigationItem.rightBarButtonItem = doneButton;
			[doneButton release];
			
			[amountField setHidden:NO];
			
			//  Set the keyboard's return key label to 'Next'.
			//
			[amountField setReturnKeyType:UIReturnKeyDone];
			
			//  Make the clear button appear automatically.
			[amountField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation]; 
		} else {
			AddMoneyInAppPurchaseViewController *detailViewController = [[AddMoneyInAppPurchaseViewController alloc] initWithNibName:@"AddMoneyInAppPurchaseViewController" bundle:nil];
			[self.navigationController pushViewController:detailViewController animated:YES];
			[detailViewController release];
		}
		
	} else {
		// So when it goes to next screen, "Cancel" is seen as backbutton
		UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:nil];
		self.navigationItem.backBarButtonItem = backButton;
		[backButton release];
		
		UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(doAction)];
		self.navigationItem.rightBarButtonItem = doneButton;
		[doneButton release];
		
		[payViaPicker setHidden:NO];
		NSArray *array = [[NSArray alloc] initWithObjects:@"Credit Card", @"Apple In-App Purchase", nil];
		self.pickerData = array;
		[array release];
		
		[payViaPicker selectRow:[pickerData indexOfObject:[model currentPayVia]] inComponent:0 animated:YES];
	}
	whichOneLabel.text = whichOne;	
	
	
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
	[amountField release];
	[pickerData release];
	[payViaPicker release];
	[whichOneLabel release];
	[whichOne release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [pickerData count];
}

#pragma mark Picker Delegate Methods
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [pickerData objectAtIndex:row];
}

@end
