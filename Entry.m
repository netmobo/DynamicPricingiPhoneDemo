//
//  Entry.m
//  TextEntry
//
//  Created by Netmobo on 9/7/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import "Entry.h"


@implementation Entry

@synthesize entryLabel, entryContent;

- (id)initWithEntryLabel:(NSString *)aEntryLabel
				  entryContent:(NSString *)aEntryContent {
	self = [super init]; 
	if(nil != self) {
		self.entryLabel = aEntryLabel;
		self.entryContent = aEntryContent;
	}
	return self;
}

- (void)dealloc {
	[entryLabel release];
	[entryContent release];
	
    [super dealloc];
}

@end
