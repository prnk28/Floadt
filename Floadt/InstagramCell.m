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

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Name
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(73, 6, 192, 25)];
        [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Regular" size:16.0]];
        [self addSubview:self.nameLabel];
        
        // Profile Pic
        self.profilePic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 50, 50)];
        [self addSubview:self.profilePic];
        
        // Insta Pic
        self.instagramPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 65, 299, 299)];
        [self addSubview:self.instagramPic];
        
        // Date Label
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 29, 192, 21)];
        [self.dateLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:12.0]];
        [self addSubview:self.dateLabel];
        
        // Like Button
        self.likeButton = [[UIButton alloc] initWithFrame:CGRectMake(68, 279, 18, 18)];
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"heartShape.png"] forState:UIControlStateNormal];
        [self.likeButton addTarget:self action:@selector(didTapLikeButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.likeButton];
        
        // Comment Button
        self.commentButton = [[UIButton alloc] initWithFrame:CGRectMake(68, 29, 192, 21)];
        [self addSubview:self.commentButton];
        
        // Like Label
        self.likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 371, 50, 21)];
        self.likeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
        self.likeLabel.textColor = [UIColor orangeColor];
        [self addSubview:self.likeLabel];
        
        // Heart Icon
        self.heartIcon = [[UIButton alloc] initWithFrame:CGRectMake(20, 375, 14, 14)];
        [self.heartIcon setBackgroundImage:[UIImage imageNamed:@"heart.png"] forState:UIControlStateNormal];
        [self.heartIcon setTitleColor:[UIColor grayColor]
                             forState:UIControlStateHighlighted];
        [self.heartIcon addTarget:self action:@selector(didTapLikeIcon:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.heartIcon];
        
        // Comment Icon
        self.commentIcon = [[UIButton alloc] initWithFrame:CGRectMake(20, 395, 14, 14)];
        [self.commentIcon setBackgroundImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
        [self.commentIcon setTitleColor:[UIColor grayColor]
                             forState:UIControlStateHighlighted];
        [self.commentIcon addTarget:self action:@selector(didTapCommentIcon:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.commentIcon];
        
        // Comment Text
        self.commentText = [[UILabel alloc] initWithFrame:CGRectMake(-88, 370, 259, 40)];
        [[self.commentText layer] setAnchorPoint:CGPointMake(0, 0)];
        self.commentText.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        self.commentText.lineBreakMode = NSLineBreakByWordWrapping;
        self.commentText.numberOfLines = 3;
        self.commentText.textColor = [UIColor blackColor];
        [self addSubview:self.commentText];
        
        // Location Icon
        self.locationIcon = [[UIButton alloc] initWithFrame:CGRectMake(73, 33, 12, 12)];
        [self.locationIcon setBackgroundImage:[UIImage imageNamed:@"location.png"] forState:UIControlStateNormal];
        [self.locationIcon setTitleColor:[UIColor grayColor]
                               forState:UIControlStateHighlighted];
        [self.locationIcon addTarget:self action:@selector(didTapLocationIcon:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.locationIcon];
    }
    return self;
}

- (void)didTapLikeButton:(id)sender{


}

- (void)didTapLikeIcon:(id)sender{
    NSLog(@"Like Icon Tapped");
}

- (void)didTapLocationIcon:(id)sender{
    NSLog(@"Like Location Tapped");
}

- (void)didTapCommentIcon:(id)sender{
    NSLog(@"Comment Icon Tapped");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
