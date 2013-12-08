//
//  ModalViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 8/23/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    NSDictionary *entry = [self entries][indexPath.row];
    NSDictionary *text = [self entries][indexPath.row];
    NSString *user = entry[@"user"][@"full_name"];
    NSString *caption = text[@"caption"][@"text"];
    
    [barButton setTitle:@"" forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"close_usIMG.png"] forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"close_sIMG.png"] forState:UIControlStateHighlighted];
    [barButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    barButton.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    self.navBar.leftBarButtonItem = barButtonItem;
    
    
    UIImage *image = [UIImage imageNamed:@"navigationBar.png"];
    
    [[UINavigationBar appearance] setBackgroundImage:image
                                       forBarMetrics:UIBarMetricsDefault];
}

-(void)close:(id)sender{
    [self dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
