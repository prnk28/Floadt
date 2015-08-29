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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavbarGestureRecognizer];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.tableView registerClass:[TwitterCell class] forCellReuseIdentifier:@"TwitterCell"];
    [self.tableView registerClass:[TwitterRetweetCell class] forCellReuseIdentifier:@"TwitterRetweetCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"twitterActive"]) {
        [self fetchTweets];
        [self.tableView reloadData];
    }
    
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
    NSDictionary *data = tweets[indexPath.row];
    
    //
    // RETWEET CELL
    //
    
    if (data[@"retweeted_status"] != nil) {
        TwitterRetweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TwitterRetweetCell"];
        if (cell == nil) {
            cell = [[TwitterRetweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TwitterRetweetCell"];
        }
        //Set Text
        [cell.tweetLabel setText:data[@"retweeted_status"][@"text"]];
        
        //Set name for twitter
        [cell.nameLabel setText:data[@"retweeted_status"][@"user"][@"name"]];
        
        //Set username for twitter
        [cell.usernameLabel setText:data[@"retweeted_status"][@"user"][@"screen_name"]];
        
        //Set Retweet Status
        NSString *retName = [NSString stringWithFormat:@"Retweeted by %@",data[@"user"][@"name"]];
        [cell.retweetedLabel setText:retName];
        
        //Set Profile Pic for Twitter
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *imageUrl = data[@"retweeted_status"][@"user"][@"profile_image_url"];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.profilePicture.image = [UIImage imageWithData:data];
                CALayer *imageLayer = cell.profilePicture.layer;
                [imageLayer setCornerRadius:18];
                [imageLayer setMasksToBounds:YES];
            });
        });
        
        [cell.favoriteButton setObjectID:data[@"retweeted_status"][@"id"]];
        [cell.retweetButton setObjectID:data[@"retweeted_status"][@"id"]];
        
        id favorited = data[@"favorited"];
        id retweeted = data[@"retweeted"];
        
        if ([favorited integerValue] == 1) {
            cell.favoriteButton.selected = YES;
            
        } else {
            cell.favoriteButton.selected = NO;
            
        }
        
        if ([retweeted integerValue] == 1) {
            cell.retweetButton.selected = YES;
            [cell.retweetsLabel select];
        } else {
            cell.retweetButton.selected = NO;
            [cell.retweetsLabel deselect];
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
        
        // NSDate
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormatter setLocale:usLocale];
        [dateFormatter setDateStyle:NSDateFormatterLongStyle];
        [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [dateFormatter setDateFormat: @"EEE MMM dd HH:mm:ss Z yyyy"];
        
        NSDate *date = [dateFormatter dateFromString:data[@"retweeted_status"][@"created_at"]];
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
        
        id retweet = data[@"retweeted_status"][@"retweet_count"];
        id favorite = data[@"retweeted_status"][@"favorite_count"];
        long retweetCount = [retweet longValue];
        long favoriteCount = [favorite longValue];
        if (retweetCount > 0) {
            cell.retweetsLabel.text = [NSString stringWithFormat:@"%ld",retweetCount];
        }
        
        if (favoriteCount > 0) {
            cell.favoritesLabel.text = [NSString stringWithFormat:@"%ld",favoriteCount];
        }
        [cell.retweetsLabel setRetweetCount:retweetCount];
        [cell.favoritesLabel setFavoriteCount:favoriteCount];

        
        return cell;
    }
    
    //
    //  REGULAR CELL
    //
    
    TwitterCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TwitterCell"];
    
    if (cell == nil) {
        cell = [[TwitterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TwitterCell"];
    }
    
    [cell.favoriteButton setObjectID:data[@"id"]];
    [cell.retweetButton setObjectID:data[@"id"]];
    
    id favorited = data[@"favorited"];
    id retweeted = data[@"retweeted"];
    
    if ([favorited integerValue] == 1) {
        cell.favoriteButton.selected = YES;
        
    } else {
        cell.favoriteButton.selected = NO;
        
    }
    
    if ([retweeted integerValue] == 1) {
        cell.retweetButton.selected = YES;
        [cell.retweetsLabel select];
    } else {
        cell.retweetButton.selected = NO;
        [cell.retweetsLabel deselect];
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
    
    // NSDate
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
    NSString *nameString = data[@"user"][@"name"];
    NSString *screenName = data[@"user"][@"screen_name"];
    NSString *tweetString = data[@"text"];
    id retweet = data[@"retweet_count"];
    id favorite = data[@"favorite_count"];
    long retweetCount = [retweet longValue];
    long favoriteCount = [favorite longValue];
    
    [cell.nameLabel setText:nameString];
    cell.nameLabel.userInteractionEnabled = YES;
    cell.profilePicture.userInteractionEnabled = YES;
    cell.tweetLabel.text = tweetString;
    cell.usernameLabel.text = [NSString stringWithFormat:@"@%@",screenName];
    
    if (retweetCount > 0) {
        cell.retweetsLabel.text = [NSString stringWithFormat:@"%ld",retweetCount];
    }
    
    if (favoriteCount > 0) {
        cell.favoritesLabel.text = [NSString stringWithFormat:@"%ld",favoriteCount];
    }
    [cell.retweetsLabel setRetweetCount:retweetCount];
    [cell.favoritesLabel setFavoriteCount:favoriteCount];
    
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
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([tweets count] == (indexPath.row+1)) {
        NSDictionary *totalArray = tweets[indexPath.row];
        NSString *cellID = [totalArray objectForKey:@"id"];
        NSLog(@"%@",cellID);
        [self fetchNextTwitterPageWithID:cellID];
    }
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
        
        NSIndexPath *i=[self indexPathForCellContainingView:sender.superview];
        TwitterCell *cell = [self.tableView cellForRowAtIndexPath:i];
        [cell.favoritesLabel deselect];
        cell.favoritesLabel.favoriteCount --;
        [cell.favoritesLabel setText:[NSString stringWithFormat:@"%d", cell.favoritesLabel.favoriteCount]];
        
        self.twitterClient = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/"] key:@"tA5TT8uEtg88FwAHnVpBcbUoq" secret:@"L5whWoi91HmzjrE5bNPNUgoMXWnImvpnkIPHZWQ4VmymaoXyYV"];
        
        NSDictionary *parameters = @{
                                     @"id" :sender.objectID
                                     };
        
        AFOAuth1Token *twitterToken = [AFOAuth1Token retrieveCredentialWithIdentifier:@"TwitterToken"];
        [self.twitterClient setAccessToken:twitterToken];
        [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self.twitterClient postPath:@"favorites/destroy.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];

    } else {
        [sender select];
        
        NSIndexPath *i=[self indexPathForCellContainingView:sender.superview];
        TwitterCell *cell = [self.tableView cellForRowAtIndexPath:i];
        [cell.favoritesLabel select];
        cell.favoritesLabel.favoriteCount ++;
        [cell.favoritesLabel setText:[NSString stringWithFormat:@"%d", cell.favoritesLabel.favoriteCount]];
        
        self.twitterClient = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/"] key:@"tA5TT8uEtg88FwAHnVpBcbUoq" secret:@"L5whWoi91HmzjrE5bNPNUgoMXWnImvpnkIPHZWQ4VmymaoXyYV"];
        
        NSDictionary *parameters = @{
                                     @"id" :sender.objectID
                                     };
        
        AFOAuth1Token *twitterToken = [AFOAuth1Token retrieveCredentialWithIdentifier:@"TwitterToken"];
        [self.twitterClient setAccessToken:twitterToken];
        [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self.twitterClient postPath:@"favorites/create.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

-(void)retweetButtonTapped:(DOFavoriteButton*) sender {
    if (sender.selected) {
        // deselect
        [sender deselect];
        // Highlight Label
        NSIndexPath *i=[self indexPathForCellContainingView:sender.superview];
        TwitterCell *cell = [self.tableView cellForRowAtIndexPath:i];
        [cell.retweetsLabel deselect];
        cell.retweetsLabel.retweetCount --;
        [cell.retweetsLabel setText:[NSString stringWithFormat:@"%d", cell.retweetsLabel.retweetCount]];
        
        self.twitterClient = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/"] key:@"tA5TT8uEtg88FwAHnVpBcbUoq" secret:@"L5whWoi91HmzjrE5bNPNUgoMXWnImvpnkIPHZWQ4VmymaoXyYV"];
        
        NSString *path = [NSString stringWithFormat:@"statuses/destroy/%@.json",sender.objectID];
        AFOAuth1Token *twitterToken = [AFOAuth1Token retrieveCredentialWithIdentifier:@"TwitterToken"];
        [self.twitterClient setAccessToken:twitterToken];
        [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self.twitterClient postPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    } else {
        [sender select];
        
        NSIndexPath *i=[self indexPathForCellContainingView:sender.superview];
        TwitterCell *cell = [self.tableView cellForRowAtIndexPath:i];
        [cell.retweetsLabel select];
        cell.retweetsLabel.retweetCount ++;
        [cell.retweetsLabel setText:[NSString stringWithFormat:@"%d", cell.retweetsLabel.retweetCount]];
        
        // Request
        self.twitterClient = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/"] key:@"tA5TT8uEtg88FwAHnVpBcbUoq" secret:@"L5whWoi91HmzjrE5bNPNUgoMXWnImvpnkIPHZWQ4VmymaoXyYV"];
        
        NSString *path = [NSString stringWithFormat:@"statuses/retweet/%@.json",sender.objectID];
        AFOAuth1Token *twitterToken = [AFOAuth1Token retrieveCredentialWithIdentifier:@"TwitterToken"];
        [self.twitterClient setAccessToken:twitterToken];
        [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self.twitterClient postPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
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

- (NSIndexPath *)indexPathForCellContainingView:(UIView *)view {
    while (view != nil) {
        if ([view isKindOfClass:[TwitterCell class]]) {
            return [self.tableView indexPathForCell:(TwitterCell *)view];
        } else {
            view = [view superview];
        }
    }
    return nil;
}

@end
