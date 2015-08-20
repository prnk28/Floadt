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

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:1.0f green:0.505f blue:0.0 alpha:1.00f]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [UIScrollView new];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:_scrollView];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    singleFingerTap.numberOfTapsRequired = 25;
    [_scrollView addGestureRecognizer:singleFingerTap];
    
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [barButton setTitle:@"" forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [barButton addTarget:self action:@selector(didTapBarButton:) forControlEvents:UIControlEventTouchUpInside];
    barButton.frame = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    self.navBar.leftBarButtonItem = barButtonItem;
   
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                      [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                      [UIFont fontWithName:@"AeroviasBrasilNF" size:30.0], NSFontAttributeName, nil]];
    _plusButtonsView = [[LGPlusButtonsView alloc] initWithView:_scrollView
                                               numberOfButtons:2
                                               showsPlusButton:YES
                                                 actionHandler:^(LGPlusButtonsView *plusButtonView, NSString *title, NSString *description, NSUInteger index)
                        {
                            NSLog(@"%@, %@, %i", title, description, (int)index);

                            switch (index) {
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
                                        JGActionSheetSection *section = [JGActionSheetSection sectionWithTitle:@"Logout?" message:@"Really logout of Twitter?" buttonTitles:@[@"Logout"] buttonStyle:JGActionSheetButtonStyleDefault];
                                        [section setButtonStyle:JGActionSheetButtonStyleRed forButtonAtIndex:0];
                                        NSArray *sections = (@[section, [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"Cancel"] buttonStyle:JGActionSheetButtonStyleCancel]]);
                                        JGActionSheet *sheet = [[JGActionSheet alloc] initWithSections:sections];
                                        sheet.delegate = self;
                                        [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
                                            if (indexPath.row == 0) {
                                                [AFOAuthCredential deleteCredentialWithIdentifier:@"TwitterToken"];
                                                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"twitterActive"];
                                                [[NSUserDefaults standardUserDefaults] synchronize];
                                                [sheet dismissAnimated:YES];
                                            }
                                        }];
                                        [sheet showInView:self.navigationController.view animated:YES];
                                    }
                                    break;
                                case 1:
                                    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"instagramActive"]) {
                                        [[InstagramClient sharedClient] authenticateWithClientID:@"88b3fb2cd93c4aacb053b44b35b86187" callbackURL:@"floadt://instagram_callback"];
                                    } else {
                                        JGActionSheetSection *section = [JGActionSheetSection sectionWithTitle:@"Logout?" message:@"Really logout of Instagram?" buttonTitles:@[@"Logout"] buttonStyle:JGActionSheetButtonStyleDefault];
                                        [section setButtonStyle:JGActionSheetButtonStyleRed forButtonAtIndex:0];
                                        NSArray *sections = (@[section, [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"Cancel"] buttonStyle:JGActionSheetButtonStyleCancel]]);
                                        JGActionSheet *sheetI = [[JGActionSheet alloc] initWithSections:sections];
                                        sheetI.delegate = self;
                                        [sheetI setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
                                            if (indexPath.row == 0) {
                                                [JNKeychain deleteValueForKey:@"instaToken"];
                                                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"instagramActive"];
                                                [[NSUserDefaults standardUserDefaults] synchronize];
                                                [sheet dismissAnimated:YES];
                                            }
                                        }];
                                        [sheetI showInView:self.navigationController.view animated:YES];
                                    }
                                    break;
                                default:
                                    break;
                            }

                        }
                        
    plusButtonActionHandler:nil];
    [_plusButtonsView setButtonsTitles:@[@"+", @"", @""] forState:UIControlStateNormal];
    [_plusButtonsView setDescriptionsTexts:@[@"", @"Twitter", @"Instagram"]];
    _plusButtonsView.position = LGPlusButtonsViewPositionBottomRight;
    _plusButtonsView.showWhenScrolling = YES;
    _plusButtonsView.appearingAnimationType = LGPlusButtonsAppearingAnimationTypeCrossDissolveAndSlideVertical;
    _plusButtonsView.buttonsAppearingAnimationType = LGPlusButtonsAppearingAnimationTypeCrossDissolveAndSlideHorizontal;
    _plusButtonsView.plusButtonAnimationType = LGPlusButtonAnimationTypeRotate;
    [_plusButtonsView setButtonsTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_plusButtonsView setButtonsAdjustsImageWhenHighlighted:NO];
    [_plusButtonsView showAnimated:NO completionHandler:nil];
}

- (void)didTapBarButton:(id)sender
{
    [self.sidePanelController showLeftPanelAnimated:YES];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
   // CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"#Za2Pect" message:@"I <3 Zaara Dean" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Ok"];
    [alert show];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    _scrollView.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 3000.f);
    
    CGFloat topInset = 0.f;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0)
    {
        topInset += (self.navigationController.navigationBarHidden ? 0.f : MIN(self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height));
        topInset += ([UIApplication sharedApplication].statusBarHidden ? 0.f : MIN([UIApplication sharedApplication].statusBarFrame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height));
    }
    // -----
    
    BOOL isPortrait = UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation);
    
    CGFloat shadowBlur = 3.f;
    CGFloat buttonSide = (isPortrait ? 64.f : 44.f);
    CGFloat buttonsFontSize = (isPortrait ? 30.f : 20.f);
    CGFloat plusButtonFontSize = buttonsFontSize*1.5;
    
    _plusButtonsView.contentInset = UIEdgeInsetsMake(shadowBlur, shadowBlur, shadowBlur, shadowBlur);
    [_plusButtonsView setButtonsTitleFont:[UIFont boldSystemFontOfSize:buttonsFontSize]];
    
    _plusButtonsView.plusButton.titleLabel.font = [UIFont systemFontOfSize:plusButtonFontSize];
    _plusButtonsView.plusButton.titleOffset = CGPointMake(0.f, -plusButtonFontSize*0.1);
    
    UIImage *circleImageNormal = [LGDrawer drawEllipseWithImageSize:CGSizeMake(buttonSide, buttonSide)
                                                               size:CGSizeMake(buttonSide-shadowBlur*2, buttonSide-shadowBlur*2)
                                                             offset:CGPointZero
                                                             rotate:0.f
                                                    backgroundColor:nil
                                                          fillColor:[UIColor colorWithRed:0.f green:0.5 blue:1.f alpha:1.f]
                                                        strokeColor:nil
                                                    strokeThickness:0.f
                                                         strokeDash:nil
                                                         strokeType:LGDrawerStrokeTypeInside
                                                        shadowColor:[UIColor colorWithWhite:0.f alpha:0.5]
                                                       shadowOffset:CGPointZero
                                                         shadowBlur:shadowBlur];
    
    UIImage *circleImageHighlighted = [LGDrawer drawEllipseWithImageSize:CGSizeMake(buttonSide, buttonSide)
                                                                    size:CGSizeMake(buttonSide-shadowBlur*2, buttonSide-shadowBlur*2)
                                                                  offset:CGPointZero
                                                                  rotate:0.f
                                                         backgroundColor:nil
                                                               fillColor:[UIColor colorWithRed:0.2 green:0.7 blue:1.f alpha:1.f]
                                                             strokeColor:nil
                                                         strokeThickness:0.f
                                                              strokeDash:nil
                                                              strokeType:LGDrawerStrokeTypeInside
                                                             shadowColor:[UIColor colorWithWhite:0.f alpha:0.5]
                                                            shadowOffset:CGPointZero
                                                              shadowBlur:shadowBlur];
    
    [_plusButtonsView setButtonsImage:circleImageNormal forState:UIControlStateNormal];
    [_plusButtonsView setButtonsImage:circleImageHighlighted forState:UIControlStateHighlighted];
    [_plusButtonsView setButtonsImage:circleImageHighlighted forState:UIControlStateHighlighted|UIControlStateSelected];
}

@end
