//
//  SettingsViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 3/31/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "Imports.h"
#import "AFOAuth1Client.h"
#import "AwesomeMenu.h"
#import "AFJSONRequestOperation.h"

@interface SettingsViewController : UIViewController <AwesomeMenuDelegate>


@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AFOAuth1Client *twitterClient;


@end
