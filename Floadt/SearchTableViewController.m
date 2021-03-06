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
    _searchBar.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *imageUrl = totalArray[@"profile_picture"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.proImageView.image = [UIImage imageWithData:data];
            CALayer *imageLayer = cell.proImageView.layer;
            [imageLayer setCornerRadius:25];
            [imageLayer setMasksToBounds:YES];
        });
    });
}

- (void)didTapPostButton:(id)sender
{

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

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self fetchInstagramResultsWith:_searchBar.text];
    [self.view endEditing:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    ForiegnInstagramController *forInsta = [[ForiegnInstagramController alloc] init];
    NSDictionary *pic = [instagramResults objectAtIndex:indexPath.row];
    id idval = pic[@"id"];
    forInsta.idValue = idval;
    [forInsta setEntersFromSearch:(BOOL *)YES];
    [self.navigationController pushViewController:forInsta animated:YES];
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
    [postButton setBackgroundImage:[UIImage imageNamed:@"shareButton.png"] forState:UIControlStateNormal];
    [postButton addTarget:self action:@selector(didTapPostButton:) forControlEvents:UIControlEventTouchUpInside];
    postButton.frame = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    UIBarButtonItem *postButtonItem = [[UIBarButtonItem alloc] initWithCustomView:postButton];
    
    self.navBar.rightBarButtonItem = postButtonItem;
    
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                      [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                      [UIFont fontWithName:@"AeroviasBrasilNF" size:30.0], NSFontAttributeName, nil]];

}


@end
