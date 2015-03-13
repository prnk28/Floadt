//
//  SearchViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 1/27/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController {
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
    //[self.barView.selectedBar setBackgroundColor:[UIColor colorWithRed:52/255.0f green:170.0f/255.0f blue:220/255.0f alpha:1.0]];
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
    InstagramTableViewController *child_2 = [[InstagramTableViewController alloc] init];
    TwitterTableViewController *child_3 = [[TwitterTableViewController alloc] init];
      UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Search"];
    
    NSArray * childViewControllers = [NSMutableArray arrayWithObjects:viewController, child_2, child_3, nil];
    
    return childViewControllers;
}

@end
