//
//  MenuViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 10/20/13.
//  Completely Modified on 09/22/15
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        if (screenHeight == 568) {
            // iphone 5 screen
            // Setup
            self.b1 = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 20, 260, 110) backgroundColor:[UIColor colorWithRed:0.32f green:0.64f blue:0.32f alpha:1.00f] foregroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f]];
            self.b1.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
            [self.b1 setFlatTitle:nil];
            [self.b1 setFlatImage:[UIImage imageNamed:@"za-home.png"]];
            [self.b1 addTarget:self action:@selector(td1:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:self.b1];
            
            self.b2 = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 130, 260, 110) backgroundColor:[UIColor colorWithRed:1.0f green:0.16f blue:0.2f alpha:1.00f] foregroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f]];
            self.b2.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
            [self.b2 setFlatTitle:nil];
            [self.b2 setFlatImage:[UIImage imageNamed:@"269-bell.png"]];
            [self.b2 addTarget:self action:@selector(td2:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:self.b2];
            
            self.b4 = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 240, 260, 110) backgroundColor:[UIColor colorWithRed:0.278f green:0.337f blue:0.439f alpha:1.00f] foregroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f]];
            self.b4.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
            [self.b4 setFlatTitle:nil];
            [self.b4 setFlatImage:[UIImage imageNamed:@"06-magnify.png"]];
            [self.b4 addTarget:self action:@selector(td4:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:self.b4];
            
            self.b5 = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 350, 260, 110) backgroundColor:[UIColor colorWithRed:0.32f green:0.14f blue:0.32f alpha:1.00f] foregroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f]];
            self.b5.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
            [self.b5 setFlatTitle:nil];
            [self.b5 setFlatImage:[UIImage imageNamed:@"111-user.png"]];
            [self.b5 addTarget:self action:@selector(td5:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:self.b5];
            
            self.b6 = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 460, 260, 110) backgroundColor:[UIColor colorWithRed:1.0f green:0.505f blue:0.0f alpha:1.00f] foregroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f]];
            self.b6.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
            [self.b6 setFlatTitle:nil];
            [self.b6 setFlatImage:[UIImage imageNamed:@"158-wrench-2.png"]];
            [self.b6 addTarget:self action:@selector(td6:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:self.b6];
        }
        else if (screenHeight == 667) {
            // iPhone 6
            // Setup
            self.b1 = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 20, 300, 130) backgroundColor:[UIColor colorWithRed:0.32f green:0.64f blue:0.32f alpha:1.00f] foregroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f]];
            self.b1.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
            [self.b1 setFlatTitle:nil];
            [self.b1 setFlatImage:[UIImage imageNamed:@"za-home.png"]];
            [self.b1 addTarget:self action:@selector(td1:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:self.b1];
            
            self.b2 = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 150, 300, 130) backgroundColor:[UIColor colorWithRed:1.0f green:0.16f blue:0.2f alpha:1.00f] foregroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f]];
            self.b2.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
            [self.b2 setFlatTitle:nil];
            [self.b2 setFlatImage:[UIImage imageNamed:@"269-bell.png"]];
            [self.b2 addTarget:self action:@selector(td2:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:self.b2];
            
            self.b4 = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 280, 300, 130) backgroundColor:[UIColor colorWithRed:0.278f green:0.337f blue:0.439f alpha:1.00f] foregroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f]];
            self.b4.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
            [self.b4 setFlatTitle:nil];
            [self.b4 setFlatImage:[UIImage imageNamed:@"06-magnify.png"]];
            [self.b4 addTarget:self action:@selector(td4:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:self.b4];
            
            self.b5 = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 410, 300, 130) backgroundColor:[UIColor colorWithRed:0.32f green:0.14f blue:0.32f alpha:1.00f] foregroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f]];
            self.b5.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
            [self.b5 setFlatTitle:nil];
            [self.b5 setFlatImage:[UIImage imageNamed:@"111-user.png"]];
            [self.b5 addTarget:self action:@selector(td5:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:self.b5];
            
            self.b6 = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 540, 300, 130) backgroundColor:[UIColor colorWithRed:1.0f green:0.505f blue:0.0f alpha:1.00f] foregroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f]];
            self.b6.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
            [self.b6 setFlatTitle:nil];
            [self.b6 setFlatImage:[UIImage imageNamed:@"158-wrench-2.png"]];
            [self.b6 addTarget:self action:@selector(td6:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:self.b6];
        } else {
            // iPhone 6+
            // Setup
            self.b1 = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 20, 333, 143) backgroundColor:[UIColor colorWithRed:0.32f green:0.64f blue:0.32f alpha:1.00f] foregroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f]];
            self.b1.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
            [self.b1 setFlatTitle:nil];
            [self.b1 setFlatImage:[UIImage imageNamed:@"za-home.png"]];
            [self.b1 addTarget:self action:@selector(td1:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:self.b1];
            
            self.b2 = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 163, 333, 143) backgroundColor:[UIColor colorWithRed:1.0f green:0.16f blue:0.2f alpha:1.00f] foregroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f]];
            self.b2.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
            [self.b2 setFlatTitle:nil];
            [self.b2 setFlatImage:[UIImage imageNamed:@"269-bell.png"]];
            [self.b2 addTarget:self action:@selector(td2:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:self.b2];
            
            self.b4 = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 306, 333, 143) backgroundColor:[UIColor colorWithRed:0.278f green:0.337f blue:0.439f alpha:1.00f] foregroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f]];
            self.b4.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
            [self.b4 setFlatTitle:nil];
            [self.b4 setFlatImage:[UIImage imageNamed:@"06-magnify.png"]];
            [self.b4 addTarget:self action:@selector(td4:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:self.b4];
            
            self.b5 = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 449, 333, 143) backgroundColor:[UIColor colorWithRed:0.32f green:0.14f blue:0.32f alpha:1.00f] foregroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f]];
            self.b5.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
            [self.b5 setFlatTitle:nil];
            [self.b5 setFlatImage:[UIImage imageNamed:@"111-user.png"]];
            [self.b5 addTarget:self action:@selector(td5:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:self.b5];
            
            self.b6 = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 592, 333, 144) backgroundColor:[UIColor colorWithRed:1.0f green:0.505f blue:0.0f alpha:1.00f] foregroundColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f]];
            self.b6.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
            [self.b6 setFlatTitle:nil];
            [self.b6 setFlatImage:[UIImage imageNamed:@"158-wrench-2.png"]];
            [self.b6 addTarget:self action:@selector(td6:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:self.b6];
        }
    }
}

- (void)td1:(id)sender {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavInfinity"];
    self.sidePanelController.centerPanel = viewController;
    [self.sidePanelController showCenterPanelAnimated:YES];
    
}

- (void)td2:(id)sender {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavNoti"];
    self.sidePanelController.centerPanel = viewController;
    [self.sidePanelController showCenterPanelAnimated:YES];
}

- (void)td4:(id)sender {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavSearch"];
    self.sidePanelController.centerPanel = viewController;
    [self.sidePanelController showCenterPanelAnimated:YES];
}

- (void)td5:(id)sender {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavProfile"];
    self.sidePanelController.centerPanel = viewController;
    [self.sidePanelController showCenterPanelAnimated:YES];
}

- (void)td6:(id)sender {
    
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavSettings"];
    self.sidePanelController.centerPanel = viewController;
    [self.sidePanelController showCenterPanelAnimated:YES];
    
}
@end
