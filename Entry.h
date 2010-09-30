//
//  Entry.h
//  TextEntry
//
//  Created by Netmobo on 9/7/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Entry : NSObject {
	NSString *entryLabel;
	NSString *entryContent;
}

@property (nonatomic, retain) NSString *entryLabel;
@property (nonatomic, retain) NSString *entryContent;

- (id)initWithEntryLabel:(NSString *)aEntryLabel
			entryContent:(NSString *)aEntryContent;

@end
