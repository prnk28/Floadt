//
//  TimelineContainerViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 1/14/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import "TimelineContainerViewController.h"

@interface TimelineContainerViewController ()

@end

@implementation TimelineContainerViewController

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
    BOOL insta = [[NSUserDefaults standardUserDefaults] boolForKey:@"instagramActive"];
    BOOL twitter = [[NSUserDefaults standardUserDefaults] boolForKey:@"twitterActive"];
    BOOL facebook = [[NSUserDefaults standardUserDefaults] boolForKey:@"facebookActive"];
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    if (!insta&&!twitter&&!facebook) {
        UIView *nobodyLoggedIn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        imageView.image = [UIImage imageNamed:@"noNetworks_grey.png"];
        [nobodyLoggedIn addSubview:imageView];
        [self.view addSubview:nobodyLoggedIn];
    }
    reach.unreachableBlock = ^(Reachability*reach)
    {
        UIView *noNetwork = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        imageView.image = [UIImage imageNamed:@"noNetworks_grey.png"];
        [noNetwork addSubview:imageView];
        [self.view addSubview:noNetwork];
    };
    
    [reach startNotifier];
    
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [barButton setTitle:@"" forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [barButton addTarget:self action:@selector(didTapBarButton:) forControlEvents:UIControlEventTouchUpInside];
    barButton.frame = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    self.navBar.leftBarButtonItem = barButtonItem;
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [postButton setTitle:@"" forState:UIControlStateNormal];
    [postButton setBackgroundImage:[UIImage imageNamed:@"plusButton.png"] forState:UIControlStateNormal];
    [postButton addTarget:self action:@selector(didTapPostButton:) forControlEvents:UIControlEventTouchUpInside];
    postButton.frame = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    UIBarButtonItem *postButtonItem = [[UIBarButtonItem alloc] initWithCustomView:postButton];
    
    self.navBar.rightBarButtonItem = postButtonItem;
    
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                      [UIColor colorWithRed:179.0/255.0 green:177.0/255.0 blue:177.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                                      [UIFont fontWithName:@"AeroviasBrasilNF" size:30.0], NSFontAttributeName, nil]];
}

- (void)didTapPostButton:(id)sender
{
    RRSendMessageViewController *controller = [[RRSendMessageViewController alloc] init];
    
    [controller presentController:self blockCompletion:^(RRMessageModel *model, BOOL isCancel) {
        if (isCancel == true) {
            self.message.text = @"";
        }
        else {
            self.message.text = model.text;
        }
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)didTapBarButton:(id)sender
{
    [self.sidePanelController showLeftPanelAnimated:YES];
}
@end
