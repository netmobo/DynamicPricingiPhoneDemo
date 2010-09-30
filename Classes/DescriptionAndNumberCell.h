//
//  DescriptionAndNumberCell.h
//  Aggregate
//
//  Created by Netmobo on 9/7/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DescriptionAndNumber;
@class Label2;

@interface DescriptionAndNumberCell : UITableViewCell {
	IBOutlet Label2 *itemLabel;
    IBOutlet UILabel *pointsLabel;
}

@property (nonatomic, retain) Label2 *itemLabel;
@property (nonatomic, retain) UILabel *pointsLabel;

- (void)configureWith:(DescriptionAndNumber *)aDescriptionAndNumber;

@end
