//
//  InstagramResultsCell.m
//  Floadt
//
//  Created by Pradyumn Nukala on 11/3/14.
//  Copyright (c) 2014 Floadt. All rights reserved.
//

#import "InstagramResultsCell.h"

@implementation InstagramResultsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.proImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, 30, 30)];
        [self.contentView addSubview:self.proImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 202, 21)];
        self.nameLabel.font = [UIFont fontWithName:@"Helvetica-Regular" size:12.0];
        [self.contentView addSubview:self.nameLabel];
        
        self.usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 21, 190, 24)];
        self.usernameLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:10.0];
        [self.contentView addSubview:self.usernameLabel];
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
