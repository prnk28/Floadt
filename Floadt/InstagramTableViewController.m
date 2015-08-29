//
//  InstagramTableViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 1/14/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import "InstagramTableViewController.h"
#import "MBProgressHUD.h"

@interface InstagramTableViewController ()<MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
}
@end

@implementation InstagramTableViewController

@synthesize instaPics;
@synthesize instagramResponse;

// On Page Load initialize Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavbarGestureRecognizer];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    self.tableView.allowsSelection = NO;
    [self.tableView registerClass:[InstagramCell class] forCellReuseIdentifier:@"InstaCell"];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"instagramActive"]){
        [self fetchInstagramPics];
        [self.tableView reloadData];
    }
    [self.tableView setScrollsToTop:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

// Number of Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Number of Rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return instaPics.count;
}

// Default Cell Size
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 503;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - XLPagerTabStripViewControllerDelegate

// Title for View
-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"Instagram";
}

// Default color for Page Strip
-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
}

// Setup Table View Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InstagramCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"InstaCell"];
    
    if (cell == nil) {
        cell = [[InstagramCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InstaCell"];
    }
    
    NSDictionary *entry = instaPics[indexPath.row];
    
    // Set Image
    NSString *imageUrlString = entry[@"images"][@"low_resolution"][@"url"];
    NSURL *url = [NSURL URLWithString:imageUrlString];
    cell.instagramPic.userInteractionEnabled = YES;
    [cell.instagramPic sd_setImageWithURL:url];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
    tap.cancelsTouchesInView = YES;
    tap.numberOfTapsRequired = 2;
    tap.delegate = self;
    [cell.instagramPic addGestureRecognizer:tap];
    
    // Set User Name
    NSString *user = entry[@"user"][@"username"];
    [cell.nameLabel setTitle:user forState:UIControlStateNormal];
    [cell.nameLabel addTarget:self action:@selector(profilePicTapped:) forControlEvents:UIControlEventTouchUpInside];

    // Determine if Entry was previously liked
    id liked = entry[@"user_has_liked"];
    
    if ([liked integerValue] == 1) {
        [cell.animeButton select];
        
    } else {
        [cell.animeButton deselect];
        
    }
    
    // If no Caption
    if (entry[@"caption"] != [NSNull null] && entry[@"caption"][@"text"] != [NSNull null])            {
        NSString *caption = entry[@"caption"][@"text"];
        [cell.commentText setText:caption];
    }else{
        NSString *caption = @"";
        [cell.commentText setText:caption];
    }
    
    // Set Timestamp
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[entry[@"created_time"] doubleValue]];
    NSDate *currentDateNTime = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    NSDateComponents *instacomponents = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    NSInteger instahour = [instacomponents hour];
    NSInteger instaminute = [instacomponents minute];
    NSInteger instasecond = [instacomponents second];
    NSDateComponents *realcomponents = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:currentDateNTime];
    NSInteger realhour = [realcomponents hour];
    NSInteger realminute = [realcomponents minute];
    NSInteger realsecond = [realcomponents second];
    
    NSInteger hour = realhour - instahour;
    NSInteger minute = realminute - instaminute;
    NSInteger second = realsecond - instasecond;
    
    int adjustedSeconds = ((int)minute * 60) - abs((int)second);
    int adjustedMinutes = adjustedSeconds / 60;
    
    if (hour==1 > minute > 0) {
        int negmin = ((int)hour * 60) - abs((int)minute);
        int posmin = abs(negmin);
        NSString *strInt = [NSString stringWithFormat:@"%dm",posmin];
        cell.timeAgo.text = strInt;
    }else if (hour>0){
        NSString *strInt = [NSString stringWithFormat:@"%ldh",(long)hour];
        cell.timeAgo.text = strInt;
    }else if (hour==1){
        NSString *strInt = [NSString stringWithFormat:@"%ldh",(long)hour];
        cell.timeAgo.text = strInt;
    }else if(minute == 1 > second){
        NSString *strInt = [NSString stringWithFormat:@"%lds",(long)second];
        cell.timeAgo.text = strInt;
    }else{
        NSString *strFromInt = [NSString stringWithFormat:@"%dm",adjustedMinutes];
        cell.timeAgo.text = strFromInt;
    }

    // Set the number of likes
    NSString *likesCount = entry[@"likes"][@"count"];
    NSString *likes = [NSString stringWithFormat: @"%@", likesCount];
    [cell.likeLabel setText:likes];
    
    // Add Profile Image
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *imageUrl = entry[@"user"][@"profile_picture"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.profilePic setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
            CALayer *imageLayer = cell.profilePic.layer;
            [imageLayer setCornerRadius:17.5];
            [imageLayer setMasksToBounds:YES];
        });
    });
    [cell.profilePic addTarget:self action:@selector(profilePicTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    // Button's
    [cell.animeButton addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    [cell.animeButton setObjectID:entry[@"id"]];
    [cell.animeButton setLikesCount:entry[@"likes"][@"count"]];
    
    [cell.commentButton addTarget:self action:@selector(commentButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *instapic = [self.instaPics objectAtIndex:indexPath.row];
    
    if (entry[@"videos"] != nil) {
        NSLog(@"There is a Video: %@", entry[@"videos"]);
        NSString *urlString = entry[@"videos"][@"standard_resolution"][@"url"];
        NSLog(urlString);
        NSURL *url = [NSURL URLWithString:urlString];
        [cell initiateVideoWithURL:url];
        [cell.playButton addGestureRecognizer:tap];
    }else{
        [cell.player stop];
        cell.player.view.hidden = YES;
    }
    
    return cell;
}

- (void) handleImageTap:(UIGestureRecognizer *)gestureRecognizer {
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"heart-white.png"]];
    
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.delegate = self;
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:0.75];
}

// On profile Picture Tap
- (void)profilePicTapped:(UIImageView *)sender {
    NSLog(@"Profile pic image tapped");
    ForiegnInstagramController *forInsta = [[ForiegnInstagramController alloc] init];
    NSIndexPath *i = [self indexPathForCellContainingView:sender.superview];
    NSInteger row = i.row;
    NSDictionary *pic = [instaPics objectAtIndex:row];
    forInsta.instagramData = pic;
    forInsta.entersFromSearch = NO;
    [self.navigationController pushViewController:forInsta animated:YES];
}

// On comment Button Tap
- (void)commentButtonTap:(UIButton *)sender {
    NSLog(@"Comment Button Tapped");
    MessageViewController *message = [[MessageViewController alloc] init];
    NSIndexPath *i=[self indexPathForCellContainingView:sender.superview];
    NSInteger row = i.row;
    NSDictionary *pic = [instaPics objectAtIndex:row];
    message.instagramData = pic;
    [self.navigationController pushViewController:message animated:YES];
}

// On Anime Button Tap
-(void)tapped:(DOFavoriteButton*) sender {
    if (sender.selected) {
        // deselect
        [sender deselect];
    } else {
        // select with animation
        [sender select];
        // Set objectID
        NSString *objectID = sender.objectID;
        
        NSString *path = [NSString stringWithFormat:@"media/%@/likes", objectID];
        [[InstagramClient sharedClient] postPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Successfully Liked Picture");
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failure: %@", error);
        }];
    }
}


// Gesture Recognizer for Floadt Tap
- (void)setupNavbarGestureRecognizer {
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navBarTap)];
    gestureRecognizer.numberOfTapsRequired = 1;
    CGRect frame = CGRectMake(self.view.frame.size.width/4, 0, self.view.frame.size.width/2, 44);
    UIView *navBarTapView = [[UIView alloc] initWithFrame:frame];
    [self.navigationController.navigationBar addSubview:navBarTapView];
    navBarTapView.backgroundColor = [UIColor clearColor];
    [navBarTapView setUserInteractionEnabled:YES];
    [navBarTapView addGestureRecognizer:gestureRecognizer];
}

// When user touches Floadt Text
- (void)navBarTap {
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

// Fetch initial Posts
- (void)fetchInstagramPics {
    instaPics = [[NSMutableArray alloc] init];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL *status = [user boolForKey:@"instagramActive"];
    if (status) {
        [[InstagramClient sharedClient] getPath:@"users/self/feed"
                                     parameters:nil
                                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                            instagramResponse = [responseObject mutableCopy];
                                            NSLog(@"%@",responseObject);
                                            [self.instaPics addObjectsFromArray:responseObject[@"data"]];
                                            
                                            [self.tableView reloadData];
                                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                            NSLog(@"Failure: %@", error);
                                        }];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

// Get Location of Post
- (void)getLocationWithLatitude:(NSString *)lat andLongitude:(NSString *)lon {
    NSURL *url = [NSURL URLWithString:@"https://maps.googleapis.com/maps/api/geocode/json"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    NSString *latlongcomma = [NSString stringWithFormat:@"%@,%@",lat,lon];
    NSDictionary *params = @{
                                @"latlng" :latlongcomma,
                                @"key" : @"AIzaSyBnN0JTkXJUQEqwBekCz5mLCTStWkEH3zA"
                            };

    [httpClient getPath:@"" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@",error);
    }];
}

// Fetch Next Page
- (void)fetchNextInstagramPage {
    NSDictionary *page = instagramResponse[@"pagination"];
    NSString *nextPage = page[@"next_url"];
    
    [[InstagramClient sharedClient] getPath:[NSString stringWithFormat:@"%@",nextPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        instagramResponse = [responseObject mutableCopy];
        [instagramResponse addEntriesFromDictionary:responseObject];
        [instaPics addObjectsFromArray:responseObject[@"data"]];
        [self.tableView reloadData];
        
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

// Refresh Feed
- (void)refresh:(UIRefreshControl *)refreshControl {
    [self fetchInstagramPics];
    [refreshControl endRefreshing];
}

-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    
}


// Get Active Cell
- (NSIndexPath *)indexPathForCellContainingView:(UIView *)view {
    while (view != nil) {
        if ([view isKindOfClass:[InstagramCell class]]) {
            return [self.tableView indexPathForCell:(InstagramCell *)view];
        } else {
            view = [view superview];
        }
    }
    return nil;
}
@end
