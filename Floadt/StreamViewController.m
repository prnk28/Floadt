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


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Override point for customization after application launch.
    
    // If the User has launched the app for the First Time run the Intro
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self setUpUI];
        [self buildIntro];
    }else{
     
        // Fetch Timeline
        [self setUpUI];
        [self fetchTimeline];
        // Setup the User Interface
        [self.tableView reloadData];
    }
}

#pragma mark - Table View

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //id object = [totalFeed objectAtIndex:indexPath.row];
    if (indexPath.row%2==0) {
        static NSString *Twitter = @"TwitterCell";
        UITableViewCell *twitter = [self.tableView dequeueReusableCellWithIdentifier:Twitter];
        twitter.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
        
        NSDictionary *totalArray = totalFeed[indexPath.row];;
        
        //Set username for twitter
        NSString *name = [[totalArray objectForKey:@"user"] objectForKey:@"name"];
        UILabel *twitterNameLabel = (UILabel *)[twitter viewWithTag:202];
        [twitterNameLabel setFont:[UIFont fontWithName:@"Helvetica-Regular" size:12.0]];
        [twitterNameLabel setText:name];
        
        //Set status for twitter
        NSString *text = [totalArray objectForKey:@"text"];
        UILabel *twitterTweetLabel = (UILabel *)[twitter viewWithTag:203];
        [twitterTweetLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:10.0]];
        [twitterTweetLabel setText:text];
        
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
        
        //Set number of Favorites for Tweet
        NSString *favoritesCount = [[totalArray objectForKey:@"user"]objectForKey:@"favourites_count"];
        UIButton *favoritesButton = (UIButton *)[twitter viewWithTag:204];
        [favoritesButton setTitle:[NSString stringWithFormat:@"  %@",favoritesCount] forState:UIControlStateNormal];
        [favoritesButton setTitle:[NSString stringWithFormat:@"  %@",favoritesCount] forState:UIControlStateHighlighted];
        favoritesButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12];
        
        return twitter;
        
    }else{
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
        [instagramUserLabel setFont:[UIFont fontWithName:@"Helvetica-Regular" size:16.0]];
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
        
        // Add likes Count
        NSString *likesCount = entry[@"likes"][@"count"];
        UIButton *likesButton = (UIButton *)[instagram viewWithTag:105];
        [likesButton setTitle:[NSString stringWithFormat:@"  %@",likesCount] forState:UIControlStateNormal];
        [likesButton setTitle:[NSString stringWithFormat:@"  %@",likesCount] forState:UIControlStateHighlighted];
        likesButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12];
        
        return instagram;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [totalFeed objectAtIndex:indexPath.row];
    if (indexPath.row%2==0) {
        return 184;
    } else {
        return 319;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (void)updateArrays {
    instaPics = instagramResponse[@"data"];
    totalFeed = [tweets arrayByAddingObjectsFromArray:instaPics];
    [self sortArrayBasedOndate];
}

// Returns instaPics as a Mutable Array in order to Add more InstaPics
- (NSMutableArray *)entries {
    return instaPics;
}


#pragma mark - Network Pulling

// Fetches OG Instagram Pics
- (void)fetchInstagramPics {
    instaPics = [[NSMutableArray alloc] init];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL *status = [user boolForKey:@"instagramActive"];
    if (status) {
        [[InstagramClient sharedClient] getPath:@"users/self/feed"
                                     parameters:nil
                                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                            NSLog(@"Response: %@", responseObject);
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

// Fetches the OG set of Tweets
-(void)fetchTweets {
    self.twitterClient = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/1.1/"] key:@"tA5TT8uEtg88FwAHnVpBcbUoq" secret:@"L5whWoi91HmzjrE5bNPNUgoMXWnImvpnkIPHZWQ4VmymaoXyYV"];
    
    AFOAuth1Token *twitterToken = [AFOAuth1Token retrieveCredentialWithIdentifier:@"TwitterToken"];
    [self.twitterClient setAccessToken:twitterToken];
    [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self.twitterClient getPath:@"statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *responseArray = (NSArray *)responseObject;
       // NSLog(@"Response: %@", responseObject);
        [responseArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            tweets = [tweets copy];
            tweets = responseArray;
        }];
        [self updateArrays];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

// Fetches the OG set of FB Statuses
-(void)fetchFacebook {
    [SCFacebook myFeedCallBack:^(BOOL success, id result) {
        // NSLog(success);
        NSLog(result);
    }];
}

// Fetches the Next Instagram Page
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y == roundf(scrollView.contentSize.height-scrollView.frame.size.height)) {
        //[self fetchNextInstagramPage];
        //[self fetchNextTwitterPage];
    }
}

- (void)fetchTimeline {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"instagramActive"]) {
        [self fetchInstagramPics];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"twitterActive"]) {
        [self fetchTweets];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"facebookActive"]) {
        [self fetchFacebook];
    }
    [self updateArrays];
    [self.tableView reloadData];
}

- (void)refetchTimeline {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"instagramActive"]) {
        [self fetchInstagramPics];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"twitterActive"]) {
        [self fetchTweets];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"facebookActive"]) {
        [self fetchFacebook];
    }
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
    [self fetchTimeline];
    [refreshControl endRefreshing];
}


#pragma mark - Miscallaneous

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showTweet"]) {
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        NSDictionary *tweet = [tweets objectAtIndex:row];
        TweetDetailViewController *detailController = segue.destinationViewController;
        detailController.detailItem = tweet;
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    }
    else if ([segue.identifier isEqualToString:@"showInstaPic"]) {
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        NSDictionary *pics = [instaPics objectAtIndex:row];
        InstaPicDetailViewController *detailController = segue.destinationViewController;
        detailController.detailItem = pics;
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    }
    
}

- (void)didTapPostButton:(id)sender
{
    RRSendMessageViewController *controller = [[RRSendMessageViewController alloc] init];
    
    [controller presentController:self blockCompletion:^(RRMessageModel *model, BOOL isCancel) {
        if (isCancel == true) {
            self.message.text = @"";
        }
        else {
            self.message.text = model.text;
        }
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
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

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(247/255.0) green:(247/255.0) blue:(247/255.0) alpha:1]];
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
    
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:179.0/255.0 green:177.0/255.0 blue:177.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"AeroviasBrasilNF" size:30.0], NSFontAttributeName, nil]];
}

-(void)buildIntro{
    //Create Stock Panel with header
    MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Welcome to MYBlurIntroductionView" description:@"MYBlurIntroductionView is a powerful platform for building app introductions and tutorials. Built on the MYIntroductionView core, this revamped version has been reengineered for beauty and greater developer control." image:[UIImage imageNamed:@"HeaderImage.png"]];
    
    //Create Stock Panel With Image
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Automated Stock Panels" description:@"Need a quick-and-dirty solution for your app introduction? MYBlurIntroductionView comes with customizable stock panels that make writing an introduction a walk in the park. Stock panels come with optional blurring (iOS 7) and background image. A full panel is just one method away!" image:[UIImage imageNamed:@"ForkImage.png"]];
    
   // AddSocialPanel *panel3 = [[AddSocialPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) nibNamed:@"AddSocialPanel"];
    //Add panels to an array
    NSArray *panels = @[panel1, panel2];
    
    //Create the introduction view and set its delegate
    MYBlurIntroductionView *introductionView = [[MYBlurIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    introductionView.delegate = self;
    introductionView.BackgroundImageView.image = [UIImage imageNamed:@"Toronto, ON.jpg"];
    [introductionView setBackgroundColor:[UIColor colorWithRed:90.0f/255.0f green:175.0f/255.0f blue:113.0f/255.0f alpha:0.85]];
    //introductionView.LanguageDirection = MYLanguageDirectionRightToLeft;
    
    //Build the introduction with desired panels
    [introductionView buildIntroductionWithPanels:panels];
    
    //Add the introduction to your view
    [self.view addSubview:introductionView];
}

#pragma mark - MYIntroduction Delegate

-(void)introduction:(MYBlurIntroductionView *)introductionView didChangeToPanel:(MYIntroductionPanel *)panel withIndex:(NSInteger)panelIndex{
    NSLog(@"Introduction did change to panel %ld", (long)panelIndex);
    
    //You can edit introduction view properties right from the delegate method!
    //If it is the first panel, change the color to green!
    if (panelIndex == 0) {
        [introductionView setBackgroundColor:[UIColor colorWithRed:90.0f/255.0f green:175.0f/255.0f blue:113.0f/255.0f alpha:0.65]];
    }
    //If it is the second panel, change the color to blue!
    else if (panelIndex == 1){
        [introductionView setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:79.0f/255.0f blue:133.0f/255.0f alpha:0.65]];
    }
}

-(void)introduction:(MYBlurIntroductionView *)introductionView didFinishWithType:(MYFinishType)finishType {
    NSLog(@"Introduction did finish");
}

@end