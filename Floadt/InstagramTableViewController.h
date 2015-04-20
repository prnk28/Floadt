//
//  InstagramTableViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 1/14/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "XLPagerTabStripViewController.h"

@interface InstagramTableViewController : UITableViewController <XLPagerTabStripChildItem>

@property (nonatomic, strong) NSMutableDictionary *instagramResponse;
@property (strong, nonatomic) NSMutableArray *instaPics;

- (void)likeInstagramPictureWithID:(NSString *)idcode;
@end
