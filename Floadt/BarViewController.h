//
//  BarViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 3/26/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <KiipSDK/KiipSDK.h>
#import "MGScrollView.h"
#import "MGTableBoxStyled.h"
#import "MGLineStyled.h"

@interface BarViewController : UIViewController

- (IBAction)kiip:(id)sender;

- (IBAction)login:(id)sender;
- (IBAction)logout:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;

@end
