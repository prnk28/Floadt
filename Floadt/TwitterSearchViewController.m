//
//  TwitterSearchViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 2/6/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import "TwitterSearchViewController.h"

@interface TwitterSearchViewController ()

@end

@implementation TwitterSearchViewController

- (instancetype)init {
    TWTRAPIClient *APIClient = [[Twitter sharedInstance] APIClient];
    TWTRSearchTimelineDataSource *searchTimelineDataSource = [[TWTRSearchTimelineDataSource alloc] initWithSearchQuery:@"zaara" APIClient:APIClient];
    return [super initWithDataSource:searchTimelineDataSource];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
