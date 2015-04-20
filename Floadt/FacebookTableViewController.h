//
//  FacebookTableViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 4/14/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "XLPagerTabStripViewController.h"

@interface FacebookTableViewController : UITableViewController<XLPagerTabStripChildItem>

@property (nonatomic, strong) NSMutableDictionary *facebookResponse;
@property (strong, nonatomic) NSMutableArray *facebookPosts;

@property (nonatomic, strong) NSMutableDictionary *facebookResponse;
@property (strong, nonatomic) NSMutableArray *facebookPosts;

@end
