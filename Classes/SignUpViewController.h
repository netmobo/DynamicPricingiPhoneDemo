//
//  SignUpViewController.h
//  Aggregate
//
//  Created by Netmobo on 9/6/10.
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


#import <UIKit/UIKit.h>
@class TextEntryCell;
@class Entry;

@interface SignUpViewController : UIViewController <UITableViewDataSource> {
	TextEntryCell *textEntryCell;
	NSMutableArray *textEntryArray;
	IBOutlet UITableView *textEntryTableView;
	
	NSMutableString *userEntry1;
	NSMutableString *userEntry2;
	NSMutableString *userEntry3;
}

@property (nonatomic, retain) IBOutlet TextEntryCell *textEntryCell;
@property (nonatomic, retain) NSMutableArray *textEntryArray;

@property (nonatomic, retain) NSMutableString *userEntry1;
@property (nonatomic, retain) NSMutableString *userEntry2;
@property (nonatomic, retain) NSMutableString *userEntry3;

- (void) nextEdits;
- (IBAction) info1;

@end
