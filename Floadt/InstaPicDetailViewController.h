//
//  InstaPicDetailViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 11/19/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//
#import "Data.h"
#import <UIKit/UIKit.h>

@interface InstaPicDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *ImagesLabel;
@property (strong, nonatomic) IBOutlet UILabel *FollowersLabel;
@property (strong, nonatomic) IBOutlet UILabel *FollowingLabel;
@property (strong, nonatomic) IBOutlet UILabel *ImagesCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *FollowersCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *FollowingCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *caption;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UIImageView *profilePicture;

@property (strong, nonatomic) id detailItem;

@end
