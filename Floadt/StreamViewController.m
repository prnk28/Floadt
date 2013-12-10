//
//  StreamViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 11/10/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import "StreamViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation StreamViewController
@synthesize tweets;
@synthesize instaPics;

static NSString *InstagramIdentifier = @"InstagramCell";
- (void)viewDidLoad
{
    self.instaPics = [NSMutableArray new];
    self.tweets = [NSMutableArray new];
    tweets = nil;
    instaPics = nil;
    [super viewDidLoad];
    [self fetchTimeline];
    
    [NSTimer scheduledTimerWithTimeInterval:15.0
                                     target:self
                                   selector:@selector(timerRefresh:)
                                   userInfo:nil
                                    repeats:NO];
    
    //Setup UI
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
    
    
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *totalFeedDictionary = totalFeed[indexPath.row];
    NSLog(@"");
        if (indexPath.row % 2 == 0)  {
            static NSString *CellIdentifier = @"TweetCell";
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
           
            NSDictionary *tweet = tweets[indexPath.row / 2];

            //Set username for twitter
            NSString *name = [[tweet objectForKey:@"user"] objectForKey:@"name"];
            UILabel *twitterNameLabel = (UILabel *)[cell viewWithTag:202];
            [twitterNameLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:12.0]];
            [twitterNameLabel setText:name];
            
            
            //Set status for twitter
            NSString *text = [tweet objectForKey:@"text"];
            UILabel *twitterTweetLabel = (UILabel *)[cell viewWithTag:203];
            [twitterTweetLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:10.0]];
            [twitterTweetLabel setText:text];
            
            
            //Set Profile Pic for twitter
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSString *imageUrl = [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImageView *profilePic = (UIImageView *)[cell viewWithTag:201];
                    profilePic.image = [UIImage imageWithData:data];
                    
                    //Make the Profile Pic ImageView Circular
                    CALayer *imageLayer = profilePic.layer;
                    [imageLayer setCornerRadius:25];
                    [imageLayer setMasksToBounds:YES];
                });
            });
            
            
            //Set number of Favorites for Tweet
            NSString *favoritesCount = [[tweet objectForKey:@"user"]objectForKey:@"favourites_count"];
            UIButton *favoritesButton = (UIButton *)[cell viewWithTag:204];
            [favoritesButton setTitle:[NSString stringWithFormat:@"  %@",favoritesCount] forState:UIControlStateNormal];
            [favoritesButton setTitle:[NSString stringWithFormat:@"  %@",favoritesCount] forState:UIControlStateHighlighted];
            favoritesButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12];
    
            return cell;

        }else {
            
            
            static NSString *CellIdentifier = @"InstagramCell";
            UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
            
            NSDictionary *entry = instaPics[indexPath.row / 2];
       
            NSString *imageUrlString = entry[@"images"][@"low_resolution"][@"url"];
            NSURL *url = [NSURL URLWithString:imageUrlString];
            UIImageView *instagramImageView = (UIImageView *)[cell viewWithTag:104];
            [instagramImageView setImageWithURL:url];
            
            NSString *user =  entry[@"user"][@"full_name"];
            UILabel *instagramUserLabel = (UILabel *)[cell viewWithTag:102];
            [instagramUserLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:16.0]];
            [instagramUserLabel setText:user];
            
            if (entry[@"caption"] != [NSNull null] && entry[@"caption"][@"text"] != [NSNull null])            {
            NSString *caption = entry[@"caption"][@"text"];
            UILabel *instagramCaptionLabel = (UILabel *)[cell viewWithTag:103];
            [instagramCaptionLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:12.0]];
            [instagramCaptionLabel setText:caption];
            }else{
                NSString *caption = @"";
                UILabel *instagramCaptionLabel = (UILabel *)[cell viewWithTag:103];
                [instagramCaptionLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:12.0]];
                [instagramCaptionLabel setText:caption];
            }
            
            NSString *imageUserPicUrl = entry[@"user"][@"profile_pic"][@"url"];

            NSURL *profileURL = [NSURL URLWithString:imageUserPicUrl];
            UIImageView *instagramProfilePic = (UIImageView *)[cell viewWithTag:101];
            instagramProfilePic.frame = CGRectMake(35, 31, 50, 50);
            [instagramProfilePic setImageWithURL:profileURL];
            
            return cell;
        }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        return 184;
    } else {
        return 300;
    }
}

- (void)fetchInstagramPics {
    instaPics = [[NSMutableArray alloc] init];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL *status = [user boolForKey:@"isInstagramLoggedIn"];
    if (status) {
        [[InstagramClient sharedClient] getPath:@"users/self/feed"
                                     parameters:nil
                                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                            // NSLog(@"Response: %@", responseObject);
                                            self.timelineResponse = [responseObject mutableCopy];
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



- (void)updateArrays {
    instaPics = self.timelineResponse[@"data"];
    totalFeed = [tweets arrayByAddingObjectsFromArray:instaPics];
    [self orderArraysByDate:totalFeed];
    
}

- (void)orderArraysByDate:(NSArray *)array {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"created_at" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    array = [array sortedArrayUsingDescriptors:sortDescriptors];
    
}

- (void)nextInstagramPage:(NSIndexPath *)indexPath{
    NSDictionary *page = self.timelineResponse[@"pagination"];
    NSString *nextPage = page[@"next_url"];
    
    [[InstagramClient sharedClient] getPath:[NSString stringWithFormat:@"%@",nextPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.timelineResponse = [responseObject mutableCopy];
        [self.timelineResponse addEntriesFromDictionary:responseObject];
        [self.instaPics addObjectsFromArray:responseObject[@"data"]];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
    }];
    
}
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y == roundf(scrollView.contentSize.height-scrollView.frame.size.height)) {
        NSLog(@"we are at the endddd");
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        
        if (indexPath.row % 2 == 0) {
            [self nextInstagramPage:indexPath];
        }else{
            NSLog(@"tweet");
        
        }
        
    }
 }
 */





- (void)fetchTimeline {
    [self fetchInstagramPics];
    [self fetchTweetsAuth];
    [self updateArrays];
    [self.tableView reloadData];
}

- (void)refetchTimeline {
    //[self fetchInstagramPics];
    [self fetchTweets];
    [self updateArrays];
    [self.tableView reloadData];
    
}

- (void)fetchTweetsAuth {
    self.twitterClient = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/"] key:@"4oFCF0AjP4PQDUaCh5RQ" secret:@"NxAihESVsdUXSUxtHrml2VBHA0xKofYKmmGS01KaSs"];
    
    [self.twitterClient authorizeUsingOAuthWithRequestTokenPath:@"/oauth/request_token" userAuthorizationPath:@"/oauth/authorize" callbackURL:[NSURL URLWithString:@"floadt://success"] accessTokenPath:@"/oauth/access_token" accessMethod:@"POST" scope:nil success:^(AFOAuth1Token *accessToken, id responseObject) {
        [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self.twitterClient getPath:@"statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *responseArray = (NSArray *)responseObject;
            [responseArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSLog(@"Success: %@", obj);
                tweets = responseArray;
            }];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)timerRefresh:(id)sender{
    [self refetchTimeline];
}

- (void)fetchTweets{
        [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self.twitterClient getPath:@"statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *responseArray = (NSArray *)responseObject;
            [responseArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSLog(@"Success: %@", obj);
                tweets = [tweets copy];
                tweets = responseArray;
            }];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self refetchTimeline];
    [refreshControl endRefreshing];
}

- (void)composeViewController:(REComposeViewController *)composeViewController didFinishWithResult:(REComposeResult)result
{
    [composeViewController dismissViewControllerAnimated:YES completion:nil];
    
    if (result == REComposeResultCancelled) {
        NSLog(@"Cancelled");
    }
    
    if (result == REComposeResultPosted) {

    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showTweet"]) {
        
        NSInteger row = [[self tableView].indexPathForSelectedRow row]/2;
        NSDictionary *tweet = [tweets objectAtIndex:row];
        
        TweetDetailViewController *detailController = segue.destinationViewController;
        detailController.detailItem = tweet;
    }
    else if ([segue.identifier isEqualToString:@"showInstaPic"]) {
        
        NSInteger row = [[self tableView].indexPathForSelectedRow row]/2;
        NSDictionary *pics = [instaPics objectAtIndex:row];
        
        InstaPicDetailViewController *detailController = segue.destinationViewController;
        detailController.detailItem = pics;
    }

}

@end