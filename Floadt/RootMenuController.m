//
//  RootMenuController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 10/20/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import "RootMenuController.h"
#import "Data.h"

@interface RootMenuController ()

@end

@implementation RootMenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.centerPanel = [storyboard instantiateViewControllerWithIdentifier:@"NavInfinity"];
    self.leftPanel = [storyboard instantiateViewControllerWithIdentifier:@"Menu"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
