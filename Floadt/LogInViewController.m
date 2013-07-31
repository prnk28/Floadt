//
//  LogInViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 7/11/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()


@end

@implementation LogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.login.buttonBackgroundColor = [UIColor colorWithRed:1.0f green:0.16f blue:0.2f alpha:1.00f]; //[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.60f alpha:1.0f];
    self.login.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    self.login.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.login setFlatTitle:nil];
    [self.login setFlatImage:[UIImage imageNamed:@"131-tower.png"]];
    
    self.signup.buttonBackgroundColor = [UIColor colorWithRed:0.32f green:0.64f blue:0.32f alpha:1.00f]; //[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.60f alpha:1.0f];
    self.signup.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    self.signup.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.signup setFlatTitle:nil];
    [self.signup setFlatImage:[UIImage imageNamed:@"131-tower.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
