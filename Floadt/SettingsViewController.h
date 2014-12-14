//
//  SettingsViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 3/31/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "Data.h"
#import "RSTwitterEngine.h"
#import "WebViewController.h"

@interface SettingsViewController : UIViewController <AwesomeMenuDelegate,RSTwitterEngineDelegate, WebViewControllerDelegate>

@property (strong, nonatomic) RSTwitterEngine *twitterEngine;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;


@end
