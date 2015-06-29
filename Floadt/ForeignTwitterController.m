//
//  ForeignFacebookController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 5/27/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import "ForeignTwitterController.h"

@interface ForeignTwitterController () <MBTwitterScrollDelegate>
@end

@implementation ForeignTwitterController
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MBTwitterScroll *myTableView = [[MBTwitterScroll alloc]
                                    initTableViewWithBackgound:[UIImage imageNamed:@"your image"]
                                    avatarImage:[UIImage imageNamed:@"your avatar"]
                                    titleString:@"Main title"
                                    subtitleString:@"Sub title"
                                    buttonTitle:@"Follow"];  // Set nil for no button
    myTableView.delegate = self;
    [self.view addSubview:myTableView];
}

-(void)recievedMBTwitterScrollEvent {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
