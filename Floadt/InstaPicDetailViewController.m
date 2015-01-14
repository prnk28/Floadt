//
//  InstaPicDetailViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 11/19/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import "InstaPicDetailViewController.h"

@interface InstaPicDetailViewController ()

@end

@implementation InstaPicDetailViewController


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

    
    UITapGestureRecognizer *doubleTapImage = [[UITapGestureRecognizer alloc] initWithTarget:_imageView action:@selector(doubleTapImage:)];
    doubleTapImage.numberOfTapsRequired = 2;
    
    [_imageView addGestureRecognizer:doubleTapImage];

    NSDictionary *instaPics = self.detailItem;
    NSString *user =  instaPics[@"user"][@"full_name"];



    _ImagesCountLabel.font = [UIFont fontWithName:@"Helvetica-Regular" size:15];
    _FollowersCountLabel.font = [UIFont fontWithName:@"Helvetica-Regular" size:15];
    _FollowingCountLabel.font = [UIFont fontWithName:@"Helvetica-Regular" size:15];
    
    _ImagesLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12];
    _FollowersLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12];
    _FollowingLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12];
    
    _userName.text = user;
    if (self.detailItem) {
        NSDictionary *instaPics = self.detailItem;
        if (instaPics[@"caption"] != [NSNull null] && instaPics[@"caption"][@"text"] != [NSNull null])            {
            NSString *caption = instaPics[@"caption"][@"text"];
         _caption.text = caption;
        }else{
            NSLog(@"No Caption");
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *imageUrl = [[[instaPics objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                _imageView.image = [UIImage imageWithData:data];
            });
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *imageUrl = instaPics[@"user"][@"profile_picture"];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                _profilePicture.image = [UIImage imageWithData:data];
                CALayer *imageLayer = _profilePicture.layer;
                [imageLayer setCornerRadius:40];
                [imageLayer setMasksToBounds:YES];
            });
        });
    }
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)doubleTapImage:(id)sender {
    NSLog(@"Double Tapped, Will be liked");
}

-(void) popBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
