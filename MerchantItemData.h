//
//  MerchantItemData.h
//  Aggregate
//
//  Created by Netmobo on 9/9/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MerchantItemData : NSObject {
	NSString *description;
	NSString *unitPriceAmount;
	NSString *unitPriceCurrency;
	
	// private merchant data
	NSString *sessionId;
	long accountSerialNumber;
	long paymentGatewayId;
	NSString *username;
	NSString *sourceIp;
	NSString *oldBalance;
}

@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *unitPriceAmount;
@property (nonatomic, retain) NSString *unitPriceCurrency;

// private merchant data
@property (nonatomic, retain) NSString *sessionId;
@property (nonatomic, assign) long accountSerialNumber;
@property (nonatomic, assign) long paymentGatewayId;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *sourceIp;
@property (nonatomic, retain) NSString *oldBalance;

@end
