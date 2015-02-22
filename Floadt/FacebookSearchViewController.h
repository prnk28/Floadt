//
//  FacebookSearchViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 2/6/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacebookSearchViewController : UIViewController <UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *instagramResults;
@property (nonatomic, strong) NSMutableDictionary *instagramDict;
@property BOOL *instagramActive;
@property BOOL *twitterActive;
@property BOOL *facebookActive;

@property (strong, nonatomic) UISearchBar *searchBar;

@end
