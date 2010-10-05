//
//  State.h
//  Aggregate
//
//  Created by Vicente Malixi on 9/15/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface State : NSObject {
	NSString *countryCode;
	NSString *stateCode;
	NSString *stateName;
}

@property (nonatomic, retain) NSString *countryCode;
@property (nonatomic, retain) NSString *stateCode;
@property (nonatomic, retain) NSString *stateName;

@end
