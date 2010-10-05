//
//  Model.m
//  MVC
//
//  Created by Netmobo on 2/19/09.
//  Copyright 2009 Instructoons. All rights reserved.
//

#import "Model.h"

@implementation Model

@synthesize isLoggedIn;
@synthesize currentAmount;
@synthesize currentPayVia;
@synthesize currentRechargeAmount;
// card
@synthesize currentCardType;
@synthesize currentCardNum;
@synthesize currentCardMonth;
@synthesize currentCardYear;
@synthesize securityCode;
@synthesize email;
@synthesize lastName;
@synthesize firstName;
@synthesize phone;
@synthesize street;
@synthesize city;
@synthesize currentCardCountry;
@synthesize currentCardCountryCode;
@synthesize state;
@synthesize zipcode;
// in-app purchase
@synthesize currentProductIdentifier;
@synthesize inAppPurchaseAllowed;

//feefactor
@synthesize brandID;
@synthesize serviceID;
@synthesize serialNumber;
@synthesize userID;
@synthesize userName;
@synthesize passWord;
@synthesize accountID;
@synthesize userQuestion;
@synthesize userAnswer;
@synthesize domain;

- (id) init {
	self = [super init];
	if (self != nil) {
		isLoggedIn = @"N";
		currentAmount = @"0.00";
		currentPayVia = @"Credit Card";
		currentRechargeAmount = @"0.00";
		// card
		currentCardType = @"no entry";
		currentCardNum = @"no entry";
		currentCardMonth = @"no entry";
		currentCardYear = @"";
		securityCode = @"no entry";
		email = @"no entry";
		lastName = @"no entry";
		firstName = @"no entry";
		phone = @"no entry";
		street = @"no entry";
		city = @"no entry";
		currentCardCountry = @"no entry";
		currentCardCountryCode = @"";
		state = @"no entry";
		zipcode = @"no entry";
		// in-app purchase
		currentProductIdentifier = @"";
		inAppPurchaseAllowed = @"Y";
		
		// feefactor
		brandID = @"200001";
		serviceID = @"484957";
		serialNumber = @"0";
		userID = @"0";
		userName = @"";
		passWord = @"";
		accountID = @"";
		userQuestion = @"";
		userAnswer = @"";
		domain = @"200001.feefactor.com";
	}
	return self;
}


- (void) dealloc {
	// feefactor
	[accountID release];
	[userName release];
	[passWord release];
	[userID release];
	[serialNumber release];
	[serviceID release];
	[brandID release];
	[userQuestion release];
	[userAnswer release];
	[domain release];
	
	// card
	[currentCardType release];
	[currentCardNum release];
	[currentCardMonth release];
	[currentCardYear release];
	[securityCode release];
	[email release];
	[lastName release];
	[firstName release];
	[phone release];
	[street release];
	[city release];
	[currentCardCountry release];
	[currentCardCountryCode release];
	[state release];
	[zipcode release];
	// in-app purchase
	[currentProductIdentifier release];
	[inAppPurchaseAllowed release];
	
	[currentRechargeAmount release];
	[currentPayVia release];
	[currentAmount release];
	[isLoggedIn release];
	
	[super dealloc];
}

static Model *sharedMyModel = nil; 

+ (id) sharedModel { 
	@synchronized(self) { 
		if (sharedMyModel == nil) { 
			[[self alloc] init]; 
		} 
	} 
	
	return sharedMyModel; 
} 

+ (id) allocWithZone:(NSZone *)zone { 
	@synchronized(self) { 
		if (sharedMyModel == nil) { 
			sharedMyModel = [super allocWithZone:zone]; 
			return sharedMyModel; 
		} 
	} 
	
	return nil; 
} 

- (id) copyWithZone:(NSZone *)zone { 
	return self; 
} 

- (id) retain { 
	return self; 
} 

- (unsigned) retainCount { 
	return UINT_MAX; 
} 

- (void) release { 
} 

- (id) autorelease { 
	return self; 
}

@end
