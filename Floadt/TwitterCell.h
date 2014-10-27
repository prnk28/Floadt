//
//  TwitterCell.h
//  Floadt
//
//  Created by Pradyumn Nukala on 10/23/14.
//  Copyright (c) 2014 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *stampImage;
@property (strong, nonatomic) IBOutlet UILabel *tweetLabel;

@end
