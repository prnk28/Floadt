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
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];

       [self.tableView registerClass:[TwitterCell class] forCellReuseIdentifier:@"TwitterCell"];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *totalArray = tweets[indexPath.row];
    NSString *text = [totalArray objectForKey:@"text"];
    
    if ([self Contains:@"RT" on:text]) {
        return 204;
    }
    return 184;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TwitterCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TwitterCell"];
    cell.tweetLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.tweetLabel.numberOfLines = 0;
    
    if (cell == nil) {
        cell = [[TwitterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TwitterCell"];
    }
    NSDictionary *totalArray = tweets[indexPath.row];
    
    //
    // RETWEET CELL
    //
    /*
    if ([self Contains:@"RT" on:[totalArray objectForKey:@"text"]]) {
        TwitterCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TwitterCell"];
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
        if (cell == nil) {
            cell = [[TwitterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TwitterCell"];
        }

        // Lookup RT User
        NSString *text = [totalArray objectForKey:@"text"];
        
        NSRange start = [text rangeOfString:@"RT @"];
        NSRange end = [text rangeOfString:@":"];
        NSString *shortString = [text substringWithRange:NSMakeRange(start.location, end.location)];
        NSString *evenShorterString = [shortString substringFromIndex:4];
        NSLog(@"%@", evenShorterString);
        [self lookupTwitterUser:evenShorterString];
        
        //Set username for twitter
        NSString *name = userLookup[@"name"];
        [cell.nameLabel setText:name];
    
        //Set status for twitter
        NSString *status = userLookup[@"status"][@"text"];
        [cell.tweetLabel setText:status];
    
        //Set Profile Pic for Twitter
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *imageUrl = userLookup[@"profile_background_image_url"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.profilePic.image = [UIImage imageWithData:data];
                CALayer *imageLayer = cell.profilePic.layer;
                [imageLayer setCornerRadius:25];
                [imageLayer setMasksToBounds:YES];
            });
        });
        return cell;
    }
    */
    //
    // REGULAR CELL
    //
    
    //Set username for twitter
    NSString *name = [[totalArray objectForKey:@"user"] objectForKey:@"name"];
    [cell.nameLabel setText:name];
    
    //Set status for twitter
    NSString *text = [totalArray objectForKey:@"text"];
    [cell.textLabel setText:text];
    
    //Set Profile Pic for Twitter
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *imageUrl = [[totalArray objectForKey:@"user"] objectForKey:@"profile_image_url"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.profilePic.image = [UIImage imageWithData:data];
            CALayer *imageLayer = cell.profilePic.layer;
            [imageLayer setCornerRadius:25];
            [imageLayer setMasksToBounds:YES];
        });
    });
    return cell;
}

// Fetches the OG set of Tweets
-(void)fetchTweets {
    self.twitterClient = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/"] key:@"tA5TT8uEtg88FwAHnVpBcbUoq" secret:@"L5whWoi91HmzjrE5bNPNUgoMXWnImvpnkIPHZWQ4VmymaoXyYV"];
    
    NSDictionary *parameters = @{
                                 @"count" :@"50",
                                 @"contributor_details" :@"true"
                                 };
    
    AFOAuth1Token *twitterToken = [AFOAuth1Token retrieveCredentialWithIdentifier:@"TwitterToken"];
    [self.twitterClient setAccessToken:twitterToken];
    [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self.twitterClient getPath:@"statuses/home_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *responseArray = (NSMutableArray *)responseObject;
        NSLog(@"Response: %@", responseObject);
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
                                 @"max_id" :objectID
                                 };
    
    AFOAuth1Token *twitterToken = [AFOAuth1Token retrieveCredentialWithIdentifier:@"TwitterToken"];
    [self.twitterClient setAccessToken:twitterToken];
    [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self.twitterClient getPath:@"statuses/home_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSMutableArray *responseArray = (NSMutableArray *)responseObject;
        NSLog(@"Response: %@", responseObject);
        // tweets = [tweets copy];
        // [tweets addObjectsFromArray:responseArray];
        // [self.tableView reloadData];
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
        //NSLog(@"Response: %@", responseObject);
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

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [[self tableView].indexPathForSelectedRow row];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    NSDictionary *tweet = [self.tweets objectAtIndex:row];
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    TweetDetailViewController* vc = [sb instantiateViewControllerWithIdentifier:@"TweetDetail"];
    vc.detailItem = tweet;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
