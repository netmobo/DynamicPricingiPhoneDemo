//
//  AggregateAppDelegate.m
//  Aggregate
//
//  Created by Netmobo on 9/3/10.
//  Copyright Netmobo 2010. All rights reserved.
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


#import "AggregateAppDelegate.h"
#import "Model.h"
#import "AggregateViewController.h"
#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "HomeViewController.h"
#import "PurchasePluginsViewController.h"
#import "AddMoneyToBalanceViewController.h"
#import "AccountHistoryViewController.h"
#import "History.h"
#import "PurchaseProducts.h"

// FeeFactor
#import "NetmoboFeefactorModel.h"

#import "RestTransport3.h"
#import "XmlParser.h"
#import "GDataXMLNode.h"
#import "Account.h"
#import "Accounts.h"
#import "BrandServices.h"
#import "BrandProduct.h"
#import "BrandProductPrice.h"
#import "Transactions.h"

#import "UserCard.h"
#import "CardPayments.h"
#import "PaymentGateway.h"
#import "PaymentGatewaySearchResult.h"
#import "User.h"
#import "Users.h"
#import "SelfSignUp.h"
#import "UserQuestion.h"

@implementation AggregateAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize loginViewController;
@synthesize signUpViewController;
@synthesize homeViewController;
@synthesize navController;
@synthesize purchasePluginsViewController;
@synthesize addMoneyToBalanceViewController;
@synthesize accountHistoryViewController;

#pragma mark -
#pragma mark Fee Factor Methods

- (NSString *) loginWithUser:(NSString *) aUser andPassword:(NSString *) aPassword {
	NetmoboFeefactorModel *netmoboFeefactorModel = [NetmoboFeefactorModel sharedModel];
	Model *model = [Model sharedModel];
	
	[netmoboFeefactorModel setSchema:@"http"];
	[netmoboFeefactorModel setHost:@"70.42.72.151"];
	[netmoboFeefactorModel setPort:@"12345"]; 
	[netmoboFeefactorModel setServiceUrl:@"/feefactor/rest"];
	[netmoboFeefactorModel setUserName:[NSString stringWithFormat:@"%@|%@", [model brandID], aUser] ];
	[netmoboFeefactorModel setPassWord:aPassword];
	[netmoboFeefactorModel setEncode:@"UTF-8"];
	[netmoboFeefactorModel setRealm:@"feefactor"];
	
	Accounts *accountsInterface = [[Accounts alloc] init];
	NSArray *accounts = [[accountsInterface getAccounts:@"" andSort:@"" andPageItems:[NSNumber numberWithInt:1] andPageNumber:[NSNumber numberWithInt:1]] accountResults];
	
	if ([[netmoboFeefactorModel errorCode] isEqualToString:@"none"]) {
		Account *account = [accounts objectAtIndex:0];
		[model setUserID:[account.userID stringValue]];
		[model setSerialNumber:[account.serialNumber stringValue]];	
		[model setAccountID:account.accountID];
//		[model setUserName:[NSString stringWithFormat:@"%@|%@", [model brandID], aUser]];
		[model setUserName:aUser];
		[model setPassWord:aPassword];
	}
	return [netmoboFeefactorModel errorCode];
}

- (NSString *) signupUser:(NSString *) aUser 
			  andPassword:(NSString *) aPassword 
				 question:(NSString *) aQuestion 
				   answer:(NSString *) aAnswer 
					email:(NSString *) aEmail {
	NetmoboFeefactorModel *netmoboFeefactorModel = [NetmoboFeefactorModel sharedModel];
	Model *model = [Model sharedModel];
	
	[netmoboFeefactorModel setSchema:@"http"];
	[netmoboFeefactorModel setHost:@"70.42.72.151"];
	[netmoboFeefactorModel setPort:@"12345"]; 
	[netmoboFeefactorModel setServiceUrl:@"/feefactor/rest"];
	[netmoboFeefactorModel setUserName:[NSString stringWithFormat:@"brand|%@", [model brandID]] ];
	[netmoboFeefactorModel setPassWord:[model domain]];
	[netmoboFeefactorModel setEncode:@"UTF-8"];
	[netmoboFeefactorModel setRealm:@"feefactor"];
	
	User *newUser = [[User alloc] init];
	[newUser setUsername:aUser];
	[newUser setPassword:aPassword];
	[newUser setBillingEmailAddress:aEmail];
	[newUser setBrandID:[model brandID]];
	[newUser setBillingSchedule:@"59 11 01 * * *"];
	
	SelfSignUp *newSignup = [[SelfSignUp alloc] init];
	
	NSNumber *newUserID = [NSNumber numberWithInt:[newSignup insertUser:newUser andParams:@"new user signup"]];
	
	if ([[netmoboFeefactorModel errorCode] isEqualToString:@"none"]) {
	
		// start: optional
		
		[model setUserName:aUser];
		[model setPassWord:aPassword];
		
		[netmoboFeefactorModel setSchema:@"http"];
		[netmoboFeefactorModel setHost:@"70.42.72.151"];
		[netmoboFeefactorModel setPort:@"12345"]; 
		[netmoboFeefactorModel setServiceUrl:@"/feefactor/rest"];
		[netmoboFeefactorModel setUserName:[NSString stringWithFormat:@"%@|%@", [model brandID], aUser] ];
		[netmoboFeefactorModel setPassWord:aPassword];
		[netmoboFeefactorModel setEncode:@"UTF-8"];
		[netmoboFeefactorModel setRealm:@"feefactor"];
		
		UserQuestion *newUserQuestion = [[UserQuestion alloc] init];
		[newUserQuestion setUserID:newUserID];
		[newUserQuestion setQuestion:aQuestion];
		[newUserQuestion setAnswer:aAnswer];
		
		Users *newUsers = [[Users alloc] init];
		NSNumber *newQuestionID = [NSNumber numberWithInt:[newUsers insertUserQuestion:newUserQuestion withReason:@"new user signup"]];
		
		[newUserQuestion setQuestionID:newQuestionID];
		
		// end optional
		[netmoboFeefactorModel setErrorCode:@"none"];
		return @"none"; // no error despite erroneous error generated by insertUserQuestion method
	} else {
		return [netmoboFeefactorModel errorCode];
	}
	
//	[newUsers release];
//	[newUserQuestion release];
//	[newSignup release];
//	[newUser release];
		
	
}

- (NSString *) getCurrentPoints {
	Accounts *accountsInterface = [[Accounts alloc] init];
	NSArray *accounts = [[accountsInterface getAccounts:@"" andSort:@"" andPageItems:[NSNumber numberWithInt:1] andPageNumber:[NSNumber numberWithInt:1]] accountResults];
	Account *account = [accounts objectAtIndex:0];
	float tempNum = [account.balance floatValue] - [account.creditLimit floatValue];
	
	return [NSString stringWithFormat:@"%.2f", tempNum];
}

- (NSMutableArray *) getPointHistory {
	Model *model = [Model sharedModel];
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	
	Accounts *accountsInterface = [[Accounts alloc] init];
	
	NSArray *accountHistories = [[accountsInterface getAccountHistories:[NSNumber numberWithInt:[[model serialNumber] intValue]] andCondition:@"" andSort:@"transactionDate DESC" andPageItems:[NSNumber numberWithInt:20] andPageNumber:[NSNumber numberWithInt:1]] accountHistoryResults];
	
	for (int i=0; i < [accountHistories count]; i++) {
		AccountHistory *accountHistory = [accountHistories objectAtIndex:i];
		
		// format pointsHistoryDate: 2010-07-08T16:38:47.235Z -> 2010-07-08
		NSString *tempString = [accountHistory transactionDate];
		NSString *separatorString = @"T";
		NSScanner *aScanner = [NSScanner scannerWithString:tempString];
		NSString *pDate;
		[aScanner scanUpToString:separatorString intoString:&pDate];
		// end format
		
		// format time, 2010-07-08T16:38:47.235Z -> 16:38
		int tempLocation0;
		NSString *tempString0 = [accountHistory transactionDate];
		NSRange range0 = [tempString0 rangeOfString:@"T"];
		tempLocation0 = range0.location + range0.length;
		NSString *pTimeTemp = [tempString0 substringFromIndex:tempLocation0];
		
		NSString *separatorString0 = @".";
		NSScanner *aScanner0 = [NSScanner scannerWithString:pTimeTemp];
		NSString *pTime;
		[aScanner0 scanUpToString:separatorString0 intoString:&pTime];
		// end time
		
		NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
		[dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
		NSDate *date = [dateFormat dateFromString:[NSString stringWithFormat:@"%@ %@", pDate, pTime]]; 
		[dateFormat setDateFormat:@"dd/MM/yyyy h:mm a"];
		NSString *dateTimeString = [dateFormat stringFromDate:date];
		[dateFormat release];
		
		History *aPointsHistory = [[History alloc] init];
		aPointsHistory.pointsDate = dateTimeString;

		// format item, remove "[1] " (# of sessions)
		NSString *tempString2 = [accountHistory description];
		NSRange range = [tempString2 rangeOfString:@"] "];
		if (range.location != NSNotFound ) {
			int tempLocation = range.location + range.length;
			aPointsHistory.item = [tempString2 substringFromIndex:tempLocation];
		} else {
			aPointsHistory.item = [accountHistory description];
		}
		// end format
		
		aPointsHistory.points = [[accountHistory amountChange] stringValue];
		aPointsHistory.points = [NSString stringWithFormat:@"%.2f", [[accountHistory amountChange] floatValue] ];
		
		[tempArray addObject:aPointsHistory];
		[aPointsHistory release];
	}
	
	return [tempArray autorelease];
}

- (NSMutableArray *) getProducts {
	Model *model = [Model sharedModel];
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	
	BrandServices *brandserviceInterface = [[BrandServices alloc] init];
	NSArray *brandProducts = [[brandserviceInterface getBrandProducts:[NSNumber numberWithInt:[[model serviceID] intValue]] andWhere:@"upper(productcode) like 'PLUG%'" andSort:@"" andPageItems:[NSNumber numberWithInt:0] andPageNumber:[NSNumber numberWithInt:0]] brandProducts];
	BrandService *brandService = [brandserviceInterface getBrandService:[NSNumber numberWithInt:[[model serviceID] intValue]]];
	NSString *aServiceName = [brandService serviceName];
	
	for (int i=0; i < [brandProducts count]; i++) {
		PurchaseProducts *aProducts = [[PurchaseProducts alloc] init];
		
		BrandProduct *brandProduct = [brandProducts objectAtIndex:i];
		aProducts.serviceName = aServiceName;
		aProducts.productCode = [brandProduct productCode]; 
		aProducts.item = [brandProduct description];
		NSArray *brandProductPrices = [[brandserviceInterface getBrandProductPrices:[brandProduct productID] andWhere:@"" andSort:@"" andPageItems:[NSNumber numberWithInt:0] andPageNumber:[NSNumber numberWithInt:0]] results];
		BrandProductPrice *brandProductPrice = [brandProductPrices objectAtIndex:0];
		
		aProducts.points = [NSString stringWithFormat:@"%.2f", [[brandProductPrice price] floatValue]];
		[tempArray addObject:aProducts];
		[aProducts release];
	}
	
	return [tempArray autorelease];
}

- (void) chargeAccountWithBrandID:(NSNumber *)aBrandID 
						accountID:(NSString *)aAccountID 
					  serviceName:(NSString *)aServiceName 
					  productCode:(NSString *)aProductCode 
							 item:(NSString *)aItem {
	Transactions *transactionInterface = [[Transactions alloc] init];
	[transactionInterface chargeAccount:aBrandID accountID:aAccountID serviceName:aServiceName productCode:aProductCode quantity:[NSNumber numberWithInt:1]  reason:aItem];
}

- (NSString *) rechargeViaCreditCard {
	NetmoboFeefactorModel *netmoboFeefactorModel = [NetmoboFeefactorModel sharedModel];
	Model *model = [Model sharedModel];
	
	CardPayments *gatewayInterface = [[CardPayments alloc] init];
	NSArray *gateways = [[gatewayInterface getBrandPaymentGateways:@"" andSort:@"" andPageItems:[NSNumber numberWithInt:10] andPageNumber:[NSNumber numberWithInt:1]] paymentGatewayInfoSearchResult];
	
	NSString *result;
	NSString *sandboxGatewayID;

	for (int x = 0; x < [gateways count]; x++) {
		PaymentGateway *onesample = [gateways objectAtIndex:x];
		if ([[onesample type] isEqualToString:@"SANDBOX"]) {
			sandboxGatewayID = [[onesample paymentGatewayID] stringValue];
		}
//		NSLog(@"gateways: paymentGatewayID: %@ type: %@", [onesample paymentGatewayID], [onesample type]);
	}
	
	long cardHistoryID;
	if ([[netmoboFeefactorModel errorCode] isEqualToString:@"none"]) {
		cardHistoryID = [gatewayInterface rechargeAccountViaCC:sandboxGatewayID 
									withSerial:[NSNumber numberWithLong:[[model serialNumber] longLongValue]] 
									   andLoad:[NSNumber numberWithFloat:[[model currentRechargeAmount] floatValue]] 
								   anFirstName:[model firstName] 
								   andLastName:[model lastName] 
									  andEmail:[model email] 
									  andPhone:[model phone]  
									  andAddr1:[model street] 
									  andAddr2:@"" 
									   andCity:[model city] 
									  andState:[model state] 
										andZip:[model zipcode] 
									andCountry:[model currentCardCountryCode] 
									andCardNum:[model currentCardNum] 
								   andExpMonth:[model currentCardMonth] 
									andExpYear:[model currentCardYear] 
								   andCardType:[model currentCardType] 
										andCvv:[model securityCode] 
								 andDescripion:@"" 
						  andMerchantDescriptor:@"" 
							   andMerchantPhone:@"" 
									andComment:@"" 
									 andReason:@""];
		
		result = [NSString stringWithFormat:@"%l", cardHistoryID];
		
	} else {
		result = [netmoboFeefactorModel errorCode];
	}
//	[gatewayInterface release];
	
	return result;
}

// -(int)rechargeAccountManual:(NSNumber *)serialNumber withAmount:(NSNumber *) amount withReferentceID:(NSString *) referenceID withTransactionType:(NSString *)transactionType andReason:(NSString *)reason{
- (void) rechargeViaInAppPurchaseWithAmount:(NSNumber *) aAmount andReceipt:(NSString *) aReceipt {
	NetmoboFeefactorModel *netmoboFeefactorModel = [NetmoboFeefactorModel sharedModel];
	Model *model = [Model sharedModel];
	
	[netmoboFeefactorModel setUserName:@"gabo_ba" ];
	[netmoboFeefactorModel setPassWord:@"2e39abad0f271bc8dc27917e142be998"];
	
	Accounts *accountsInterface = [[Accounts alloc] init];
	
	[accountsInterface rechargeAccountManual:[NSNumber numberWithLong:[[model serialNumber] longLongValue]] 
												 withAmount:aAmount 
										   withReferenceID:aReceipt 
										withTransactionType:@"Apple In-App Purchase" 
												  andReason:@"Recharge via Apple In-App Purchase"];
	
	[netmoboFeefactorModel setUserName:[NSString stringWithFormat:@"%@|%@", [model brandID], [model userName]] ];
	[netmoboFeefactorModel setPassWord:[model passWord]];
}

#pragma mark -
#pragma mark View Methods

- (void) goFrom:(NSString *) aFrom to:(NSString *) aTo {
	if ([aFrom isEqualToString:@"Login"]) {
		[navController.view removeFromSuperview];
		[navController release];
		navController = nil;
	} else if ([aFrom isEqualToString:@"Home"]) {
		[homeViewController.view removeFromSuperview];
		[homeViewController release];
		homeViewController = nil;
	} else if ([aFrom isEqualToString:@"Purchase Plugins"]) {
		[purchasePluginsViewController.view removeFromSuperview];
		[purchasePluginsViewController release];
		purchasePluginsViewController = nil;
	} else if ([aFrom isEqualToString:@"Add Balance"]) {
		[addMoneyToBalanceViewController.view removeFromSuperview];
		[addMoneyToBalanceViewController release];
		addMoneyToBalanceViewController = nil;
	} else if ([aFrom isEqualToString:@"Account History"]) {
		[accountHistoryViewController.view removeFromSuperview];
		[accountHistoryViewController release];
		accountHistoryViewController = nil;
	} 
	
	if ([aTo isEqualToString:@"Home"]) {
		HomeViewController *tempView = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
		self.homeViewController = tempView;
		[tempView release];
		[self.window addSubview:[homeViewController view]];
		
	} else if ([aTo isEqualToString:@"Login"]) {
		navController = [[UINavigationController alloc] init];
		navController.navigationBar.tintColor = [UIColor blackColor];
		
		LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
		[navController pushViewController:loginView animated:NO];
		[loginView release];
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:1.5];
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:window cache:NO];
		[self.window addSubview:[navController view]];
		[UIView commitAnimations];
		
	} else if ([aTo isEqualToString:@"Purchase Plugins"]) {
		PurchasePluginsViewController *tempView = [[PurchasePluginsViewController alloc] initWithNibName:@"PurchasePluginsViewController" bundle:nil];
		self.purchasePluginsViewController = tempView;
		[tempView release];
		[self.window addSubview:[purchasePluginsViewController view]];
	} else if ([aTo isEqualToString:@"Add Balance"]) {
		navController = [[UINavigationController alloc] init];
		navController.navigationBar.tintColor = [UIColor blackColor];
		
		AddMoneyToBalanceViewController *tempView = [[AddMoneyToBalanceViewController alloc] initWithNibName:@"AddMoneyToBalanceViewController" bundle:nil];
		[navController pushViewController:tempView animated:NO];
		[tempView release];
		[self.window addSubview:[navController view]];
	} else if ([aTo isEqualToString:@"Account History"]) {
		AccountHistoryViewController *tempView = [[AccountHistoryViewController alloc] initWithNibName:@"AccountHistoryViewController" bundle:nil];
		self.accountHistoryViewController = tempView;
		[tempView release];
		[self.window addSubview:[accountHistoryViewController view]];
	}
	
}

- (void) goHome {
	HomeViewController *tempView = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
	self.homeViewController = tempView;
	[tempView release];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.5];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:window cache:NO];
	[navController.view removeFromSuperview];
	[self.window addSubview:[homeViewController view]];
	[UIView commitAnimations];
	[navController release];
	navController = nil;
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
	Model *model = [Model sharedModel];
	if ([[model isLoggedIn] isEqualToString:@"Y"]) {
		HomeViewController *tempView = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
		self.homeViewController = tempView;
		[tempView release];
		[window addSubview:[homeViewController view]];
	} else {
		navController = [[UINavigationController alloc] init];
		navController.navigationBar.tintColor = [UIColor blackColor];
		
		LoginViewController *loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
		[navController pushViewController:loginView animated:NO];
		[loginView release];
		[self.window addSubview:[navController view]];
	}
	[window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	// feefactor
	
	[accountHistoryViewController release];
	[addMoneyToBalanceViewController release];
	[purchasePluginsViewController release];
	[navController release];
	[signUpViewController release];
	[loginViewController release];
	[homeViewController release];
    [viewController release];
    [window release];
    [super dealloc];
}


@end
