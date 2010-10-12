//
//  Country.m
//  test
//
//  Created by Vicente Malixi on 9/13/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import "Country.h"


@implementation Country

@synthesize name;
@synthesize countryCode;

- (void) dealloc {
	[countryCode release];
	[name release];
	
	[super dealloc];
}

@end
