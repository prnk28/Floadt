//
//  InstagramCell.m
//  Floadt
//
//  Created by Pradyumn Nukala on 12/14/14.
//  Copyright (c) 2014 Floadt. All rights reserved.
//

#import "InstagramCell.h"

@implementation InstagramCell

@synthesize nameLabel;
@synthesize likeLabel;
@synthesize likeButton;
@synthesize commentText;
@synthesize commentIcon;
@synthesize commentButton; 
@synthesize profilePic;
@synthesize instagramPic;
@synthesize timeAgo;
@synthesize clockIcon;

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Create ClockImageView
        self.clockIcon = [[UIImageView alloc] initWithFrame:CGRectMake(250, 12, 15, 15)];
        self.clockIcon.image = [UIImage imageNamed:@"clock.png"];
        [self addSubview:self.clockIcon];
        self.timeAgo = [[UILabel alloc] initWithFrame:CGRectMake(275, 12, 40, 15)];
        self.timeAgo.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        self.timeAgo.textColor = [UIColor darkGrayColor];
        self.timeAgo.numberOfLines = 1;
        [self.contentView addSubview:self.timeAgo];
        // Name
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 6, 192, 25)];
        [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Regular" size:12.0]];
        self.nameLabel.textColor = [UIColor colorWithRed:(38.0/255.0) green:(120.0/255.0) blue:(172.0/255.0) alpha:1.0];
        [self.contentView addSubview:self.nameLabel];
        
        // Profile Pic
        self.profilePic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 35, 35)];
        [self.contentView addSubview:self.profilePic];
        
        // Insta Pic
        self.instagramPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 45, 299, 299)];
        [self.contentView addSubview:self.instagramPic];
        
        // Date Label
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 29, 192, 21)];
        [self.dateLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:12.0]];
        [self.contentView addSubview:self.dateLabel];
        
        // Like Label
        self.likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 371, 50, 21)];
        self.likeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
        self.likeLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:self.likeLabel];
        
        // Heart Icon
        self.heartIcon = [[UIButton alloc] initWithFrame:CGRectMake(20, 375, 14, 14)];
        [self.heartIcon setBackgroundImage:[UIImage imageNamed:@"heart.png"] forState:UIControlStateNormal];
        [self.heartIcon setTitleColor:[UIColor grayColor]
                             forState:UIControlStateHighlighted];
              [self.contentView addSubview:self.heartIcon];
        
        // Comment Icon
        self.commentIcon = [[UIButton alloc] initWithFrame:CGRectMake(20, 395, 14, 14)];
        [self.commentIcon setBackgroundImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
        [self.commentIcon setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.contentView addSubview:self.commentIcon];
        
        // Comment Text
        self.commentText = [[UILabel alloc] initWithFrame:CGRectMake(-88, 370, 259, 40)];
        [[self.commentText layer] setAnchorPoint:CGPointMake(0, 0)];
        self.commentText.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        self.commentText.lineBreakMode = NSLineBreakByWordWrapping;
        self.commentText.numberOfLines = 3;
        self.commentText.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.commentText];
        
        // Location Icon
        self.locationIcon = [[UIButton alloc] initWithFrame:CGRectMake(73, 33, 12, 12)];
        [self.locationIcon setBackgroundImage:[UIImage imageNamed:@"location.png"] forState:UIControlStateNormal];
        [self.locationIcon setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
                [self.contentView addSubview:self.locationIcon];
        
        // Heart Button
        self.heartButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 465, 25, 25)];
        [self.heartButton setBackgroundImage:[UIImage imageNamed:@"heart.png"] forState:UIControlStateNormal];
        [self.heartButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.contentView addSubview:self.heartButton];
        
        // Comment Button
        self.commentButton = [[UIButton alloc] initWithFrame:CGRectMake(220, 465, 25, 25 )];
        [self.commentButton setBackgroundImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
        [self.commentButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.contentView addSubview:self.commentButton];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
