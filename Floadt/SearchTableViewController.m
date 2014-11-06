//
//  SearchTableViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 11/1/14.
//  Copyright (c) 2014 Floadt. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController ()
@end

@implementation SearchTableViewController

@synthesize facebookActive;
@synthesize instagramDict;
@synthesize instagramResults;
@synthesize twitterActive;
@synthesize instagramActive;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return instagramResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self instagramSearchCellAtIndexPath:indexPath];
}

- (InstagramResultsCell *)instagramSearchCellAtIndexPath:(NSIndexPath *)indexPath {
    InstagramResultsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"instagramSearchCell" forIndexPath:indexPath];
    [self configureInstagramSearchCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureInstagramSearchCell:(InstagramResultsCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *totalArray = instagramResults[indexPath.row];
    
    //Set username for twitter
    NSString *name = totalArray[@"full_name"];
    [cell.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Regular" size:13.0]];
    [cell.nameLabel setText:name];
    
    //Set status for twitter
    NSString *subtitle = totalArray [@"username"];
    [cell.usernameLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:11.0]];
    [cell.usernameLabel setText:subtitle];
    
    [cell.imageView sd_setImageWithURL:totalArray[@"profile_picture"] placeholderImage:nil options:indexPath.row == 0 ? SDWebImageRefreshCached : 0];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didTapPostButton:(id)sender
{
    [self fetchInstagramResultsWith:_searchBar.text];
}

- (void)didTapBarButton:(id)sender
{
    [self.sidePanelController showLeftPanelAnimated:YES];
}

- (void)fetchInstagramResultsWith:(NSString*)query{
    
    NSDictionary *parameters = @{
                                @"q" :query
                                };
    
    [[InstagramClient sharedClient] getPath:@"users/search"
                                 parameters:parameters
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        NSLog(@"Response: %@", responseObject);
                                        instagramDict = [responseObject mutableCopy];
                                        instagramResults = instagramDict[@"data"];
                                        [self.tableView reloadData];
                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        NSLog(@"Failure: %@", error);
                                    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setUpUI];
}

- (void)setUpUI{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.278f green:0.337f blue:0.439f alpha:1.00f]];
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
