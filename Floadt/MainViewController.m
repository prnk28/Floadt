//
//  MainViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/25/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "MainViewController.h"
@interface MainViewController ()
{

}
@end




@implementation MainViewController

 

-(void) awakeFromNib
{
  
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"barController"]];
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"centerPage"]];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.]
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"classy_fabric.png"]]];
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
