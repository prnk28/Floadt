//
//  TwitterRetweetCell.h
//  Floadt
//
//  Created by Pradyumn Nukala on 8/20/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "PureLayout.h"
#import "RetweetLabel.h"
#import "FavoriteLabel.h"
#import "Floadt-Swift.h"

@interface TwitterRetweetCell : UITableViewCell

@property (nonatomic, strong) UILabel *retweetedLabel;

@property (nonatomic, strong) DOFavoriteButton *favoriteButton;
@property (nonatomic, strong) DOFavoriteButton *retweetButton;
@property (nonatomic, strong) UIButton *replyButton;

@property (nonatomic, strong) FavoriteLabel *favoritesLabel;
@property (nonatomic, strong) RetweetLabel *retweetsLabel;

@property (nonatomic, strong) UILabel *tweetLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UIImageView *profilePicture;

@property (nonatomic, strong) UIImageView *clockIcon;

@property (nonatomic, strong) UILabel *timeAgo;

+ (CGSize)defaultCellSize;

@end
