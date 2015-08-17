//
//  TwitterCell.m
//  Floadt
//
//  Created by Pradyumn Nukala on 10/23/14.
//  Copyright (c) 2014 Floadt. All rights reserved.
//

#import "TwitterCell.h"

@implementation TwitterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clockIcon = [[UIImageView alloc] initWithFrame:CGRectMake(250, 12, 15, 15)];
        self.clockIcon.image = [UIImage imageNamed:@"clock.png"];
        [self addSubview:self.clockIcon];
        
        self.timeAgo = [[UILabel alloc] initWithFrame:CGRectMake(275, 12, 40, 15)];
        self.timeAgo.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        self.timeAgo.textColor = [UIColor darkGrayColor];
        self.timeAgo.numberOfLines = 1;
        [self.contentView addSubview:self.timeAgo];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    
    // Create ProfileImageView
    self.profilePicture = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.profilePicture.translatesAutoresizingMaskIntoConstraints = NO;
    self.profilePicture.contentMode = UIViewContentModeScaleAspectFill;
    self.profilePicture.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.profilePicture];
    
    // Name label
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.numberOfLines = 1;
    [self.contentView addSubview:self.nameLabel];
    
    // Username label
    self.usernameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.usernameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.usernameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    self.usernameLabel.textColor = [UIColor darkGrayColor];
    self.usernameLabel.numberOfLines = 1;
    [self.contentView addSubview:self.usernameLabel];
    
    // Tweet label
    self.tweetLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.tweetLabel.userInteractionEnabled = YES;
    self.tweetLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.tweetLabel.numberOfLines = 0;
    self.tweetLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.tweetLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    self.tweetLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:self.tweetLabel];
    
    // Favorite Button
    self.favoriteButton = [[DOFavoriteButton alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"star.png"] imageFrame:CGRectMake(0, 0, 15, 15)];
    [self.contentView addSubview:self.favoriteButton];
    
    // Retweet Button
    self.retweetButton = [[DOFavoriteButton alloc] initWithFrame:CGRectZero image:[UIImage imageNamed:@"retweet.png"] imageFrame:CGRectMake(0, 0, 15, 15)];
    self.retweetButton.circleColor = [UIColor colorWithRed:0.04 green:0.83 blue:0.04 alpha:1.0];
    self.retweetButton.lineColor = [UIColor colorWithRed:0.08 green:0.93 blue:0.08 alpha:1.0];
    self.retweetButton.imageColorOn = [UIColor colorWithRed:0.26 green:0.96 blue:0.26 alpha:1.0];
    [self.contentView addSubview:self.retweetButton];
    
    // Reply Button
    self.replyButton = [[DOFavoriteButton alloc] initWithFrame:CGRectZero];
    [self.replyButton setBackgroundImage:[UIImage imageNamed:@"reply.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.replyButton];
    
    //
    //  CONSTRAIN
    //
    
    // Name Label
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:12];
    [self.nameLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.contentView];
    
    // Username Label
    [self.usernameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:0.0];
    [self.usernameLabel autoSetDimension:ALDimensionHeight toSize:16.5];
    [self.usernameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:58.0];

    // Profile Picture
    [self.profilePicture autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.nameLabel withOffset:-10.0];
    [self.profilePicture autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:12];
    [self.profilePicture autoSetDimension:ALDimensionHeight toSize:35];
    [self.profilePicture autoSetDimension:ALDimensionWidth toSize:35];
    
    // Tweet Label
    [self.tweetLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.usernameLabel withOffset:8.0];
    [self.tweetLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5.0];
    
    //
    // Interactive Buttons
    //
    
    // Left
    [self.replyButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:60];
    [self.replyButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:245];
    [self.replyButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [self.replyButton autoSetDimension:ALDimensionHeight toSize:15];
    [self.replyButton autoAlignAxis:ALAxisLastBaseline toSameAxisOfView:self.contentView];
    
    // Middle
    [self.retweetButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:115];
    [self.retweetButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:190];
    [self.retweetButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [self.retweetButton autoSetDimension:ALDimensionHeight toSize:15];
    [self.retweetButton autoAlignAxis:ALAxisLastBaseline toSameAxisOfView:self.contentView];
    
    // Right
    [self.favoriteButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:160];
    [self.favoriteButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:145];
    [self.favoriteButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [self.favoriteButton autoSetDimension:ALDimensionHeight toSize:15];
    [self.favoriteButton autoAlignAxis:ALAxisLastBaseline toSameAxisOfView:self.contentView];
     
    CGSize defaultSize = [[self class] defaultCellSize];
    self.tweetLabel.preferredMaxLayoutWidth = defaultSize.width - (8 * 2);
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.favoriteButton.selected = NO;
    self.tweetLabel.text = nil;
    self.profilePicture.image = nil;
    self.nameLabel.text = nil;
    self.retweetButton.selected = NO;
    self.usernameLabel.text = nil;
}

+ (CGSize)defaultCellSize {
    return (CGSize){CGRectGetWidth([[UIScreen mainScreen] bounds]), 85};
}

@end