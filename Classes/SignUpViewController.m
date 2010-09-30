//
//  SignUpViewController.m
//  Aggregate
//
//  Created by Netmobo on 9/6/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import "SignUpViewController.h"
#import "AggregateAppDelegate.h"
#import "TextEntryCell.h"
#import "Entry.h"
#import "SignUp2ViewController.h"
#import "Model.h"

@implementation SignUpViewController

@synthesize textEntryCell;
@synthesize textEntryArray;
@synthesize userEntry1, userEntry2, userEntry3;

- (void) nextEdits {
	[[textEntryCell textEntryField] resignFirstResponder];
	
	SignUp2ViewController *textEntryViewController = [[SignUp2ViewController alloc] initWithNibName:@"SignUp2ViewController" bundle:nil];
	[self.navigationController pushViewController:textEntryViewController animated:YES];
	[textEntryViewController release];
	
	Model *model = [Model sharedModel];
	[model setUserName:userEntry1];
	[model setPassWord:userEntry2];
	[model setEmail:userEntry3];
}


- (IBAction) info1 {
	NSString *msg = @"This demo shows how you can add aggregated payments to your app with a prepaid account. In this demo app, additional features can be added as plug-ins. Each plugin is available as a separate purchase that gets deducted from an initial prepaid balance. Payments are made in a sandbox, with dummy payment accounts.";
	UIAlertView *alert;
	alert = [[UIAlertView alloc] initWithTitle:@"Demo Note" message:msg delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	[alert release];
}


- (void)textFieldDidChangeContent:(NSNotification *)aNotification {
	UITextField *textField = (UITextField *)[aNotification object];
	
	if (textField.tag == 1) {
		int userEntryLength = [userEntry1 length];
		[userEntry1 deleteCharactersInRange:NSMakeRange(0, userEntryLength)]; // delete "Beetle"
		[userEntry1 insertString:textField.text atIndex:0];
	} else if (textField.tag == 2) {
		int userEntryLength = [userEntry2 length];
		[userEntry2 deleteCharactersInRange:NSMakeRange(0, userEntryLength)]; // delete "Beetle"
		[userEntry2 insertString:textField.text atIndex:0];
	} else if (textField.tag == 3) {
		int userEntryLength = [userEntry3 length];
		[userEntry3 deleteCharactersInRange:NSMakeRange(0, userEntryLength)]; // delete "Beetle"
		[userEntry3 insertString:textField.text atIndex:0];
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
	
	[self.navigationController setNavigationBarHidden:NO];
	
	[self info1];
	
	[self setTextEntryArray:[[NSMutableArray alloc] init]];
	Entry *entry1 = [[Entry alloc] initWithEntryLabel:@"Username" entryContent:@"enter username"];
	Entry *entry2 = [[Entry alloc] initWithEntryLabel:@"Password" entryContent:@"enter password"];
	Entry *entry3 = [[Entry alloc] initWithEntryLabel:@"Email" entryContent:@"enter email"];
	
	[self.textEntryArray addObject:entry1];
	[self.textEntryArray addObject:entry2];
	[self.textEntryArray addObject:entry3];
	
	[entry1 release];
	[entry2 release];
	[entry3 release];
	
	//	self.title = @"Text Entry";
	self.navigationItem.title = @"Sign Up";
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];
	
	UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextEdits)];
	self.navigationItem.rightBarButtonItem = nextButton;
	[nextButton release];
	
	self.userEntry1 = [[NSMutableString alloc] init];
	self.userEntry2 = [[NSMutableString alloc] init];
	self.userEntry3 = [[NSMutableString alloc] init];
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
	[userEntry1 release];
	[userEntry2 release];
	[userEntry3 release];
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
