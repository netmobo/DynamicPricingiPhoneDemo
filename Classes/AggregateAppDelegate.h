//
//  AggregateAppDelegate.h
//  Aggregate
//
//  Created by Netmobo on 9/3/10.
//  Copyright Aurisoft 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AggregateViewController;
@class HomeViewController;
@class LoginViewController;
@class SignUpViewController;
@class PurchasePluginsViewController;
@class AddMoneyToBalanceViewController;
@class AccountHistoryViewController;

@interface AggregateAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AggregateViewController *viewController;
	
	LoginViewController *loginViewController;
	SignUpViewController *signUpViewController;
	HomeViewController *homeViewController;
	PurchasePluginsViewController *purchasePluginsViewController;
	AddMoneyToBalanceViewController *addMoneyToBalanceViewController;
	AccountHistoryViewController *accountHistoryViewController;
	
	UINavigationController *navController;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AggregateViewController *viewController;

@property (nonatomic, retain) LoginViewController *loginViewController;
@property (nonatomic, retain) SignUpViewController *signUpViewController;
@property (nonatomic, retain) HomeViewController *homeViewController;
@property (nonatomic, retain) PurchasePluginsViewController *purchasePluginsViewController;
@property (nonatomic, retain) AddMoneyToBalanceViewController *addMoneyToBalanceViewController;
@property (nonatomic, retain) AccountHistoryViewController *accountHistoryViewController;

@property (nonatomic, retain) UINavigationController *navController;

- (void) goFrom:(NSString *) aFrom to:(NSString *) aTo;
- (void) goHome;

// FeeFactor
- (NSString *) loginWithUser:(NSString *) aUser andPassword:(NSString *) aPassword;
- (NSString *) getCurrentPoints;
- (NSMutableArray *) getPointHistory;
- (NSMutableArray *) getProducts;
- (void) chargeAccountWithBrandID:(NSNumber *)aBrandID 
						accountID:(NSString *)aAccountID 
					  serviceName:(NSString *)aServiceName 
					  productCode:(NSString *)aProductCode 
							 item:(NSString *)aItem;
- (NSString *) rechargeViaCreditCard;
- (void) rechargeViaInAppPurchaseWithAmount:(NSNumber *) aAmount andReceipt:(NSString *) aReceipt;
- (NSString *) signupUser:(NSString *) aUser 
			  andPassword:(NSString *) aPassword 
				 question:(NSString *) aQuestion 
				   answer:(NSString *) aAnswer 
					email:(NSString *) aEmail;
@end

