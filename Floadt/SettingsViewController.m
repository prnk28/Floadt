//
//  SettingsViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/31/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "SettingsViewController.h"
@interface SettingsViewController ()


@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgNoise.png"]]];

    
    UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [settingsButton setTitle:@"" forState:UIControlStateNormal];
    [settingsButton setBackgroundImage:[UIImage imageNamed:@"pen_usIMG.png"] forState:UIControlStateNormal];
    [settingsButton setBackgroundImage:[UIImage imageNamed:@"pen_sIMG.png"] forState:UIControlStateHighlighted];
    [settingsButton addTarget:self action:@selector(didTapSettingsButton:) forControlEvents:UIControlEventTouchUpInside];
    settingsButton.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    UIBarButtonItem *settingsButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    
    self.navBar.rightBarButtonItem = settingsButtonItem;
    
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [barButton setTitle:@"" forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"barButton.png"] forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"barButton_s.png"] forState:UIControlStateHighlighted];
    [barButton addTarget:self action:@selector(didTapBarButton:) forControlEvents:UIControlEventTouchUpInside];
    barButton.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    self.navBar.leftBarButtonItem = barButtonItem;
}

- (void)didTapBarButton:(id)sender {
    
    [self.sidePanelController showLeftPanelAnimated:YES];
    
}

- (void)didTapSettingsButton:(id)sender {
    

    
}

@end
