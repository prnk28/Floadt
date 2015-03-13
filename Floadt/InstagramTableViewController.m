//
//  InstagramTableViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 1/14/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import "InstagramTableViewController.h"

@interface InstagramTableViewController ()

@end

@implementation InstagramTableViewController

@synthesize instaPics;
@synthesize instagramResponse;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavbarGestureRecognizer];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    [self.tableView registerClass:[InstagramCell class] forCellReuseIdentifier:@"InstaCell"];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"instagramActive"]){
        [self fetchInstagramPics];
        [self.tableView reloadData];
    }
    [self.tableView setScrollsToTop:YES];
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
    return instaPics.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 496;
}

#pragma mark - XLPagerTabStripViewControllerDelegate

-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"Instagram";
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InstagramCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"InstaCell"];
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    
    if (cell == nil) {
        cell = [[InstagramCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InstaCell"];
    }
    
    NSDictionary *entry = instaPics[indexPath.row];
    
    // Set Image
    NSString *imageUrlString = entry[@"images"][@"low_resolution"][@"url"];
    NSURL *url = [NSURL URLWithString:imageUrlString];
    [cell.instagramPic sd_setImageWithURL:url];
    
    // Set User Name
    NSString *user = entry[@"user"][@"full_name"];
    [cell.nameLabel setText:user];
    
    // If no Caption
    if (entry[@"caption"] != [NSNull null] && entry[@"caption"][@"text"] != [NSNull null])            {
        NSString *caption = entry[@"caption"][@"text"];
        [cell.commentText setText:caption];
    }else{
        NSString *caption = @"";
        [cell.commentText setText:caption];
    }
    
    // Set the number of likes
    NSString *likesCount = entry[@"likes"][@"count"];
    NSString *likes = [NSString stringWithFormat: @"%@", likesCount];
    [cell.likeLabel setText:likes];
    
    // Add Profile Image
    NSURL *imageUrl = entry[@"user"][@"profile_picture"];
    [cell.profilePic sd_setImageWithURL:imageUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.profilePic.image = image;
        //Make the Profile Pic ImageView Circular
        CALayer *imageLayer = cell.profilePic.layer;
        [imageLayer setCornerRadius:25];
        [imageLayer setMasksToBounds:YES];
    }];
    
    // Get place based on LatLng
    NSString *latitude = entry[@"location"][@"latitude"];
    NSString *longitude = entry[@"location"][@"longitude"];
    
    if ([[entry objectForKey:@"location"] objectForKey:@"latitude"] == NSNotFound) {
        NSLog(@"Contains Location");
    }
    return cell;
}

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

- (void)navBarTap {
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

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

- (void)likeInstagramPictureWithID:(NSString *)idcode {
    NSString *path = [NSString stringWithFormat:@"media/%@/likes", idcode];
    [[InstagramClient sharedClient] postPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Successfully Liked Picture");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
    }];
}

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
        [self fetchNextInstagramPage];
    }
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self fetchInstagramPics];
    [refreshControl endRefreshing];
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [[self tableView].indexPathForSelectedRow row];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    NSDictionary *insta = [self.instaPics objectAtIndex:row];
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    InstaPicDetailViewController* vc = [sb instantiateViewControllerWithIdentifier:@"InstagramDetail"];
    vc.detailItem = insta;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
