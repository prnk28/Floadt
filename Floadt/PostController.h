//
//  PostController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 11/8/14.
//  Copyright (c) 2014 Floadt. All rights reserved.
//

#import "Data.h"
#import <UIKit/UIKit.h>

@interface PostController : UIViewController

@property (strong, nonatomic) AFOAuth1Client *twitterClient;

@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *camera;
@property (strong, nonatomic) IBOutlet UIButton *facebook;
@property (strong, nonatomic) IBOutlet UIButton *instagram;
@property (strong, nonatomic) IBOutlet UILabel *textCount;
@property (strong, nonatomic) IBOutlet UIButton *twitter;
- (IBAction)cameraDown:(id)sender;
- (IBAction)facebookDown:(id)sender;
- (IBAction)instagramDown:(id)sender;
- (IBAction)twitterDown:(id)sender;

@end
