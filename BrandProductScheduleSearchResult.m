//
//  BrandProductScheduleSearchResult.m
//  FeeFactor
//
//  Created by Netmobo on 6/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BrandProductScheduleSearchResult.h"


@implementation BrandProductScheduleSearchResult

@synthesize brandProductSchedules;

- (void)dealloc
{
	[brandProductSchedules release];
	brandProductSchedules = nil;

	[super dealloc];
}

@end