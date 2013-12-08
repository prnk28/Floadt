//
//  MenuViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 10/20/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.b1.buttonBackgroundColor = [UIColor colorWithRed:0.32f green:0.64f blue:0.32f alpha:1.00f]; //[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.60f alpha:1.0f];
    self.b1.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    self.b1.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.b1 setFlatTitle:nil];
    [self.b1 setFlatImage:[UIImage imageNamed:@"131-tower.png"]];
    
    self.b2.buttonBackgroundColor = [UIColor colorWithRed:1.0f green:0.16f blue:0.2f alpha:1.00f]; //[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.60f alpha:1.0f];
    self.b2.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    self.b2.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.b2 setFlatTitle:nil];
    [self.b2 setFlatImage:[UIImage imageNamed:@"101-gameplan.png"]];
    
    self.b3.buttonBackgroundColor = [UIColor colorWithRed:0.0f green:0.4f blue:1.0f alpha:1.00f]; //[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.60f alpha:1.0f];
    self.b3.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    self.b3.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.b3 setFlatTitle:nil];
    [self.b3 setFlatImage:[UIImage imageNamed:@"09-chat-2.png"]];
    
    self.b4.buttonBackgroundColor = [UIColor colorWithRed:0.278f green:0.337f blue:0.439f alpha:1.00f]; //[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.60f alpha:1.0f];
    self.b4.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    self.b4.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.b4 setFlatTitle:nil];
    [self.b4 setFlatImage:[UIImage imageNamed:@"06-magnify.png"]];
    
    self.b5.buttonBackgroundColor = [UIColor colorWithRed:0.32f green:0.14f blue:0.32f alpha:1.00f]; //[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.60f alpha:1.0f];
    self.b5.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    self.b5.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.b5 setFlatTitle:nil];
    [self.b5 setFlatImage:[UIImage imageNamed:@"111-user.png"]];
    
    self.b6.buttonBackgroundColor = [UIColor colorWithRed:1.0f green:0.505f blue:0.0f alpha:1.00f]; //[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.60f alpha:1.0f];
    self.b6.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    self.b6.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.b6 setFlatTitle:nil];
    [self.b6 setFlatImage:[UIImage imageNamed:@"158-wrench-2.png"]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)td1:(id)sender {
    
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavStream"];
    self.sidePanelController.centerPanel = viewController;
    [self.sidePanelController showCenterPanelAnimated:YES];
    
}

- (IBAction)td2:(id)sender {
    
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavProfile"];
    self.sidePanelController.centerPanel = viewController;
    [self.sidePanelController showCenterPanelAnimated:YES];
    
}

- (IBAction)td3:(id)sender {
}

- (IBAction)td4:(id)sender {
}

- (IBAction)td5:(id)sender {
}

- (IBAction)td6:(id)sender {
    
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavSettings"];
    self.sidePanelController.centerPanel = viewController;
    [self.sidePanelController showCenterPanelAnimated:YES];
    
}
@end