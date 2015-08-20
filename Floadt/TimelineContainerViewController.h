//
//  TimelineContainerViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 1/14/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "LGPlusButton.h"
#import "LGPlusButtonsView.h"
#import "AFOAuth1Client.h"
#import "EAIntroPage.h"
#import "EAIntroView.h"
#import "EARestrictedScrollView.h"

@interface TimelineContainerViewController : UIViewController< UIActionSheetDelegate, LGPlusButtonsViewDelegate,EAIntroDelegate>{
    UIView *rootView;
    EAIntroView *intro;
}
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (nonatomic, strong) UITextView *message;
@property (nonatomic, strong) AFOAuth1Client *twitterClient;
@end
