//
//  SettingsController2.m
//  ADVFlatUI
//
//  Created by Tope on 05/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//
#define INSTAGRAM_CLIENT_ID @"88b3fb2cd93c4aacb053b44b35b86187"
#define FACEBOOK_APP_ID @"262960803773270"
#define TWITTER_OAUTH @"CG0aslVuOiPGuYM4TRf3Sg"

#import "SettingsController2.h"
#import "Utils.h"
#import "RCSwitchOnOff.h"
#import "FlatTheme.h"
#import "AwesomeMenu.h"
#import "Imports.h"
#import "InstagramClient.h"
#import "AFOAuth1Client.h"
#import "AFNetworking.h"
#import "TwitterClient.h"

@interface SettingsController2 ()

@property (nonatomic, strong) NSArray* settingTitles;

@property (nonatomic, strong) NSArray* settingsElements;

@property (nonatomic, strong) NSString* boldFontName;

@property (nonatomic, strong) UIColor* onColor;

@property (nonatomic, strong) UIColor* offColor;

@property (nonatomic, strong) UIColor* dividerColor;

@end

@implementation SettingsController2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
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
    
    //Login
    self.boldFontName = @"Avenir-Black";
    
    
    self.onColor = [UIColor colorWithRed:222.0/255 green:59.0/255 blue:47.0/255 alpha:1.0f];
    self.offColor = [UIColor colorWithRed:242.0/255 green:228.0/255
    blue:227.0/255 alpha:1.0];
    self.dividerColor = [UIColor whiteColor];
    
   // [FlatTheme styleNavigationBarWithFontName:self.boldFontName
   // andColor:self.onColor];
    [FlatTheme styleSegmentedControlWithFontName:self.boldFontName
    andSelectedColor:self.onColor andUnselectedColor:self.offColor
    andDidviderColor:self.dividerColor];
    
    self.navigationItem.leftBarButtonItem = [Utils getMenuItem];
    self.navigationItem.rightBarButtonItem  = [Utils getSearchButtonItem];
    
    self.title = @"Settings";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundView = nil;

    
    self.tableView.backgroundColor = [UIColor colorWithRed:231.0/255 green:235.0/255 blue:238.0/255 alpha:1.0f];
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.settingTitles  = [NSArray arrayWithObjects:@"Bluetooth", @"Cloud backup", @"Show Offers", @"Streaming", @"Manage Accounts", nil];
    
    self.settingsElements = [NSArray arrayWithObjects:@"None", @"Switch", @"Segment", @"None", @"None", nil];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    headerView.backgroundColor = [UIColor clearColor];

    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(30, 9, 200, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:self.boldFontName size:20.0f];
    label.textColor = self.onColor;
    
    label.text = section == 0 ? @"Account Settings" : @"User Information";
    
    [headerView addSubview:label];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
   
    NSString* title = self.settingTitles[indexPath.row];
    
    cell.textLabel.text = [title uppercaseString];
    cell.textLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:self.boldFontName size:12.0f];
    
    NSString* element = self.settingsElements[indexPath.row];
    
    if([element isEqualToString:@"Switch"]){
        
        RCSwitchOnOff* cellSwitch = [self createSwitch];
        [cell addSubview:cellSwitch];
    }
    else if ([element isEqualToString:@"Segment"]){
        
        UISegmentedControl* control = [self createSegmentedControlWithItems:[NSArray arrayWithObjects:@"YES", @"NO", @"SOME", nil]];
        
        [cell addSubview:control];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

-(RCSwitchOnOff*)createSwitch{
    
    FlatTheme* theme = [[FlatTheme alloc] init];
    theme.switchOnBackground = [Utils drawImageOfSize:CGSizeMake(70, 30) andColor:self.onColor];
    theme.switchOffBackground = [Utils drawImageOfSize:CGSizeMake(70, 30) andColor:self.onColor];
    theme.switchThumb = [Utils drawImageOfSize:CGSizeMake(30, 29) andColor:self.offColor];
    theme.switchTextOffColor = [UIColor whiteColor];
    theme.switchTextOnColor = [UIColor whiteColor];
    theme.switchFont = [UIFont fontWithName:self.boldFontName size:12.0f];
    
    RCSwitchOnOff* settingSwitch = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(230, 7, 70, 30) andTheme:theme];
    return settingSwitch;
}

-(UISegmentedControl*)createSegmentedControlWithItems:(NSArray*)items{
    
    UISegmentedControl* segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    
    segmentedControl.frame = CGRectMake(150, 7, 150, 30);
    segmentedControl.selectedSegmentIndex = 0;
    
    return segmentedControl;
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
    
    if (idx==0) {
        
        [[TwitterClient sharedClient] authenticateWithTwitter];
        
    }else if (idx == 1){
        
    }else if (idx == 2){
        
        [self authenticateWithInstagram];
        
        
    }else if (idx == 3){
        
    }else{
        
    }
}


- (void)didTapBarButton:(id)sender {
    
    [self.sidePanelController showLeftPanelAnimated:YES];
    
}

- (void)didTapSettingsButton:(id)sender {
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
