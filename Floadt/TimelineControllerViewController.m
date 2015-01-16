//
//  TimelineControllerViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 1/14/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import "TimelineControllerViewController.h"

@interface TimelineControllerViewController ()

@end

@implementation TimelineControllerViewController
{
    BOOL _isReload;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _isReload = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.barView.selectedBar setBackgroundColor:[UIColor colorWithRed:52/255.0f green:170.0f/255.0f blue:220/255.0f alpha:1.0]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController{
    // BOOL *insta = [[NSUserDefaults standardUserDefaults] boolForKey:@"instagramActive"];
    // BOOL *twitter = [[NSUserDefaults standardUserDefaults] boolForKey:@"twitterActive"];
    // BOOL *facebook = [[NSUserDefaults standardUserDefaults] boolForKey:@"facebookActive"];
    FacebookTableViewController *child_1 = [[FacebookTableViewController alloc] init];
    InstagramTableViewController *child_2 = [[InstagramTableViewController alloc] init];
    TwitterTableViewController *child_3 = [[TwitterTableViewController alloc] init];

    NSArray * childViewControllers = [NSMutableArray arrayWithObjects:child_1, child_2, child_3, nil];

    return childViewControllers;
}


@end
