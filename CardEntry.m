//
//  CardEntry.m
//  Aggregate
//
//  Created by Netmobo on 9/8/10.
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
