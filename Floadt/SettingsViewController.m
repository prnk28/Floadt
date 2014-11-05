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
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:1.0f green:0.505f blue:0.0 alpha:1.00f]];
    
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [barButton setTitle:@"" forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    //[barButton setBackgroundImage:[UIImage imageNamed:@"barButton_s.png"] forState:UIControlStateHighlighted];
    [barButton addTarget:self action:@selector(didTapBarButton:) forControlEvents:UIControlEventTouchUpInside];
    barButton.frame = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    self.navBar.leftBarButtonItem = barButtonItem;
    
    // Setup Add Menu
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
    UIImage *plus = [UIImage imageNamed:@"addCircleButton.png"];
    
    
    
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
    [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0], NSForegroundColorAttributeName,
    [UIFont fontWithName:@"AeroviasBrasilNF" size:30.0], NSFontAttributeName, nil]];
    
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
    highlightedImage:storyMenuItemImagePressed
    ContentImage:starImage
    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
    highlightedImage:storyMenuItemImagePressed
    ContentImage:starImage
    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
    highlightedImage:storyMenuItemImagePressed
    ContentImage:starImage
    highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, nil];
    
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"addCircleButton.png"]
    highlightedImage:[UIImage imageNamed:nil]
    ContentImage:[UIImage imageNamed:@"addCircleButton.png"]
    highlightedContentImage:nil];
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:self.view.bounds startItem:startItem optionMenus:menus];
    menu.delegate = self;
    
    menu.menuWholeAngle = M_PI_2;
    menu.farRadius = 110.0f;
    menu.rotateAngle = 5.0f;
    menu.endRadius = 100.0f;
    menu.nearRadius = 90.0f;
    menu.animationDuration = 0.3f;
    menu.startPoint = CGPointMake(250.0, 520.0);
    
    [self.view addSubview:menu];
    
}
    
- (void)didTapBarButton:(id)sender
{
    [self.sidePanelController showLeftPanelAnimated:YES];
}
    
    //Menu Response
- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    BOOL *instagramActive = [user boolForKey:@"isInstagramLoggedIn"];
    BOOL *twitterActive = [user boolForKey:@"TwitterAuthenticated"];
    
    if (idx == 0) {
        
        NSString *callbackUrl = @"floadt://instagram_callback";
        
        [[InstagramClient sharedClient] authenticateWithClientID:INSTAGRAM_CLIENT_ID callbackURL:callbackUrl];
        
    } else if (idx == 1) {
        NSLog(@"twitter");
        [[TwitterClient sharedClient] authenticateWithTwitter];
        
    }else{
        NSLog(@"Facebook Auth");
    }
}

@end
