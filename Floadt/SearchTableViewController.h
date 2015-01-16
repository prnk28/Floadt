//
//  SearchTableViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 11/1/14.
//  Copyright (c) 2014 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"

@interface SearchTableViewController : UITableViewController <UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *instagramResults;
@property (nonatomic, strong) NSMutableDictionary *instagramDict;
@property BOOL *instagramActive;
@property BOOL *twitterActive;
@property BOOL *facebookActive;

@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (retain, nonatomic) IBOutlet UIButton *btnMain;

@end
