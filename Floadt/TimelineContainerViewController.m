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
    
    rootView = self.navigationController.view;

    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpUI{
    BOOL insta = [[NSUserDefaults standardUserDefaults] boolForKey:@"instagramActive"];
    BOOL twitter = [[NSUserDefaults standardUserDefaults] boolForKey:@"twitterActive"];
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    if (!insta&&!twitter) {
        [self introductionView];
    }
    reach.unreachableBlock = ^(Reachability*reach)
    {
        UIView *noNetwork = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        imageView.image = [UIImage imageNamed:@"noNetwork"];
        [noNetwork addSubview:imageView];
        [self.view addSubview:imageView];
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

- (void)introductionView {
     NSString *description = @"Floadt is the minimalistic and simple way to streamline your Social Media onto one giant hub. Continue to add your Twitter and Instagram accounts. The tutorial will be ended when one account is supplied.";
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Floadt";
    page1.desc = description;
    page1.bgImage = [UIImage imageNamed:@"Page 1"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fldtTitle"]];
    
    UIView *viewForPage2 = [[UIView alloc] initWithFrame:rootView.bounds];
    
    // Twitter Button
    JSFlatButton *twitter = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 0, 320, 284)];
    twitter.buttonBackgroundColor = [UIColor colorWithRed:0.000 green:0.870 blue:1.000 alpha:1.000];
    twitter.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    twitter.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [twitter setFlatTitle:nil];
    [twitter setFlatImage:[UIImage imageNamed:@"twitterImage"]];
    [twitter addTarget:self action:@selector(twitterTapped:) forControlEvents:UIControlEventTouchDown];
    [viewForPage2 addSubview:twitter];
    
    // Instagram Button
    JSFlatButton *instagram = [[JSFlatButton alloc] initWithFrame:CGRectMake(0, 284, 320, 284)];
    instagram.buttonBackgroundColor = [UIColor colorWithRed:0.573 green:0.183 blue:0.000 alpha:1.000];
    instagram.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    instagram.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [instagram setFlatTitle:nil];
    [instagram setFlatImage:[UIImage imageNamed:@"instagramImage"]];
    [instagram addTarget:self action:@selector(instagramTapped:) forControlEvents:UIControlEventTouchDown];
    [viewForPage2 addSubview:instagram];
    
    EAIntroPage *page2 = [EAIntroPage pageWithCustomView:viewForPage2];
    page2.bgImage = [UIImage imageNamed:@"bg2"];
    intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:@[page1,page2]];
    intro.swipeToExit = NO;
    intro.skipButton = nil;
    [intro setDelegate:self];
    [intro showInView:rootView animateDuration:0.3];
}

- (void)instagramTapped:(id)sender {
    intro.swipeToExit = YES;
    [[InstagramClient sharedClient] authenticateWithClientID:@"88b3fb2cd93c4aacb053b44b35b86187" callbackURL:@"floadt://instagram_callback"];
}

- (void)twitterTapped:(id)sender {
    intro.swipeToExit = YES;
    self.twitterClient = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/"]
                                                             key:@"tA5TT8uEtg88FwAHnVpBcbUoq"
                                                          secret:@"L5whWoi91HmzjrE5bNPNUgoMXWnImvpnkIPHZWQ4VmymaoXyYV"];
    
    [self.twitterClient authorizeUsingOAuthWithRequestTokenPath:@"oauth/request_token"
                                          userAuthorizationPath:@"oauth/authorize"
                                                    callbackURL:[NSURL URLWithString:@"floadt://success"]
                                                accessTokenPath:@"oauth/access_token"
                                                   accessMethod:@"GET"
                                                          scope:nil
                                                        success:^(AFOAuth1Token *accessToken, id response) {
                                                            [AFOAuth1Token storeCredential:accessToken withIdentifier:@"TwitterToken"];
                                                            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"twitterActive"];
                                                        } failure:^(NSError *error) {
                                                            NSLog(@"Error: %@", error);
                                                        }];

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
