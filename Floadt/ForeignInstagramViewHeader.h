//
//  ForeignInstagramViewHeader.h
//  Floadt
//
//  Created by Pradyumn Nukala on 7/20/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "SIAlertView.h"

@interface ForeignInstagramViewHeader : UIView
- (void)updateWithUserDetails:(InstagramUser *)user;

@property (strong,nonatomic) InstagramUser *instaUser;

@property (nonatomic, strong) UIImageView *profilePic;
@property (nonatomic, strong) UILabel * nameString;
@property (nonatomic, strong) UILabel * postCount;
@property (nonatomic, strong) UILabel * postString;
@property (nonatomic, strong) UILabel * followerCount;
@property (nonatomic, strong) UILabel * followerString;
@property (nonatomic, strong) UILabel * followingCount;
@property (nonatomic, strong) UILabel * followingString;
@property (nonatomic, strong) UILabel * bioString;
@property (nonatomic, strong) UITextView * websiteString;
@property (nonatomic, strong) UIButton *followButton;

@end
