//
//  TextEntryCell.m
//  TextEntry
//
//  Created by Netmobo on 9/7/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import "TextEntryCell.h"
#import "Entry.h"

@implementation TextEntryCell

@synthesize textEntryLabel, textEntryField;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:NO];
	
    // Configure the view for the selected state
	[self setSelectionStyle:UITableViewCellSelectionStyleNone];
}


- (void)dealloc {
	[textEntryLabel release];
	[textEntryField release];
	
    [super dealloc];
}


@end
