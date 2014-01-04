//
//  WelcomeScreenViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 10/17/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"

@interface WelcomeScreenViewController : UIViewController

//Objects
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;

//Actions
- (IBAction)loginButtonTouch:(id)sender;
- (IBAction)registerButtonTouch:(id)sender;


@end
