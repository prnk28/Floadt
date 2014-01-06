//
//  SettingsViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/31/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//
#define INSTAGRAM_CLIENT_ID @"88b3fb2cd93c4aacb053b44b35b86187"
#import "SettingsViewController.h"

@implementation SettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [barButton setTitle:@"" forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    //[barButton setBackgroundImage:[UIImage imageNamed:@"barButton_s.png"] forState:UIControlStateHighlighted];
    [barButton addTarget:self action:@selector(didTapBarButton:) forControlEvents:UIControlEventTouchUpInside];
    barButton.frame = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    self.navBar.leftBarButtonItem = barButtonItem;
    
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [postButton setTitle:@"" forState:UIControlStateNormal];
    [postButton setBackgroundImage:[UIImage imageNamed:@"plusButton.png"] forState:UIControlStateNormal];
    //[postButton setBackgroundImage:[UIImage imageNamed:@"pen_sIMG.png"] forState:UIControlStateHighlighted];
    [postButton addTarget:self action:@selector(didTapPostButton:) forControlEvents:UIControlEventTouchUpInside];
    postButton.frame = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    UIBarButtonItem *postButtonItem = [[UIBarButtonItem alloc] initWithCustomView:postButton];
    
    self.navBar.rightBarButtonItem = postButtonItem;
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:179.0/255.0 green:177.0/255.0 blue:177.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"AeroviasBrasilNF" size:30.0], NSFontAttributeName, nil]];
    
}

- (void)didTapBarButton:(id)sender
{
    [self.sidePanelController showLeftPanelAnimated:YES];
}

- (void)didTapPostButton:(id)sender
{
    if (menu) {
        [menu hideWithAnimationBlock:^{
            self.view.backgroundColor = [UIColor whiteColor];
        }];
        menu = nil;
    } else {
        menu = [[RRCircularMenu alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 180, self.view.frame.size.width, 180)];
        menu.delegate = self;
        [self.view addSubview:menu];
        [menu showWithAnimationBlock:^{
            self.view.backgroundColor = [UIColor darkGrayColor];
        } settingSliderTo:3];
    }
}

- (void) menuItem:(RRCircularItem *)item didChangeActive:(BOOL)active {
    NSLog(@"Item %@ did change state to %d", item.text, active);
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    BOOL *instagramActive = [user boolForKey:@"isInstagramLoggedIn"];
    BOOL *twitterActive = [user boolForKey:@"TwitterAuthenticated"];
    
    if (active && ![menu isLabelActive] && [item.text  isEqual: @"Instagram"]) {
        [menu setLabelActive:YES];
        NSString *callbackUrl = @"floadt://instagram_callback";
        if (instagramActive) {
            [menu setLabelActive:YES];
        }
        
        [[InstagramClient sharedClient] authenticateWithClientID:INSTAGRAM_CLIENT_ID callbackURL:callbackUrl];
  
    }else if (active && ![menu isLabelActive] && [item.text  isEqual: @"Twitter"]){
        [[TwitterClient sharedClient] authenticateWithTwitter];
    }
}

- (BOOL) ignoreClickFor:(RRCircularItem *)item {
    NSLog(@"Checking whether to ignore click for item %@", item.text);
    return NO;
}

@end
