//
//  SignUpViewController.h
//  Aggregate
//
//  Created by Netmobo on 9/6/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TextEntryCell;
@class Entry;

@interface SignUpViewController : UIViewController <UITableViewDataSource> {
	TextEntryCell *textEntryCell;
	NSMutableArray *textEntryArray;
	IBOutlet UITableView *textEntryTableView;
	
	NSMutableString *userEntry1;
	NSMutableString *userEntry2;
	NSMutableString *userEntry3;
}

@property (nonatomic, retain) IBOutlet TextEntryCell *textEntryCell;
@property (nonatomic, retain) NSMutableArray *textEntryArray;

@property (nonatomic, retain) NSMutableString *userEntry1;
@property (nonatomic, retain) NSMutableString *userEntry2;
@property (nonatomic, retain) NSMutableString *userEntry3;

- (void) nextEdits;
- (IBAction) info1;

@end
