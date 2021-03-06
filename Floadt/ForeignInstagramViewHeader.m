//
//  ForeignInstagramViewHeader.m
//  Floadt
//
//  Created by Pradyumn Nukala on 7/20/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import "ForeignInstagramViewHeader.h"

@implementation ForeignInstagramViewHeader

- (void)updateWithUserDetails:(InstagramUser *)user {
    self.instaUser = user;
    // set values from user to lable's and other UI elements.
    self.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"banner.png"]];
    
    self.profilePic = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 60, 60)];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.instaUser.profile_picture]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.profilePic.image = [UIImage imageWithData:data];
            CALayer *imageLayer = self.profilePic.layer;
            [imageLayer setCornerRadius:30];
            [imageLayer setMasksToBounds:YES];
        });
    });
    [self addSubview:self.profilePic];
    
    self.nameString = [[UILabel alloc] initWithFrame:CGRectMake(5, 75, 320, 25)];
    self.nameString.font = [UIFont fontWithName:@"Helvetica-Bold" size:13.0];
    self.nameString.text = self.instaUser.full_name;
    [self addSubview:self.nameString];
    
    self.postString = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 320, 25)];
    self.postString.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    self.postString.text = @"Posts";
    [self addSubview:self.postString];
    
    self.followerString = [[UILabel alloc] initWithFrame:CGRectMake(165, 10, 80, 25)];
    self.followerString.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    self.followerString.text = @"Followers";
    [self addSubview:self.followerString];
    
    self.followingString = [[UILabel alloc] initWithFrame:CGRectMake(250, 10, 80, 25)];
    self.followingString.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    self.followingString.text = @"Following";
    [self addSubview:self.followingString];
    
    self.bioString = [[UILabel alloc] initWithFrame:CGRectMake(5, 100, 320, 25)];
    self.bioString.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
    self.bioString.text = self.instaUser.bio;
    [self addSubview:self.bioString];
    
    self.websiteString = [[UITextView alloc] initWithFrame:CGRectMake(5, 125, 320, 25)];
    self.websiteString.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0];
    self.websiteString.editable = NO;
    self.websiteString.dataDetectorTypes = UIDataDetectorTypeAll;
    self.websiteString.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
    self.websiteString.text = self.instaUser.website;
    [self addSubview:self.websiteString];
    
    // Follow Button
    self.followButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 53, 200, 25)];
    [self.followButton setTitle:@"" forState:UIControlStateNormal];
    if ([self.instaUser.outgoing_status isEqual:@"follows"]) {
        [self.followButton setBackgroundImage:[UIImage imageNamed:@"following.png"] forState:UIControlStateNormal];
    } else if ([self.instaUser.outgoing_status isEqual:@"requested"]) {
        
    } else {
        [self.followButton setBackgroundImage:[UIImage imageNamed:@"follow.png"] forState:UIControlStateNormal];
    }
    
    [self.followButton addTarget:self action:@selector(didTapFollowButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.followButton];
    
    //
    // Count Labels
    //
    
    self.postCount = [[UILabel alloc] initWithFrame:CGRectMake(100, 27.5, 320, 25)];
    self.postCount.font = [UIFont fontWithName:@"Helvetica-Regular" size:14.0];
    NSString *post = [self numberWithShortcut:self.instaUser.media];
    self.postCount.text = post;
    [self addSubview:self.postCount];
    
    self.followerCount = [[UILabel alloc] initWithFrame:CGRectMake(165, 27.5, 320, 25)];
    self.followerCount.font = [UIFont fontWithName:@"Helvetica-Regular" size:14.0];
    NSString *follower = [self numberWithShortcut:self.instaUser.followed_by];
    self.followerCount.text = follower;
    [self addSubview:self.followerCount];
    
    self.followingCount = [[UILabel alloc] initWithFrame:CGRectMake(250, 27.5, 320, 25)];
    self.followingCount.font = [UIFont fontWithName:@"Helvetica-Regular" size:14.0];
    NSString *following = [self numberWithShortcut:self.instaUser.follows];
    self.followingCount.text = following;
    [self addSubview:self.followingCount];
}

- (void)didTapFollowButton:(UIButton *)sender {
    if ([self.instaUser.outgoing_status isEqual:@"follows"]) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Unfollow?" andMessage:nil];
        [alertView addButtonWithTitle:@"Cancel"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alert) {
                              NSLog(@"Cancel Clicked");
                          }];
        [alertView addButtonWithTitle:@"Unfollow"
                             type:SIAlertViewButtonTypeDestructive
                          handler:^(SIAlertView *alert) {
                              NSLog(@"Unfollow Clicked");
                          }];
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView show];
    } else if ("requested") {
        
    } else {
      [sender setBackgroundImage:[UIImage imageNamed:@"follow.png"] forState:UIControlStateNormal];
    }
}

- (void)unfollowUser:(NSString *)user {
    
}

- (NSString *)numberWithShortcut:(NSNumber*)number
{
    if (number.intValue > 9999) {
        unsigned long long value = [number longLongValue];
        NSUInteger index = 0;
        float dvalue = (float)value;
        NSArray *suffix = @[ @"", @"K", @"M", @"B", @"T", @"P", @"E" ];
        while ((value /= 1000) && ++index) dvalue /= 1000;
        NSString *svalue = [NSString stringWithFormat:@"%.2f%@",dvalue, [suffix objectAtIndex:index]];
    
        return svalue;
    } else{
        NSString *value = [NSString stringWithFormat:@"%@", number];
        return value;
    }
}

@end
