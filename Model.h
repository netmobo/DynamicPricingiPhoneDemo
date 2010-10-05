//
//  Model.h
//  MVC
//
//  Created by Netmobo on 5/27/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject {
	// 
	NSString *isLoggedIn;
	NSString *currentAmount;
	NSString *currentPayVia;
	NSString *currentRechargeAmount;
	// card
	NSString *currentCardType;
	NSString *currentCardNum;
	NSString *currentCardMonth;
	NSString *currentCardYear;
	NSString *securityCode;
	NSString *email;
	NSString *lastName;
	NSString *firstName;
	NSString *phone;
	NSString *street;
	NSString *city;
	NSString *currentCardCountry;
	NSString *currentCardCountryCode;
	NSString *state;
	NSString *zipcode;
	// in-app purchase
	NSString *currentProductIdentifier;
	NSString *inAppPurchaseAllowed;
	
	// FeeFactor
	NSString *brandID;
	NSString *serviceID;
	NSString *serialNumber;
	NSString *userID;
	NSString *userName;
	NSString *passWord;
	NSString *accountID;
	NSString *userQuestion;
	NSString *userAnswer;
	NSString *domain;
}

// always use NSString for vars to avoid hassles
@property (nonatomic, retain) NSString *isLoggedIn;
@property (nonatomic, retain) NSString *currentAmount;
@property (nonatomic, retain) NSString *currentPayVia;
@property (nonatomic, retain) NSString *currentRechargeAmount;
// card
@property (nonatomic, retain) NSString *currentCardType;
@property (nonatomic, retain) NSString *currentCardNum;
@property (nonatomic, retain) NSString *currentCardMonth;
@property (nonatomic, retain) NSString *currentCardYear;
@property (nonatomic, retain) NSString *securityCode;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *street;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *currentCardCountry;
@property (nonatomic, retain) NSString *currentCardCountryCode;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *zipcode;
// in-app purchase
@property (nonatomic, retain) NSString *currentProductIdentifier;
@property (nonatomic, retain) NSString *inAppPurchaseAllowed;

// FeeFactor
@property (nonatomic, retain) NSString *brandID;
@property (nonatomic, retain) NSString *serviceID;
@property (nonatomic, retain) NSString *serialNumber;
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *passWord;
@property (nonatomic, retain) NSString *accountID;
@property (nonatomic, retain) NSString *userQuestion;
@property (nonatomic, retain) NSString *userAnswer;
@property (nonatomic, retain) NSString *domain;

+ (id)sharedModel;

@end
