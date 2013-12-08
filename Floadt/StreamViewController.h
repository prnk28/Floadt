//
//  StreamViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 11/10/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"

@interface StreamViewController : UITableViewController {

    NSString *tweetCreation;
    NSMutableDictionary *totalFeed;
    NSString *instagramCreation;
    
}

- (void)updateArrays;

// Properties
@property (nonatomic, strong) NSMutableDictionary *timelineResponse;
@property (strong, nonatomic) NSMutableArray *instaPics;
@property (strong, nonatomic) AFOAuth1Client *twitterClient;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) NSMutableArray *tweets;

@end
