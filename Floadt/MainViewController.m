//
//  MainViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/25/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "MainViewController.h"
#import "StreamViewController.h"
#import "BarViewController.h"
@interface MainViewController ()
{

}
@end




@implementation MainViewController

 

-(void) awakeFromNib
{
   // StreamViewController *center = [[StreamViewController alloc] init];
   // BarViewController *left = [[BarViewController alloc] init];
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];

    [self setCenterPanel:[board instantiateViewControllerWithIdentifier:@"centerPage"]];
    [self setLeftPanel:[board instantiateViewControllerWithIdentifier:@"barController"]];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.]
    
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
