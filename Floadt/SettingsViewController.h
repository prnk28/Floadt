//
//  SettingsViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 3/31/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "Data.h"
#import "LGPlusButtonsView.h"
#import "LGPlusButton.h"
#import "LGDrawer.h"
#import "JGActionSheet.h"

@interface SettingsViewController : UIViewController <LGPlusButtonsViewDelegate, JGActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) AFOAuth1Client *twitterClient;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *userid;
@property (strong, nonatomic) LGPlusButtonsView *plusButtonsView;
@property (strong, nonatomic) UIScrollView  *scrollView;

@end
