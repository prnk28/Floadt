//
//  StreamViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 11/10/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import "StreamViewController.h"


@implementation StreamViewController
@synthesize tweets;
@synthesize instaPics;
@synthesize totalFeed;
@synthesize instagramResponse;

static NSString * const TwitterCellIdentifier = @"TwitterCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchTimeline];
    [self setUpUI];
    
    [self.tableView reloadData];
}

#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        return [self twitterCellAtIndexPath:indexPath];
    
}

- (TwitterCell *)twitterCellAtIndexPath:(NSIndexPath *)indexPath {
    TwitterCell *cell = [self.tableView dequeueReusableCellWithIdentifier:TwitterCellIdentifier forIndexPath:indexPath];
    [self configureTwitterCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureTwitterCell:(TwitterCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    TwitterCell *twitter = [self.tableView dequeueReusableCellWithIdentifier:TwitterCellIdentifier];
    twitter.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    
    NSDictionary *totalArray = totalFeed[indexPath.row];
    
    //Set username for twitter
    NSString *name = [[totalArray objectForKey:@"user"] objectForKey:@"name"];
    [cell.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Regular" size:13.0]];
    [cell.nameLabel setText:name];
    
    //Set status for twitter
    NSString *subtitle = [totalArray objectForKey:@"text"];
    [cell.tweetLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:11.0]];
    if (subtitle.length > 200) {
        subtitle = [NSString stringWithFormat:@"%@...", [subtitle substringToIndex:200]];
    }
    [cell.tweetLabel setText:subtitle];
    
    //Set Profile Pic for Twitter
    UIImageView *profilePic = (UIImageView *)[twitter viewWithTag:201];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *imageUrl = [[totalArray objectForKey:@"user"] objectForKey:@"profile_image_url"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //Make the Profile Pic ImageView Circular
            profilePic.image = [UIImage imageWithData:data];
            CALayer *imageLayer = profilePic.layer;
            [imageLayer setCornerRadius:25];
            [imageLayer setMasksToBounds:YES];
        });
    });
}

- (UITableViewCell *)instagramCellAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Instagram = @"InstagramCell";
    UITableViewCell *instagram = [self.tableView dequeueReusableCellWithIdentifier:Instagram];
    [self configureTwitterCell:instagram atIndexPath:indexPath];
    return instagram;
}

- (void)configureInstagramCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *Instagram = @"InstagramCell";
    UITableViewCell *instagram = [self.tableView dequeueReusableCellWithIdentifier:Instagram];
    instagram.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    
    NSDictionary *entry = instaPics[indexPath.row];
    
    // Set Image
    NSString *imageUrlString = entry[@"images"][@"low_resolution"][@"url"];
    NSURL *url = [NSURL URLWithString:imageUrlString];
    UIImageView *instagramImageView = (UIImageView *)[instagram viewWithTag:104];
    [instagramImageView setImageWithURL:url];
    
    
    // Set User Name
    NSString *user =  entry[@"user"][@"full_name"];
    UILabel *instagramUserLabel = (UILabel *)[instagram viewWithTag:102];
    [instagramUserLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:16.0]];
    [instagramUserLabel setText:user];
    
    // If no Caption
    if (entry[@"caption"] != [NSNull null] && entry[@"caption"][@"text"] != [NSNull null])            {
        NSString *caption = entry[@"caption"][@"text"];
        UILabel *instagramCaptionLabel = (UILabel *)[instagram viewWithTag:103];
        [instagramCaptionLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:12.0]];
        [instagramCaptionLabel setText:caption];
    }else{
        NSString *caption = @"";
        UILabel *instagramCaptionLabel = (UILabel *)[instagram viewWithTag:103];
        [instagramCaptionLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:12.0]];
        [instagramCaptionLabel setText:caption];
    }
    
    // Add Profile Image
    UIImageView *profilePic = (UIImageView *)[instagram viewWithTag:101];
    
    NSURL *imageUrl = entry[@"user"][@"profile_picture"];
    [profilePic setImageWithURL:imageUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        profilePic.image = image;
        //Make the Profile Pic ImageView Circular
        CALayer *imageLayer = profilePic.layer;
        [imageLayer setCornerRadius:25];
        [imageLayer setMasksToBounds:YES];
    }];
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForBasicCellAtIndexPath:indexPath];
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static TwitterCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:TwitterCellIdentifier];
    });
    
    [self configureTwitterCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}
*/

- (void)updateArrays {
    instaPics = instagramResponse[@"data"];
    totalFeed = [tweets arrayByAddingObjectsFromArray:instaPics];
    //[self sortArrayBasedOndate];
    
}

- (NSMutableArray *)entries {
    return instaPics;
}


#pragma mark - Network Pulling
- (void)fetchInstagramPics {
    instaPics = [[NSMutableArray alloc] init];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL *status = [user boolForKey:@"isInstagramLoggedIn"];
    if (status) {
        [[InstagramClient sharedClient] getPath:@"users/self/feed"
                                     parameters:nil
                                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                            //NSLog(@"Response: %@", responseObject);
                                            instagramResponse = [responseObject mutableCopy];
                                            [self.instaPics addObjectsFromArray:responseObject[@"data"]];
                                            [self updateArrays];
                                            [self.tableView reloadData];
                                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                            NSLog(@"Failure: %@", error);
                                        }];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData]; });
}

-(void)fetchTweetsWith:(BOOL*)auth {
    if (auth) {
        self.twitterClient = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/"] key:@"4oFCF0AjP4PQDUaCh5RQ" secret:@"NxAihESVsdUXSUxtHrml2VBHA0xKofYKmmGS01KaSs"];
        
        [self.twitterClient authorizeUsingOAuthWithRequestTokenPath:@"/oauth/request_token" userAuthorizationPath:@"/oauth/authorize" callbackURL:[NSURL URLWithString:@"floadt://success"] accessTokenPath:@"/oauth/access_token" accessMethod:@"POST" scope:nil success:^(AFOAuth1Token *accessToken, id responseObject) {
            [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
            [self.twitterClient getPath:@"statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSArray *responseArray = (NSArray *)responseObject;
                NSLog(@"Response: %@", responseObject);
                [responseArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    tweets = responseArray;
                }];
                [self.tableView reloadData];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
            
        } failure:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }else{
        [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self.twitterClient getPath:@"statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *responseArray = (NSArray *)responseObject;
            [responseArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                tweets = [tweets copy];
                tweets = responseArray;
            }];
             [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

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

- (void)fetchNextTwitterPage {
    //NSLog(tweets);
    for (NSString *line in totalFeed) {
    // Results from NSLog are in the Console
    NSLog([NSString stringWithFormat:@"line: %@", line]);
}  

    //NSIndexPath *indexpath;
    //NSDictionary *entry = tweets[indexpath.row];
    //NSNumber *stufa;
    
    //id stuff =entry[@"id"];
    //NSLog(stuff);
    
    //NSDictionary *parameters = @{
    //                            @"max_id" :stufa
    //                            };
    
    //[self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    //[self.twitterClient getPath:@"statuses/home_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
      //  NSArray *responseArray = (NSArray *)responseObject;
      //  [responseArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      //      tweets = [tweets copy];
      //      tweets = responseArray;
      //  }];
    //} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //    NSLog(@"Error: %@", error);
   // }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y == roundf(scrollView.contentSize.height-scrollView.frame.size.height)) {
        //[self fetchNextInstagramPage];
        [self fetchNextTwitterPage];
    }
}

- (void)fetchTimeline {
    [self fetchInstagramPics];
    [self fetchTweetsWith:true];
    [self updateArrays];
    [self.tableView reloadData];
}

- (void)refetchTimeline {
  //[self fetchInstagramPics];
    [self fetchTweetsWith:false];
    [self updateArrays];
    [self.tableView reloadData];
    
}

- (void)sortArrayBasedOndate {
    instaPics; // your instagrams
    tweets;    // your tweets
    totalFeed = [NSMutableArray array]; // the common array
    
    // Date formatter for the tweets. The date format must exactly
    // match the format used in the tweets.
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"yyyy-MM-dd"];
    
    // Add all instagrams:
    for (NSMutableDictionary *instagram in instaPics) {
        NSString *createdAt = instagram[@"created_time"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[createdAt doubleValue]];
        instagram[@"creationDate"] = date;
        [totalFeed addObject:instagram];
    }
    // Add all tweets:
    for (NSMutableDictionary *twitter in tweets) {
        NSString *twitterCreated = twitter[@"created_at"];
        NSDate *date = [fmtDate dateFromString:twitterCreated];
        twitter[@"creationDate"] = date;
        [totalFeed addObject:twitter];
    }
    
    // Sort
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:YES];
    [totalFeed sortUsingDescriptors:@[sortDesc]];
    
}


#pragma mark - Refresh
- (void)refresh:(UIRefreshControl *)refreshControl {
    [self refetchTimeline];
    [refreshControl endRefreshing];
}


#pragma mark - Composer View Controller
- (void)composeViewController:(REComposeViewController *)composeViewController didFinishWithResult:(REComposeResult)result
{
    [composeViewController dismissViewControllerAnimated:YES completion:nil];
    
    if (result == REComposeResultCancelled) {
        NSLog(@"Cancelled");
    }
    
    if (result == REComposeResultPosted) {
        
    }
}


#pragma mark - Miscallaneous

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showTweet"]) {
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        NSDictionary *tweet = [tweets objectAtIndex:row];
        TweetDetailViewController *detailController = segue.destinationViewController;
        detailController.detailItem = tweet;
    }
    else if ([segue.identifier isEqualToString:@"showInstaPic"]) {
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        NSDictionary *pics = [instaPics objectAtIndex:row];
        InstaPicDetailViewController *detailController = segue.destinationViewController;
        detailController.detailItem = pics;
    }
    
}

- (void)didTapPostButton:(id)sender
{
    REComposeViewController *composeViewController = [[REComposeViewController alloc] init];
    composeViewController.title = @"Social Network";
    composeViewController.hasAttachment = YES;
    composeViewController.delegate = self;
    composeViewController.text = @"Test";
    //[composeViewController.inputAccessoryView isEqual:accessoryView];
    [composeViewController presentFromRootViewController];
    
}

- (void)didTapBarButton:(id)sender
{
    [self.sidePanelController showLeftPanelAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpUI{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
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
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:179.0/255.0 green:177.0/255.0 blue:177.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"AeroviasBrasilNF" size:30.0], NSFontAttributeName, nil]];
}

@end