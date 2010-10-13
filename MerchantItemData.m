//
//  MerchantItemData.m
//  Aggregate
//
//  Created by Netmobo on 9/9/10.
//  Copyright 2010 Netmobo. All rights reserved.
//
/*
 Copyright (c) 2010, NETMOBO LLC
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of NETMOBO LLC nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


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
