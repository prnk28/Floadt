//
//  SettingsViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 3/31/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "AwesomeMenu.h"
#import "JSFlatButton.h"
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"



@interface SettingsViewController : UIViewController <AwesomeMenuDelegate>{}
- (IBAction)tweetLogin:(id)sender;
@property (weak, nonatomic) IBOutlet JSFlatButton *TAuth;

@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@end
