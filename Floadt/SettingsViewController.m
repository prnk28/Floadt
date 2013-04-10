//
//  SettingsViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/31/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "SettingsViewController.h"
#import "MGScrollView.h"
#import "MGTableBoxStyled.h"
#import "MGLineStyled.h"
#import "DLIDEKeyboardView.h"
#import "RNBlurModalView.h"
#import "WTStatusBar.h"
@interface SettingsViewController ()


@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"classy_fabric.png"]]];

    
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
    
    
    RNBlurModalView *modal;
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, 300, 240)];
    [DLIDEKeyboardView attachToTextView:textView];
    
    [textView setText:@"Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit. "];
    
    [textView setTextColor:[UIColor whiteColor]];
    [self.view addSubview:textView];
    
    textView.backgroundColor = [UIColor darkGrayColor];
    textView.layer.cornerRadius = 5.f;
    textView.layer.borderColor = [UIColor blackColor].CGColor;
    textView.layer.borderWidth = 5.f;
    
    [DLIDEKeyboardView attachToTextView:textView];
    [textView becomeFirstResponder];
    
    modal = [[RNBlurModalView alloc] initWithView:textView];
    
    [modal show];
    
}

@end
