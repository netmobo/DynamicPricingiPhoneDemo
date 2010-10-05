//
//  CardEntry.m
//  Aggregate
//
//  Created by Netmobo on 9/8/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import "CardEntry.h"


@implementation CardEntry

@synthesize cardType;
@synthesize expirationDate;
@synthesize securityCode;
@synthesize email;
@synthesize lastName;
@synthesize firstName;
@synthesize phone;
@synthesize street;
@synthesize city;
@synthesize country;
@synthesize state;
@synthesize zipcode;

- (id)initWithCardType:(NSString *) aCardType 
		expirationDate: (NSString *) aExpirationDate 
		  securityCode: (NSString *) aSecurityCode 
				 email: (NSString *) aEmail 
			  lastName: (NSString *) aLastName 
			 firstName: (NSString *) aFirstName 
				 phone: (NSString *) aPhone 
				street: (NSString *) aStreet 
				  city: (NSString *) aCity 
			   country: (NSString *) aCountry 
				 state: (NSString *) aState 
			   zipcode: (NSString *) aZipcode {
	self = [super init]; 
	if(nil != self) {
		self.cardType = aCardType; 
		self.expirationDate = aExpirationDate; 
		self.securityCode = aSecurityCode; 
		self.email = aEmail; 
		self.lastName = aLastName; 
		self.firstName = aFirstName; 
		self.phone = aPhone; 
		self.street = aStreet; 
		self.city = aCity; 
		self.country = aCountry; 
		self.state = aState; 
		self.zipcode = aZipcode; 
	}
	return self;
}

- (void)dealloc {
	[cardType release];
	[expirationDate release];
	[securityCode release];
	[email release];
	[lastName release];
	[firstName release];
	[phone release];
	[street release];
	[city release];
	[country release];
	[state release];
	[zipcode release];
	
    [super dealloc];
}

@end
