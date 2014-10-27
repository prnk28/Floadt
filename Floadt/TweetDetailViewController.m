//
//  TweetDetailViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 11/11/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import "TweetDetailViewController.h"

@interface TweetDetailViewController ()

@end

@implementation TweetDetailViewController

- (void)viewDidLoad
{
    // Setup Back Button
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setTitle:@"" forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navItem.leftBarButtonItem = backButtonItem;
    
    [super viewDidLoad];
    if (self.detailItem) {
            NSDictionary *tweet = self.detailItem;
            
        NSString *name = [[tweet objectForKey:@"user"] objectForKey:@"name"];
        NSString *text = [tweet objectForKey:@"text"];
        NSString *statusCount = [[tweet objectForKey:@"user"] objectForKey:@"statuses_count"];
        NSString *followingCount = [[tweet objectForKey:@"user"] objectForKey:@"following"];
        NSString *followersCount = [[tweet objectForKey:@"user"] objectForKey:@"followers_count"];
        NSString *createdAt =[tweet objectForKey:@"created_at"];
        NSLog(@"Twitter: %@",createdAt);
        _name.text = name;
        _tweetLabel.text = [NSString stringWithFormat:@"%@",text];
        _tweetLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:15];
        _tweetsCount.text = [NSString stringWithFormat:@"%@",statusCount];
        _tweetsLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12];
        _followersCount.text = [NSString stringWithFormat:@"%@",followersCount];
        _followersLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12];
        _followingCount.text = [NSString stringWithFormat:@"%@",followingCount];
        _followingLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12];
        
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSString *imageUrl = [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    _profilePic.image = [UIImage imageWithData:data];
                    CALayer *imageLayer = _profilePic.layer;
                    [imageLayer setCornerRadius:40];
                    [imageLayer setMasksToBounds:YES];
                });
            });
        
    }
}

// Pop Back ViewControllers
-(void) popBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
