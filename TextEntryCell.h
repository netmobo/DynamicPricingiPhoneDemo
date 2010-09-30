//
//  TextEntryCell.h
//  TextEntry
//
//  Created by Netmobo on 9/7/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Entry;

@interface TextEntryCell : UITableViewCell {
	UILabel *textEntryLabel;
	UITextField *textEntryField;
}

@property (nonatomic, retain) IBOutlet UILabel *textEntryLabel;
@property (nonatomic, retain) IBOutlet UITextField *textEntryField;

@end
