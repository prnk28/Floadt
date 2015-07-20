//
//  ForiegnInstagramController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 5/27/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import "ForiegnInstagramController.h"
#import "Data.h"
#import "ForeignInstagramViewHeader.h"

@interface ForiegnInstagramController () <MXSegmentedPagerDelegate, MXSegmentedPagerDataSource, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) MXSegmentedPager  * segmentedPager;
@property (nonatomic, strong) UITableView       * tableView;
@property (nonatomic, strong) UIWebView         * webView;
@property (nonatomic, strong) ForeignInstagramViewHeader *header;
@end

@implementation ForiegnInstagramController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *userID = self.instagramData[@"user"][@"id"];
    [self getInstaDataWithUserID:userID];
    [self initUI];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.segmentedPager];
    
    [self.segmentedPager setParallaxHeaderView:self.header mode:VGParallaxHeaderModeFill height:150.f];
    
    self.segmentedPager.minimumHeaderHeight = 20.f;
    
    self.segmentedPager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedPager.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedPager.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.segmentedPager.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
    self.segmentedPager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedPager.segmentedControl.selectionIndicatorColor = [UIColor orangeColor];
    
    self.segmentedPager.segmentedControlEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
}

- (void)viewWillLayoutSubviews {
    self.segmentedPager.frame = (CGRect){
        .origin = CGPointZero,
        .size   = self.view.frame.size
    };
    [super viewWillLayoutSubviews];
}

#pragma -mark private methods

- (MXSegmentedPager *)segmentedPager {
    if (!_segmentedPager) {
        
        // Set a segmented pager below the cover
        _segmentedPager = [[MXSegmentedPager alloc] init];
        _segmentedPager.delegate    = self;
        _segmentedPager.dataSource  = self;
    }
    return _segmentedPager;
}

- (UITableView *)tableView {
    if (!_tableView) {
        //Add a table page
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIWebView *)webView {
    if (!_webView) {
        // Add a web page
        _webView = [[UIWebView alloc] init];
        NSString *strURL = @"http://nshipster.com/";
        NSURL *url = [NSURL URLWithString:strURL];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:urlRequest];
    }
    return _webView;
}

- (ForeignInstagramViewHeader *)header {
    if (!_header) {
        _header = [[ForeignInstagramViewHeader alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
    }
    return _header;
}

#pragma -mark <MXSegmentedPagerDelegate>

- (CGFloat)heightForSegmentedControlInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return 30.f;
}

- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didSelectViewWithTitle:(NSString *)title {
    NSLog(@"%@ page selected.", title);
}

#pragma -mark <MXSegmentedPagerDataSource>

- (NSInteger)numberOfPagesInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return 3;
}

- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    return [@[@"Grid", @"Line", @"PhotosOf"] objectAtIndex:index];
}

- (UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {
    return [@[self.tableView, self.webView, self.tableView] objectAtIndex:index];
}

#pragma -mark <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    

}

#pragma -mark <UITableViewDataSource>

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = (indexPath.row % 2)? @"Text" : @"Web";
    
    return cell;
}

- (void)initUI {
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [barButton setTitle:@"" forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [barButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    barButton.frame = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    

    
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                      [UIColor colorWithRed:179.0/255.0 green:177.0/255.0 blue:177.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                                      [UIFont fontWithName:@"AeroviasBrasilNF" size:30.0], NSFontAttributeName, nil]];
}

-(void)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)getInstaDataWithUserID:(NSString *)user {
    NSString *path = [NSString stringWithFormat:@"users/%@", user];
    
    [[InstagramClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        self.instaUser = [[InstagramUser alloc] init];
        [self.instaUser setBio:responseObject[@"data"][@"bio"]];
        self.instaUser.followed_by = responseObject[@"data"][@"counts"][@"followed_by"];
        self.instaUser.follows = responseObject[@"data"][@"counts"][@"follows"];
        self.instaUser.media = responseObject[@"data"][@"counts"][@"media"];
        self.instaUser.full_name = responseObject[@"data"][@"full_name"];
        self.instaUser.idvalue = responseObject[@"data"][@"id"];
        self.instaUser.profile_picture = responseObject[@"data"][@"profile_picture"];
        self.instaUser.username = responseObject[@"data"][@"username"];
        self.instaUser.website = responseObject[@"data"][@"website"];
        
        //UPDATE
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self header] updateWithUserDetails:self.instaUser];
            self.navigationItem.title = self.instaUser.username;
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
