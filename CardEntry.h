//
//  CardEntry.h
//  Aggregate
//
//  Created by Netmobo on 9/8/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CardEntry : NSObject {
	NSString *cardType;
	NSString *expirationDate;
	NSString *securityCode;
	NSString *email;
	NSString *lastName;
	NSString *firstName;
	NSString *phone;
	NSString *street;
	NSString *city;
	NSString *country;
	NSString *state;
	NSString *zipcode;
}

@property (nonatomic, retain) NSString *cardType;
@property (nonatomic, retain) NSString *expirationDate;
@property (nonatomic, retain) NSString *securityCode;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *street;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *zipcode;

- (id)initWithCardType: (NSString *) aCardType 
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
			   zipcode: (NSString *) aZipcode;

@end
