//
//  SettingsViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/31/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//
#define INSTAGRAM_CLIENT_ID @"88b3fb2cd93c4aacb053b44b35b86187"
#define FACEBOOK_APP_ID @"262960803773270"
#define TWITTER_OAUTH @"CG0aslVuOiPGuYM4TRf3Sg"

#import "SettingsViewController.h"
#import "AwesomeMenu.h"
#import "Imports.h"
#import "InstagramClient.h"
#import "TwitterClient.h"
#import "AppData.h"
#import "AFOAuth1Client.h"
#import "AFNetworking.h"

@implementation SettingsViewController

@synthesize window = _window;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [settingsButton setTitle:@"" forState:UIControlStateNormal];
    [settingsButton setBackgroundImage:[UIImage imageNamed:@"settingsButton.png"] forState:UIControlStateNormal];
    [settingsButton setBackgroundImage:[UIImage imageNamed:@"settingsButton_s.png"] forState:UIControlStateHighlighted];
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
    
    
    //Add Network
    
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
	UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    UIImage *twitter = [UIImage imageNamed:@"twitter.png"];
	UIImage *twitterH = [UIImage imageNamed:@"twitterH.png"];
    UIImage *fb = [UIImage imageNamed:@"fb.png"];
    UIImage *fbH = [UIImage imageNamed:@"fbH.png"];
    UIImage *ig = [UIImage imageNamed:@"ig.png"];
    UIImage *igH = [UIImage imageNamed:@"igH.png"];
    
	UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
    
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:twitter
                                                           highlightedImage:twitterH
                                                               ContentImage:nil
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:fb
                                                           highlightedImage:fbH
                                                               ContentImage:nil
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:ig
                                                           highlightedImage:igH
                                                               ContentImage:nil
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem5 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, starMenuItem5, nil];
    
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"bg-addbutton.png"]
                                                       highlightedImage:[UIImage imageNamed:@"bg-addbutton-highlighted.png"]
                                                           ContentImage:[UIImage imageNamed:@"icon-plus.png"]
                                                highlightedContentImage:[UIImage imageNamed:@"icon-plus-highlighted.png"]];
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:self.view.bounds startItem:startItem optionMenus:menus];
    
   	menu.menuWholeAngle = M_PI_2;
	menu.farRadius = 110.0f;
	menu.endRadius = 100.0f;
	menu.nearRadius = 90.0f;
    menu.animationDuration = 0.3f;
    menu.startPoint = CGPointMake(50.0, 500.0);
    
    menu.delegate = self;
    
    [self.view addSubview:menu];
    
    
}

/* ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇ */
/* ⬇⬇⬇⬇⬇⬇ GET RESPONSE OF MENU ⬇⬇⬇⬇⬇⬇ */
/* ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇ */
- (void)authenticateWithInstagram {
    
    NSString *callbackUrl = @"floadt://instagram_callback";
    
    [[InstagramClient sharedClient] authenticateWithClientID:INSTAGRAM_CLIENT_ID callbackURL:callbackUrl];
    
}



- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    AppData *data = [AppData sharedManager];
    
    if (idx==0) {
        

        
        [self.twitterClient authorizeUsingOAuthWithRequestTokenPath:@"oauth/request_token"
                                         userAuthorizationPath:@"oauth/authorize"
                                                   callbackURL:[NSURL URLWithString:@"floadt://twitterConfirmed"]
                                               accessTokenPath:@"oauth/access_token"
                                                  accessMethod:@"POST"
                                                         scope:nil
                                                       success:^(AFOAuth1Token *accessToken, id response) {
                                                           
                                                           [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
                                                           [self.twitterClient getPath:@"1.1/statuses/user_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                               NSArray *responseArray = (NSArray *)responseObject;
                                                               [responseArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                                   NSLog(@"Success: %@", obj);
                                                               }];
                                                           }                                               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                               NSLog(@"Error: %@", error);
                                                           }];
                                                           
                                                       } failure:^(NSError *error) {
                                                           NSLog(@"Error: %@", error);
                                                       }];
    
    }else if (idx == 1){
        
        
    }else if (idx == 2){
        
        
        if (data.instagramActive) {
              RNBlurModalView *modal = [[RNBlurModalView alloc]initWithViewController:self title:@"Sorry.." message:@"Instagram is Already Logged In!"];
                [modal show];
        }else{
           [self authenticateWithInstagram];
        } 
        
    }else if (idx == 3){
        
    }else{
        
    }
}


- (void)didTapBarButton:(id)sender {
    
    [self.sidePanelController showLeftPanelAnimated:YES];

    
}

- (void)didTapSettingsButton:(id)sender {
    
    
    
}

- (IBAction)buttt:(id)sender {
   



}
@end
