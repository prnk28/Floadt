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
    UITapGestureRecognizer *doubleTapImage = [[UITapGestureRecognizer alloc] initWithTarget:_imageView action:@selector(doubleTapImage:)];
    doubleTapImage.numberOfTapsRequired = 2;
    
    [_imageView addGestureRecognizer:doubleTapImage];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    if (self.detailItem) {
        NSDictionary *instaPics = self.detailItem;
        if (instaPics[@"caption"] != [NSNull null] && instaPics[@"caption"][@"text"] != [NSNull null])            {
            NSString *user =  instaPics[@"user"][@"full_name"];
            NSString *caption = instaPics[@"caption"][@"text"];
            _caption.text = caption;
            _userName.text = user;
            
        }else{
            NSLog(@"No Caption");
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *imageUrl = [[[instaPics objectForKey:@"images"] objectForKey:@"standard_resolution"] objectForKey:@"url"];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                _imageView.image = [UIImage imageWithData:data];
                CALayer *imageLayer = _imageView.layer;
                [imageLayer setCornerRadius:25];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
