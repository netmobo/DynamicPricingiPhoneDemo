//
//  AddMoneyCardTextEntryViewController.m
//  Aggregate
//
//  Created by Vicente Malixi on 9/8/10.
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
