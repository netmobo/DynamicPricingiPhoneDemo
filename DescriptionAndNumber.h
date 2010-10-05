//
//  DescriptionAndNumber.h
//  Aggregate
//
//  Created by Netmobo on 9/7/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DescriptionAndNumber : NSObject {
	NSString *item;
	NSString *points;
}

@property (nonatomic, retain) NSString *item;
@property (nonatomic, retain) NSString *points;

- (id)initWithPointsItem:(NSString *)aItem
				  points:(NSString *)aPoint;

@end
