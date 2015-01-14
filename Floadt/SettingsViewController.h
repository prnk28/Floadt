//
//  SettingsViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 3/31/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "Data.h"

@interface SettingsViewController : UIViewController <GHContextOverlayViewDataSource, GHContextOverlayViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) AFOAuth1Client *twitterClient;

@end
