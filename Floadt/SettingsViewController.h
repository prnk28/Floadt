//
//  SettingsViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 3/31/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "QuadCurveMenu.h"
#import "JSFlatButton.h"

@interface SettingsViewController : UIViewController <QuadCurveMenuDelegate>
- (IBAction)tweetLogin:(id)sender;
@property (weak, nonatomic) IBOutlet JSFlatButton *TAuth;


@end
