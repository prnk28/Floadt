//
//  TwitterCell.h
//  Floadt
//
//  Created by Pradyumn Nukala on 10/23/14.
//  Copyright (c) 2014 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "PureLayout.h"

@interface TwitterCell : UITableViewCell

@property (nonatomic, strong) DOFavoriteButton *favoriteButton;
@property (nonatomic, strong) DOFavoriteButton *retweetButton;
@property (nonatomic, strong) UIButton *replyButton;

@property (nonatomic, strong) UILabel *tweetLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UIImageView *profilePicture;

@property (nonatomic, strong) UIImageView *clockIcon;

@property (nonatomic, strong) UILabel *timeAgo;

+ (CGSize)defaultCellSize;

@end
