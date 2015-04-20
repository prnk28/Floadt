//
//  InstagramCell.h
//  Floadt
//
//  Created by Pradyumn Nukala on 12/14/14.
//  Copyright (c) 2014 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"

@interface InstagramCell : UITableViewCell

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) UIImageView *profilePic;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UIImageView *instagramPic;
@property (strong, nonatomic) UIButton *likeButton;
@property (strong, nonatomic) UIButton *commentButton;
@property (strong, nonatomic) UILabel *commentText;
@property (strong, nonatomic) UILabel *likeLabel;
@property (strong, nonatomic) UIButton *heartIcon;
@property (strong, nonatomic) UIButton *commentIcon;
@property (strong, nonatomic) UIButton *locationIcon;
@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UIButton *heartButton;

@end
