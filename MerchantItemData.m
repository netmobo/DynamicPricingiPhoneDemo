//
//  MerchantItemData.m
//  Aggregate
//
//  Created by Netmobo on 9/9/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import "MerchantItemData.h"
#import <QuartzCore/QuartzCore.h>

@implementation MerchantItemData

@synthesize description;
@synthesize unitPriceAmount;
@synthesize unitPriceCurrency;

// private merchant data
@synthesize sessionId;
@synthesize accountSerialNumber;
@synthesize paymentGatewayId;
@synthesize username;
@synthesize sourceIp;
@synthesize oldBalance;

- (NSString *) getItemXml {
	NSMutableString *sb = [[NSMutableString alloc] init];
	
	[sb appendString:@"<item>"];
	
	[sb appendString:[NSString stringWithFormat:@"<item-name>%d</item-name>", accountSerialNumber]];
	[sb appendString:[NSString stringWithFormat:@"<item-description>%@</item-description>", description]];
	[sb appendString:[NSString stringWithFormat:@"<unit-price currency=\"%@\">%@</unit-price>", unitPriceCurrency, unitPriceAmount]];
	[sb appendString:@"<quantity>1</quantity>"];
	[sb appendString:[NSString stringWithFormat:@"<merchant-item-id>%d</merchant-item-id>", accountSerialNumber]];
	
	// private data...
	[sb appendString:@"<merchant-private-item-data>"];

	[sb appendString:[NSString stringWithFormat:@"<sessionID>%@</sessionID>", sessionId]];
	[sb appendString:[NSString stringWithFormat:@"<payeeID>%@</payeeID>", accountSerialNumber]];
	[sb appendString:[NSString stringWithFormat:@"<pgid>%@</pgid>", paymentGatewayId]];
	[sb appendString:[NSString stringWithFormat:@"<username>%@</username>", username]];
	[sb appendString:@"<targetLevel>Account</targetLevel>"];
	[sb appendString:[NSString stringWithFormat:@"<sourceIP>%@</sourceIP>", sourceIp]];
	[sb appendString:[NSString stringWithFormat:@"<oldBalance>%@</oldBalance>", oldBalance]];
	[sb appendString:[NSString stringWithFormat:@"<startTime>%@</startTime>", CACurrentMediaTime()]];

	[sb appendString:@"</merchant-private-item-data>"];

	[sb appendString:@"</item>"];

	return sb;
}

/* note: accountSerialNumber and paymentGatewayId are not type object so no need to release */
- (void)dealloc {
	[description release];
	[unitPriceAmount release];
	[unitPriceCurrency release];
	
	// private merchant data
	[sessionId release];
	[username release];
	[sourceIp release];
	[oldBalance release];
	
    [super dealloc];
}

@end
