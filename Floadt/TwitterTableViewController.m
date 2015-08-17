//
//  TwitterTableViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 1/14/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import "TwitterTableViewController.h"

@interface TwitterTableViewController ()

@end

@implementation TwitterTableViewController
@synthesize tweets;
@synthesize twitterResponse;
@synthesize userLookup;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavbarGestureRecognizer];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];

    [self.tableView registerClass:[TwitterCell class] forCellReuseIdentifier:@"TwitterCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"twitterActive"]) {
        [self fetchTweets];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return tweets.count;
}

#pragma mark - XLPagerTabStripViewControllerDelegate

-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"Twitter";
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TwitterCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TwitterCell"];
    
    if (cell == nil) {
        cell = [[TwitterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TwitterCell"];
    }
    
    // Add Tap Listeners
    UITapGestureRecognizer *nameLabelTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleCellNameTap:)];
    [cell.nameLabel addGestureRecognizer:nameLabelTap];
    
    UITapGestureRecognizer *profileImageTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleCellProfileImageTap:)];
    [cell.profilePicture addGestureRecognizer:profileImageTap];
    
    NSDictionary *data = tweets[indexPath.row];
    
    // NSDate
    NSString *nameString = data[@"user"][@"name"];
    NSString *screenName = data[@"user"][@"screen_name"];
    NSString *tweetString = data[@"text"];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat: @"EEE MMM dd HH:mm:ss Z yyyy"];
    
    NSDate *date = [dateFormatter dateFromString:[data objectForKey:@"created_at"]];
    NSDate *currentDateNTime = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    NSDateComponents *twitcomponents = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    NSInteger twithour = [twitcomponents hour];
    NSInteger twitminute = [twitcomponents minute];
    NSInteger twitsecond = [twitcomponents second];
    NSDateComponents *realcomponents = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:currentDateNTime];
    NSInteger realhour = [realcomponents hour];
    NSInteger realminute = [realcomponents minute];
    NSInteger realsecond = [realcomponents second];
    
    NSInteger hour = realhour - twithour;
    NSInteger minute = realminute - twitminute;
    NSInteger second = realsecond - twitsecond;
    
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
    
    [cell.favoriteButton addTarget:self action:@selector(favoriteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cell.retweetButton addTarget:self action:@selector(retweetButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    // Set Values
    [cell.nameLabel setText:nameString];
    cell.nameLabel.userInteractionEnabled = YES;
    cell.profilePicture.userInteractionEnabled = YES;
    cell.tweetLabel.text = tweetString;
    cell.usernameLabel.text = [NSString stringWithFormat:@"@%@",screenName];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *imageUrl = [[data objectForKey:@"user"] objectForKey:@"profile_image_url"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.profilePicture.image = [UIImage imageWithData:data];
            CALayer *imageLayer = cell.profilePicture.layer;
            [imageLayer setCornerRadius:18];
            [imageLayer setMasksToBounds:YES];
        });
    });
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]) {
        NSDictionary *data = tweets[indexPath.row];
        NSString *nameString = data[@"user"][@"name"];
        NSString *bioString = data[@"text"];
        
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                     NSParagraphStyleAttributeName: paragraphStyle};
        
        CGFloat width = CGRectGetWidth(tableView.frame)-kAvatarSize;
        width -= 25.0;
        
        CGRect titleBounds = [nameString boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:NULL];
        CGRect bodyBounds = [bioString boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:NULL];
        
        if (bioString.length == 0) {
            return 0.0;
        }
        
        CGFloat height = CGRectGetHeight(titleBounds);
        height += CGRectGetHeight(bodyBounds);
        height += 70.0;
        
        if (height < kMinimumHeight) {
            height = kMinimumHeight;
        }
        return height;
    }
    else {
        return kMinimumHeight;
    }
}

// Fetches the OG set of Tweets
-(void)fetchTweets {
    self.twitterClient = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/"] key:@"tA5TT8uEtg88FwAHnVpBcbUoq" secret:@"L5whWoi91HmzjrE5bNPNUgoMXWnImvpnkIPHZWQ4VmymaoXyYV"];
    
    NSDictionary *parameters = @{
                                 @"count" :@"40",
                                 @"contributor_details" :@"true",
                                 @"exclude_replies" :@"true"
                                 };
    
    AFOAuth1Token *twitterToken = [AFOAuth1Token retrieveCredentialWithIdentifier:@"TwitterToken"];
    [self.twitterClient setAccessToken:twitterToken];
    [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self.twitterClient getPath:@"statuses/home_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSMutableArray *responseArray = (NSMutableArray *)responseObject;
        [responseArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            tweets = [tweets copy];
            tweets = responseArray;
        }];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)fetchNextTwitterPageWithID:(NSString *)objectID {
    self.twitterClient = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/"] key:@"tA5TT8uEtg88FwAHnVpBcbUoq" secret:@"L5whWoi91HmzjrE5bNPNUgoMXWnImvpnkIPHZWQ4VmymaoXyYV"];
    
    NSDictionary *parameters = @{
                                 @"max_id" :objectID,
                                 @"count" :@"20"
                                 };
    
    AFOAuth1Token *twitterToken = [AFOAuth1Token retrieveCredentialWithIdentifier:@"TwitterToken"];
    [self.twitterClient setAccessToken:twitterToken];
    [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self.twitterClient getPath:@"statuses/home_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSMutableArray *responseArray = [responseObject mutableCopy];
         NSLog(@"Response: %@", responseObject);
         tweets = [tweets mutableCopy];
         [tweets addObjectsFromArray:responseArray];
         [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tweets count] == (indexPath.row+1)) {
        NSDictionary *totalArray = tweets[indexPath.row];
        NSString *cellID = [totalArray objectForKey:@"id"];
        NSLog(@"%@",cellID);
        [self fetchNextTwitterPageWithID:cellID];
    }
}

- (void)lookupTwitterUser:(NSString *)user {
    self.twitterClient = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/"] key:@"tA5TT8uEtg88FwAHnVpBcbUoq" secret:@"L5whWoi91HmzjrE5bNPNUgoMXWnImvpnkIPHZWQ4VmymaoXyYV"];
    
    NSDictionary *parameters = @{
                                 @"screen_name" :user
                                 };
    
    AFOAuth1Token *twitterToken = [AFOAuth1Token retrieveCredentialWithIdentifier:@"TwitterToken"];
    [self.twitterClient setAccessToken:twitterToken];
    [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self.twitterClient getPath:@"users/lookup.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        userLookup = responseObject;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self fetchTweets];
    [refreshControl endRefreshing];
}

-(BOOL)Contains:(NSString *)StrSearchTerm on:(NSString *)StrText
{
    return [StrText rangeOfString:StrSearchTerm
                          options:NSCaseInsensitiveSearch].location != NSNotFound;
}

// Gesture recognizers
- (void) setupNavbarGestureRecognizer {
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navBarTap)];
    gestureRecognizer.numberOfTapsRequired = 1;
    CGRect frame = CGRectMake(self.view.frame.size.width/4, 0, self.view.frame.size.width/2, 44);
    UIView *navBarTapView = [[UIView alloc] initWithFrame:frame];
    [self.navigationController.navigationBar addSubview:navBarTapView];
    navBarTapView.backgroundColor = [UIColor clearColor];
    [navBarTapView setUserInteractionEnabled:YES];
    [navBarTapView addGestureRecognizer:gestureRecognizer];
}

- (void)handleCellNameTap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"Cell Name Tapped");
    ForeignTwitterController *ftc = [[ForeignTwitterController alloc] init];

    [self.navigationController pushViewController:ftc animated:YES];
}

- (void)handleCellProfileImageTap:(UITapGestureRecognizer *)recognizer {
    NSLog(@"Cell ProPic Tapped");
    ForeignTwitterController *ftc = [[ForeignTwitterController alloc] init];
    [self.navigationController pushViewController:ftc animated:YES];
}

-(void)favoriteButtonTapped:(DOFavoriteButton*) sender {
    if (sender.selected) {
        // deselect
        [sender deselect];
    } else {
        // select with animation
        [sender select];
    }
}

-(void)retweetButtonTapped:(DOFavoriteButton*) sender {
    if (sender.selected) {
        // deselect
        [sender deselect];
    } else {
        // select with animation
        [sender select];
    }
}

- (void)navBarTap {
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSInteger row = [[self tableView].indexPathForSelectedRow row];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    //TweetDetailViewController* vc = [sb instantiateViewControllerWithIdentifier:@"TweetDetail"];
    //vc.detailItem = tweet;
   // [self.navigationController pushViewController:vc animated:YES];
}

@end
