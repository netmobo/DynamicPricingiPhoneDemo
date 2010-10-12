//
//  PointsHistoryTableCell.h
//  Reward
//
//  Created by Netmobo on 8/23/10.
//  Copyright 2010 Aurisoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class History;
@class Label2;

@interface HistoryTableCell : UITableViewCell {
	IBOutlet UILabel *pointsDateLabel;
    IBOutlet Label2 *itemLabel;
    IBOutlet UILabel *pointsLabel;
}

@property (nonatomic, retain) UILabel *pointsDateLabel;
@property (nonatomic, retain) Label2 *itemLabel;
@property (nonatomic, retain) UILabel *pointsLabel;

- (void)configureWith:(History *)aPointsHistory;

@end
