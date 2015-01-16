//
//  TwitterCell.m
//  Floadt
//
//  Created by Pradyumn Nukala on 10/23/14.
//  Copyright (c) 2014 Floadt. All rights reserved.
//

#import "TwitterCell.h"

@implementation TwitterCell

@synthesize nameLabel;
@synthesize profilePic;
@synthesize tweetLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Name
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(66, 17, 172, 21)];
        [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Regular" size:16.0]];
        [self addSubview:self.nameLabel];
        
        // Profile Pic
        self.profilePic = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 50, 50)];
        [self addSubview:self.profilePic];
        
        // Caption Label
        self.tweetLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 66, 292, 54)];
        [self.tweetLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:12.0]];
        tweetLabel.lineBreakMode = NSLineBreakByWordWrapping;
        tweetLabel.numberOfLines = 0;
        [self addSubview:self.tweetLabel];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
