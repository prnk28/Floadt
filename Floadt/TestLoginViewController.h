//
//  TestLoginViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 3/2/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <KiipSDK/KiipSDK.h>

@interface TestLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)logInP:(id)sender;
- (IBAction)logOutP:(id)sender;

@end
