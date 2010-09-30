//
//  DescriptionAndNumber.m
//  Aggregate
//
//  Created by Netmobo on 9/7/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import "DescriptionAndNumber.h"


@implementation DescriptionAndNumber

@synthesize item;
@synthesize points;

- (id)initWithPointsItem:(NSString *)aItem
				  points:(NSString *)aPoint {
	self = [super init]; 
	if(nil != self) {
		self.item = aItem;
		self.points = aPoint;
	}
	return self;
}

- (void)dealloc {
	[points release];
	[item release];
	
    [super dealloc];
}

@end
