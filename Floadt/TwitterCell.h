//
//  TwitterCell.h
//  Floadt
//
//  Created by Pradyumn Nukala on 10/23/14.
//  Copyright (c) 2014 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTKDynamicResizingTableViewCell.h"
#import "HTKDynamicResizingCellProtocol.h"
#import "AMAttributedHighlightLabel.h"

@interface TwitterCell : HTKDynamicResizingTableViewCell <AMAttributedHighlightLabelDelegate>

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
@property (nonatomic, strong) AMAttributedHighlightLabel *tweetLabel;


- (void)setupCellWithData:(NSDictionary *)data;

+ (CGSize)defaultCellSize;

@end
