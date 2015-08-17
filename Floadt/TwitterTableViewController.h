//
//  TwitterTableViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 1/14/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "XLPagerTabStripViewController.h"
#import "AFOAuth1Client.h"

@interface TwitterTableViewController : UITableViewController <XLPagerTabStripChildItem>

@property (nonatomic, strong) NSMutableDictionary *twitterResponse;
@property (strong, nonatomic) NSMutableArray *tweets;
@property (strong, nonatomic) NSDictionary *userLookup;
@property (strong, nonatomic) AFOAuth1Client *twitterClient;

@end
