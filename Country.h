//
//  Country.h
//  test
//
//  Created by Vicente Malixi on 9/13/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Country : NSObject {
	NSString *name;
	NSString *countryCode;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *countryCode;

@end
