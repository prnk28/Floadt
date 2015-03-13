//
//  InstaPicDetailViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 11/19/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//
#import "Data.h"
#import <UIKit/UIKit.h>

@interface InstaPicDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;

@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *captionLabel;

@property (strong, nonatomic) IBOutlet UILabel *name;

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) id detailItem;

@end
