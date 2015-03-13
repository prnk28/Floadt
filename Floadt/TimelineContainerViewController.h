//
//  TimelineContainerViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 1/14/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "GHContextMenuView.h"
#import "AFOAuth1Client.h"

@interface TimelineContainerViewController : UIViewController< UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (nonatomic, strong) UITextView *message;
@property (nonatomic, strong) AFOAuth1Client *twitterClient;
@end
