//
//  SignUp2ViewController.m
//  Aggregate
//
//  Created by Netmobo on 9/7/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

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
