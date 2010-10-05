//
//  DescriptionAndNumberCell.m
//  Aggregate
//
//  Created by Netmobo on 9/7/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import "DescriptionAndNumberCell.h"
#import "DescriptionAndNumber.h"
#import "Label2.h"

@implementation DescriptionAndNumberCell

@synthesize itemLabel;
@synthesize pointsLabel;

- (void)configureWith:(DescriptionAndNumber *)aDescriptionAndNumber {
    self.itemLabel.text = [aDescriptionAndNumber item];
	self.pointsLabel.text = [NSString stringWithFormat:@"%.2f", [[aDescriptionAndNumber points] floatValue] ];
}

- (void)dealloc {
    [itemLabel release];
    [pointsLabel release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
