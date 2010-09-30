//
//  State.m
//  Aggregate
//
//  Created by Vicente Malixi on 9/15/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import "State.h"


@implementation State

@synthesize countryCode;
@synthesize stateCode;
@synthesize stateName;

- (void) dealloc {
	[stateName release];
	[stateCode release];
	[countryCode release];
	
	[super dealloc];
}

@end
