//
//  SignUp2ViewController.h
//  Aggregate
//
//  Created by Netmobo on 9/7/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TextEntryCell;
@class Entry;

@interface SignUp2ViewController : UIViewController {
	TextEntryCell *textEntryCell;
	NSMutableArray *textEntryArray;
	IBOutlet UITableView *textEntryTableView;
	
	NSMutableString *userEntry4;
	NSMutableString *userEntry5;
}

@property (nonatomic, retain) IBOutlet TextEntryCell *textEntryCell;
@property (nonatomic, retain) NSMutableArray *textEntryArray;

@property (nonatomic, retain) NSMutableString *userEntry4;
@property (nonatomic, retain) NSMutableString *userEntry5;

- (void) doneEdits;
- (IBAction) info2;

@end
