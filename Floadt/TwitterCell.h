//
//  TwitterCell.h
//  Floadt
//
//  Created by Pradyumn Nukala on 10/23/14.
//  Copyright (c) 2014 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "HTKDynamicResizingTableViewCell.h"
#import "HTKDynamicResizingCellProtocol.h"

@interface TwitterCell : HTKDynamicResizingTableViewCell

/**
 * ImageView that shows sample picture
 */
@property (nonatomic, strong) UIImageView *profilePicture;

/**
 * Label that is name of sample person
 */
@property (nonatomic, strong) UILabel *nameLabel;

/**
 * Label that is name of sample company
 */
@property (nonatomic, strong) UILabel *companyLabel;

/**
 * Label that displays sample "bio".
 */
@property (nonatomic, strong) STTweetLabel *tweetLabel;

/**
 * Picture that displays clock icon.
 */
@property (nonatomic, strong) UIImageView *clockIcon;

/**
 * Picture that displays clock icon.
 */
@property (nonatomic, strong) UILabel *timeAgo;

+ (CGSize)defaultCellSize;

@end
