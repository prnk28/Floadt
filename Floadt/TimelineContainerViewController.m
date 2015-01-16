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
    BOOL *insta = [[NSUserDefaults standardUserDefaults] boolForKey:@"instagramActive"];
    BOOL *twitter = [[NSUserDefaults standardUserDefaults] boolForKey:@"twitterActive"];
    BOOL *facebook = [[NSUserDefaults standardUserDefaults] boolForKey:@"facebookActive"];
    if (!insta&&!twitter&&!facebook) {
        UIView *nobodyLoggedIn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        GHContextMenuView* overlay = [[GHContextMenuView alloc] init];
        overlay.dataSource = self;
        overlay.delegate = self;
        
        UILongPressGestureRecognizer* _longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:overlay action:@selector(longPressDetected:)];
        [nobodyLoggedIn addGestureRecognizer:_longPressRecognizer];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        imageView.image = [UIImage imageNamed:@"noNetworks_grey.png"];
        [nobodyLoggedIn addSubview:imageView];
        [self.view addSubview:nobodyLoggedIn];
    }
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

- (NSInteger) numberOfMenuItems
{
    return 3;
}

-(UIImage*) imageForItemAtIndex:(NSInteger)index
{
    NSString* imageName = nil;
    switch (index) {
        case 0:
            imageName = @"twitter dark";
            break;
        case 1:
            imageName = @"facebook dark";
            break;
        case 2:
            imageName = @"instagram dark";
            break;
            
        default:
            break;
    }
    return [UIImage imageNamed:imageName];
}

- (void) didSelectItemAtIndex:(NSInteger)selectedIndex forMenuAtPoint:(CGPoint)point
{
    switch (selectedIndex) {
        case 0:
            if (![[NSUserDefaults standardUserDefaults] boolForKey:@"twitterActive"]) {
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
            } else {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Really Logout of Twitter?"
                                                                         delegate:self
                                                                cancelButtonTitle:@"Cancel"
                                                           destructiveButtonTitle:@"Logout"
                                                                otherButtonTitles:nil];
                actionSheet.tag = 100;
                [actionSheet showInView:self.view];
            }
            break;
        case 1:
            if (![[NSUserDefaults standardUserDefaults] boolForKey:@"facebookActive"]) {
                [SCFacebook loginCallBack:^(BOOL success, id result) {
                    if (success) {
                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"facebookActive"];
                    }
                }];
            } else {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Really Logout of Facebook?"
                                                                         delegate:self
                                                                cancelButtonTitle:@"Cancel"
                                                           destructiveButtonTitle:@"Logout"
                                                                otherButtonTitles:nil];
                actionSheet.tag = 200;
                [actionSheet showInView:self.view];
            }
            break;
        case 2:
            if (![[NSUserDefaults standardUserDefaults] boolForKey:@"instagramActive"]) {
                [[InstagramClient sharedClient] authenticateWithClientID:@"88b3fb2cd93c4aacb053b44b35b86187" callbackURL:@"floadt://instagram_callback"];
            } else {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Really Logout of Instagram?"
                                                                         delegate:self
                                                                cancelButtonTitle:@"Cancel"
                                                           destructiveButtonTitle:@"Logout"
                                                                otherButtonTitles:nil];
                
                actionSheet.tag = 300;
                [actionSheet showInView:self.view];
            }
            break;
        default:
            break;
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 100) {
        if(buttonIndex == 0){
            NSLog(@"pressed index 0");
            [AFOAuthCredential deleteCredentialWithIdentifier:@"TwitterToken"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"twitterActive"];
        }
    }
    else if (actionSheet.tag == 200){
        if(buttonIndex == 0){
            [SCFacebook loginCallBack:^(BOOL success, id result) {
                if (success) {
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"facebookActive"];
                }
            }];
        }
    }
    else{
        if(buttonIndex == 0){
            [JNKeychain deleteValueForKey:@"instaToken"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"instagramActive"];
        }
    }
}

- (void)didTapBarButton:(id)sender
{
    [self.sidePanelController showLeftPanelAnimated:YES];
}
@end
