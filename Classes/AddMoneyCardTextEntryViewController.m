//
//  AddMoneyCardTextEntryViewController.m
//  Aggregate
//
//  Created by Vicente Malixi on 9/8/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import "AddMoneyCardTextEntryViewController.h"
#import "Model.h"

@implementation AddMoneyCardTextEntryViewController

@synthesize whichOne, whichOneLabel, entryField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil whichOne:(NSString *) aWhichOne {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		[self setWhichOne:aWhichOne];
    }
    return self;
}

- (void) doAction {
	Model *model = [Model sharedModel];
	if ([whichOne isEqualToString:@"Card Number"]) {
		if ([[entryField text] length] < 1) {
			[model setCurrentCardNum:@"no entry"];
		} else {
			[model setCurrentCardNum:[entryField text]];
		}
		
	} else if ([whichOne isEqualToString:@"Security Code"]) {
		if ([[entryField text] length] < 1) {
			[model setSecurityCode:@"no entry"];
		} else {
			[model setSecurityCode:[entryField text]];
		}
		
	} else if ([whichOne isEqualToString:@"Email"]) {
		if ([[entryField text] length] < 1) {
			[model setEmail:@"no entry"];
		} else {
			[model setEmail:[entryField text]];
		}
		
	} else if ([whichOne isEqualToString:@"Last Name"]) {
		if ([[entryField text] length] < 1) {
			[model setLastName:@"no entry"];
		} else {
			[model setLastName:[entryField text]];
		}
		
	} else if ([whichOne isEqualToString:@"First Name"]) {
		if ([[entryField text] length] < 1) {
			[model setFirstName:@"no entry"];
		} else {
			[model setFirstName:[entryField text]];
		}
		
	} else if ([whichOne isEqualToString:@"Phone"]) {
		if ([[entryField text] length] < 1) {
			[model setPhone:@"no entry"];
		} else {
			[model setPhone:[entryField text]];
		}
		
	} else if ([whichOne isEqualToString:@"Street"]) {
		if ([[entryField text] length] < 1) {
			[model setStreet:@"no entry"];
		} else {
			[model setStreet:[entryField text]];
		}
		
	} else if ([whichOne isEqualToString:@"City"]) {
		if ([[entryField text] length] < 1) {
			[model setCity:@"no entry"];
		} else {
			[model setCity:[entryField text]];
		}
		
	} else if ([whichOne isEqualToString:@"State"]) {
		if ([[entryField text] length] < 1) {
			[model setState:@"no entry"];
		} else {
			[model setState:[entryField text]];
		}
		
	} else {
		if ([[entryField text] length] < 1) {
			[model setZipcode:@"no entry"];
		} else {
			[model setZipcode:[entryField text]];
		}
		
	}
	[self.navigationController popViewControllerAnimated:YES];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
/*
 UIKeyboardTypeDefault,
 UIKeyboardTypeASCIICapable,
 UIKeyboardTypeNumbersAndPunctuation,
 UIKeyboardTypeURL,
 UIKeyboardTypeNumberPad,
 UIKeyboardTypePhonePad,
 UIKeyboardTypeNamePhonePad,
 UIKeyboardTypeEmailAddress,
 UIKeyboardTypeAlphabet = UIKeyboardTypeASCIICapable
 */
- (void)viewDidLoad {
    [super viewDidLoad];
	
	Model *model = [Model sharedModel];
	if ([[model currentCardCountry] isEqualToString:@"United States"] || 
		[[model currentCardCountry] isEqualToString:@"Canada"]) {
		NSString *tempString = [NSString stringWithFormat:@"%@ (two letter state name)", [self whichOne]];
		[[self whichOneLabel] setText:tempString];
	} else {
		[[self whichOneLabel] setText:[self whichOne]];
	}
	
	
	if ([whichOne isEqualToString:@"Card Number"]) {
		[entryField setKeyboardType:UIKeyboardTypeNumberPad];
		
	} else if ([whichOne isEqualToString:@"Security Code"]) {
		[entryField setKeyboardType:UIKeyboardTypeNumberPad];
		
	} else if ([whichOne isEqualToString:@"Email"]) {
		[entryField setKeyboardType:UIKeyboardTypeEmailAddress];
		
	} else if ([whichOne isEqualToString:@"Last Name"]) {
		[entryField setKeyboardType:UIKeyboardTypeDefault];
		
	} else if ([whichOne isEqualToString:@"First Name"]) {
		[entryField setKeyboardType:UIKeyboardTypeDefault];
		
	} else if ([whichOne isEqualToString:@"Phone"]) {
		[entryField setKeyboardType:UIKeyboardTypePhonePad];
		
	} else if ([whichOne isEqualToString:@"Street"]) {
		[entryField setKeyboardType:UIKeyboardTypeDefault];
		
	} else if ([whichOne isEqualToString:@"City"]) {
		[entryField setKeyboardType:UIKeyboardTypeDefault];
		
	} else if ([whichOne isEqualToString:@"State"]) {
		if ([[model currentCardCountry] isEqualToString:@"no entry"]) {
			
			UIAlertView *alert;
			alert = [[UIAlertView alloc] initWithTitle:@"Input Error" message:@"You must first fill in country before State" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
			[alert show];
			[alert release];
			
			[entryField setEnabled:NO];
		} else {
			if ([[model currentCardCountry] isEqualToString:@"United States"] || 
				[[model currentCardCountry] isEqualToString:@"Canada"]) {
				[entryField setAutocapitalizationType:UITextAutocapitalizationTypeAllCharacters];
			}
			[entryField setKeyboardType:UIKeyboardTypeDefault];
		}
		
	} else { // zip code
		[entryField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
		
	}
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doAction)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
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
	[whichOne release];
	[whichOneLabel release];
	[entryField release];
	
    [super dealloc];
}


@end
