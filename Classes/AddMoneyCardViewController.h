//
//  AddMoneyCardViewController.h
//  Aggregate
//
//  Created by Netmobo on 9/8/10.
//  Copyright 2010 Aurisoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddMoneyCardViewController : UIViewController {
	NSMutableArray *dataArray;
	NSMutableArray *detailArray;
	IBOutlet UITableView *dataTableView;
}

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSMutableArray *detailArray;

@end
