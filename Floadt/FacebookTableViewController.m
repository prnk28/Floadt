//
//  FacebookTableViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 1/14/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import "FacebookTableViewController.h"

@interface FacebookTableViewController ()

@end

@implementation FacebookTableViewController
@synthesize facebookPosts;
@synthesize facebookResponse;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[FacebookCell class] forCellReuseIdentifier:@"FacebookCell"];
    [self fetchFacebookPosts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchFacebookPosts {
    [FBRequestConnection startWithGraphPath:@"me/feed" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            NSLog(@"%@",result);
            facebookResponse = [result mutableCopy];
            [self.facebookPosts addObjectsFromArray:result[@"data"]];
            [self.tableView reloadData];
        } else {
            NSLog(@"Failure: %@", error);
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 184;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return facebookPosts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FacebookCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"FacebookCell"];
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    
    if (cell == nil) {
        cell = [[FacebookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FacebookCell"];
    }
    
    NSDictionary *entry = facebookPosts[indexPath.row];
    
    // Set Image
    
    // Set User Name
    NSString *user =  entry[@"message"];
    [cell.textLabel setText:user];
    
    
    
    return cell;
}

#pragma mark - XLPagerTabStripViewControllerDelegate

-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"Facebook";
}

-(UIColor *)colorForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return [UIColor whiteColor];
}

@end
