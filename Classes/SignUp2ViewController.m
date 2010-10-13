//
//  SignUp2ViewController.m
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


#import "SignUp2ViewController.h"
#import "AggregateAppDelegate.h"
#import "TextEntryCell.h"
#import "Entry.h"
#import "Model.h"

@implementation SignUp2ViewController

@synthesize textEntryCell;
@synthesize textEntryArray;
@synthesize userEntry4, userEntry5;

- (void) doneEdits {
	Model *model = [Model sharedModel];
	
	[[textEntryCell textEntryField] resignFirstResponder];
	[model setUserQuestion:userEntry4];
	[model setUserAnswer:userEntry5];
	
	AggregateAppDelegate *mainDelegate = (AggregateAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *resultCode = [mainDelegate signupUser:[model userName] 
				 andPassword:[model passWord] 
					question:[model userQuestion] 
					  answer:[model userAnswer] 
					   email:[model email] ];
	
	if ([resultCode isEqualToString:@"none"]) {
		NSString *errorCodeMsg = [mainDelegate loginWithUser:[model userName] andPassword:[model passWord]];
		
		if ([errorCodeMsg isEqualToString:@"none"]) {
			[model setIsLoggedIn:@"Y"];
			
			[mainDelegate goHome];
		} else {
			[model setIsLoggedIn:@"N"];
			UIAlertView *alert;
			alert = [[UIAlertView alloc] initWithTitle:@"Signup Error" message:@"Sorry, signup error. Try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
	} else {
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Signup Error" message:@"Sorry, signup error. Try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

- (IBAction) info2 {
	NSString *msg = @"Please enter a question and answer that you can easily remember to help us verify your identity.";
	UIAlertView *alert;
	alert = [[UIAlertView alloc] initWithTitle:@"Signup Note" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	[alert release];
}


- (void)textFieldDidChangeContent:(NSNotification *)aNotification {
	UITextField *textField = (UITextField *)[aNotification object];
	
	if (textField.tag == 1) {
		int userEntryLength = [userEntry4 length];
		[userEntry4 deleteCharactersInRange:NSMakeRange(0, userEntryLength)]; // delete "Beetle"
		[userEntry4 insertString:textField.text atIndex:0];
	} else if (textField.tag == 2) {
		int userEntryLength = [userEntry5 length];
		[userEntry5 deleteCharactersInRange:NSMakeRange(0, userEntryLength)]; // delete "Beetle"
		[userEntry5 insertString:textField.text atIndex:0];
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
	
	[self setTextEntryArray:[[NSMutableArray alloc] init]];
	Entry *entry4 = [[Entry alloc] initWithEntryLabel:@"Question" entryContent:@"enter question"];
	Entry *entry5 = [[Entry alloc] initWithEntryLabel:@"Answer" entryContent:@"enter answer"];
	
	[self.textEntryArray addObject:entry4];
	[self.textEntryArray addObject:entry5];
	
	[entry4 release];
	[entry5 release];
	
	//	self.title = @"Text Entry";
	self.navigationItem.title = @"Sign Up";
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneEdits)];
	self.navigationItem.rightBarButtonItem = doneButton;
	[doneButton release];
	
	self.userEntry4 = [[NSMutableString alloc] init];
	self.userEntry5 = [[NSMutableString alloc] init];
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
	[userEntry4 release];
	[userEntry5 release];
	[textEntryCell release];
	[textEntryArray release];
	
    [super dealloc];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [textEntryArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ProductCellId";
	
	TextEntryCell *cell = (TextEntryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"TextEntryCell" owner:self options:nil];
		cell = self.textEntryCell;
	}
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeContent:) name:@"UITextFieldTextDidChangeNotification" object:[cell textEntryField]]; 
	
	int entryTag = indexPath.row + 1;
	
	Entry *entry = [textEntryArray objectAtIndex:indexPath.row];
	[[cell textEntryLabel] setText:[entry entryLabel]];
	[[cell textEntryField] setPlaceholder:[entry entryContent]];
	[[cell textEntryField] setTag:entryTag];
	
	return cell; 
}

@end
