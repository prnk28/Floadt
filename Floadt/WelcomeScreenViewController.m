//
//  WelcomeScreenViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 10/17/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import "WelcomeScreenViewController.h"
#import "StreamViewController.h"
#import "Data.h"

@interface WelcomeScreenViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *wallpaperImageView;

@end

@implementation WelcomeScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
       NSArray *images = [[NSArray alloc] initWithObjects:
                       @"bluetexture.png",
                       @"bubbles.png",
                       @"hashtag.png",
                       @"kayak.png",
                       @"mosoleum.png",
                       @"mountain.png",
                       @"nightmountain.png",
                       @"nyc.png",
                       nil];
    
    
    
    int count = [images count];
    int randNum = arc4random() % count;
    _wallpaperImageView.image = [UIImage imageNamed:[images objectAtIndex:randNum]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonTouch:(id)sender
{

        NSLog(@"Login Button Has been Tapped.");
    
    
    WelcomeScreenViewController *viewController = [[WelcomeScreenViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}



- (IBAction)registerButtonTouch:(id)sender
{
    NSLog(@"Register Button Has been Tapped.");
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasRegistered"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
