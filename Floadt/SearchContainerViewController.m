//
//  SearchContainerViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 1/27/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import "SearchContainerViewController.h"

@interface SearchContainerViewController ()

@end

@implementation SearchContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpUI{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.278f green:0.337f blue:0.439f alpha:1.00f]];
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [barButton setTitle:@"" forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [barButton addTarget:self action:@selector(didTapBarButton:) forControlEvents:UIControlEventTouchUpInside];
    barButton.frame = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    self.navBar.leftBarButtonItem = barButtonItem;
    
    self.navBar.title = @"Search";
    
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                      [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                      [UIFont fontWithName:@"AeroviasBrasilNF" size:30.0], NSFontAttributeName, nil]];
    
}

- (void)didTapBarButton:(id)sender
{
    [self.sidePanelController showLeftPanelAnimated:YES];
}

- (void)didTapPostButton:(id)sender
{
}

@end
