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
#import "SIAlertView.h"

@interface ForiegnInstagramController () <MXSegmentedPagerDelegate, MXSegmentedPagerDataSource, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) MXSegmentedPager  * segmentedPager;
@property (nonatomic, strong) UITableView       * tableView;
@property (nonatomic, strong) UIWebView         * webView;
@property (nonatomic, strong) ForeignInstagramViewHeader *header;
@property (nonatomic, strong) UICollectionView *collectionView;
@end
@implementation ForiegnInstagramController

@synthesize instagramResponse;
@synthesize instaPics;

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.idValue == nil) {
        NSString *userID = self.instagramData[@"user"][@"id"];
        [self getInstaDataWithUserID:userID];
        [self fetchInstagramPicsForUser:userID];
    } else {
        [self getInstaDataWithUserID:self.idValue];
        [self fetchInstagramPicsForUser:self.idValue];
    }
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

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        _collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
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
    return [@[self.collectionView, self.tableView, self.webView] objectAtIndex:index];
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

#pragma -mark <UICollectionViewData>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return instaPics.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor orangeColor];
    NSDictionary *entry = instaPics[indexPath.row];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *imageUrlString = entry[@"images"][@"low_resolution"][@"url"];
        NSURL *url = [NSURL URLWithString:imageUrlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.frame];
            imageView.image = [UIImage imageWithData:data];
            cell.backgroundView = imageView;
        });
    });
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(104, 104);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0;
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
    return UIEdgeInsetsMake(0,0,0,0);  // top, left, bottom, right
}

// Other Methods
- (void)initUI {
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [barButton setTitle:@"" forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [barButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    barButton.frame = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    UIButton *gearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [gearButton setTitle:@"" forState:UIControlStateNormal];
    [gearButton setBackgroundImage:[UIImage imageNamed:@"19-gear"] forState:UIControlStateNormal];
    [gearButton addTarget:self action:@selector(didTapGearButton:) forControlEvents:UIControlEventTouchUpInside];
    gearButton.frame = CGRectMake(0.0f, 0.0f, 18.0f, 18.0f);
    UIBarButtonItem *gearButtonItem = [[UIBarButtonItem alloc] initWithCustomView:gearButton];
    
    self.navigationItem.rightBarButtonItem = gearButtonItem;

    if (self.entersFromSearch == NO) {
        [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                      [UIColor colorWithRed:179.0/255.0 green:177.0/255.0 blue:177.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                                      [UIFont fontWithName:@"AeroviasBrasilNF" size:30.0], NSFontAttributeName, nil]];
    }else{
        [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                          [UIFont fontWithName:@"AeroviasBrasilNF" size:30.0], NSFontAttributeName, nil]];
    }
}

-(void)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didTapGearButton:(id)sender
{
    if ([self.instaUser.incoming_status isEqual:@"none"]) {
        JGActionSheetSection *section = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"Block"] buttonStyle:JGActionSheetButtonStyleDefault];
        [section setButtonStyle:JGActionSheetButtonStyleRed forButtonAtIndex:0];
        NSArray *sections = (@[section, [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"Cancel"] buttonStyle:JGActionSheetButtonStyleCancel]]);
        
        JGActionSheet *sheetI = [[JGActionSheet alloc] initWithSections:sections];
        sheetI.delegate = self;
        [sheetI setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
            if (indexPath.row == 0) {
                NSLog(@"pressed index 0");
                SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Block?" andMessage:@"Are you sure you want to block this user?"];
                [alertView addButtonWithTitle:@"Cancel"
                                         type:SIAlertViewButtonTypeCancel
                                      handler:^(SIAlertView *alert) {
                                          NSLog(@"Cancel Clicked");
                                      }];
                [alertView addButtonWithTitle:@"Block"
                                         type:SIAlertViewButtonTypeDestructive
                                      handler:^(SIAlertView *alert) {
                                          NSLog(@"Block Clicked");
                                      }];
                alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                [alertView show];
                [sheet dismissAnimated:YES];
            }
        }];
        [sheetI showInView:self.navigationController.view animated:YES];
    } else {
        NSString *incomStatus = [[NSString alloc] init];
        if([self.instaUser.incoming_status  isEqual: @"followed_by"]) {
            incomStatus = @"Follows You";
        }
        if([self.instaUser.incoming_status  isEqual: @"requested_by"]) {
            incomStatus = @"Follows You";
        }
        if([self.instaUser.incoming_status  isEqual: @"blocked_by_you"]) {
            incomStatus = @"Follows You";
        }
    
        JGActionSheetSection *section = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"Block",incomStatus] buttonStyle:JGActionSheetButtonStyleDefault];
        [section setButtonStyle:JGActionSheetButtonStyleRed forButtonAtIndex:0];
        NSArray *sections = (@[section, [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:@[@"Cancel"] buttonStyle:JGActionSheetButtonStyleCancel]]);
        
        JGActionSheet *sheetI = [[JGActionSheet alloc] initWithSections:sections];
        sheetI.delegate = self;
        [sheetI setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
            if (indexPath.row == 0) {
                SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Block?" andMessage:@"Are you sure you want to block this user?"];
                [alertView addButtonWithTitle:@"Cancel"
                                         type:SIAlertViewButtonTypeCancel
                                      handler:^(SIAlertView *alert) {
                                          NSLog(@"Cancel Clicked");
                                      }];
                [alertView addButtonWithTitle:@"Block"
                                         type:SIAlertViewButtonTypeDestructive
                                      handler:^(SIAlertView *alert) {
                                          NSLog(@"Block Clicked");
                                      }];
                alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                [alertView show];
                [sheet dismissAnimated:YES];
            } else {
                [sheet dismissAnimated:YES];
            }
        }];
        [sheetI showInView:self.navigationController.view animated:YES];
    }
}

- (void)blockUser:(NSString *)user {

}

- (void)checkRelationshipStatus:(NSString *)user {
    NSString *path = [NSString stringWithFormat:@"users/%@/relationship", user];
    
    [[InstagramClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response Object: %@",responseObject);
        self.instaUser.incoming_status = responseObject[@"data"][@"incoming_status"];
        self.instaUser.outgoing_status = responseObject[@"data"][@"outgoing_status"];
        self.instaUser.target_user_is_private = responseObject[@"data"][@"target_user_is_private"];
        //UPDATE
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self header] updateWithUserDetails:self.instaUser];
            self.navigationItem.title = self.instaUser.username;
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

//Global refresh Instagram Method
// Fetch initial Posts
- (void)fetchInstagramPicsForUser:(NSString *)user {
    instaPics = [[NSMutableArray alloc] init];
    
    NSString *path = [NSString stringWithFormat:@"users/%@/media/recent",user];
    [[InstagramClient sharedClient] getPath:path
                                     parameters:nil
                                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                            instagramResponse = [responseObject mutableCopy];
                                            NSLog(@"%@",responseObject);
                                            [self.instaPics addObjectsFromArray:responseObject[@"data"]];
                                            [self.collectionView reloadData];
                                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                            NSLog(@"Failure: %@", error);
                                        }];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

// Fetch Next Page
- (void)fetchNextInstagramPage {
    NSDictionary *page = instagramResponse[@"pagination"];
    NSString *nextPage = page[@"next_url"];
    
    [[InstagramClient sharedClient] getPath:[NSString stringWithFormat:@"%@",nextPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        instagramResponse = [responseObject mutableCopy];
        [instagramResponse addEntriesFromDictionary:responseObject];
        [instaPics addObjectsFromArray:responseObject[@"data"]];
        [self.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
    }];
}

// Bottome of UITableView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y == roundf(scrollView.contentSize.height-scrollView.frame.size.height)) {
        [self fetchNextInstagramPage];
    }
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
        [self checkRelationshipStatus:user];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
