//
//  PointsHistoryTableCell.m
//  Reward
//
//  Created by Netmobo on 8/23/10.
//  Copyright 2010 Aurisoft.com. All rights reserved.
//

#import "HistoryTableCell.h"
#import "History.h"
#import "Label2.h"

@implementation HistoryTableCell

@synthesize pointsDateLabel;
@synthesize itemLabel;
@synthesize pointsLabel;

- (void)configureWith:(History *)aPointsHistory {
	self.pointsDateLabel.text = [aPointsHistory pointsDate];
    self.itemLabel.text = [aPointsHistory item];
	self.pointsLabel.text = [aPointsHistory points];
}

- (void)dealloc {
    [pointsDateLabel release];
    [itemLabel release];
    [pointsLabel release];
    [super dealloc];
}
@end
