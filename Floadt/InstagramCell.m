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
@synthesize profilePic;
@synthesize instagramPic;
@synthesize captionLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Name
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 6, 192, 25)];
        [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Regular" size:16.0]];
        [self addSubview:self.nameLabel];
        
        // Profile Pic
        self.profilePic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 50, 50)];
        [self addSubview:self.profilePic];
        
        // Insta Pic
        self.instagramPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 58, 299, 247)];
        [self addSubview:self.instagramPic];
        
        // Caption Label
        self.captionLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 29, 192, 21)];
        [self.captionLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:12.0]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
