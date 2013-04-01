//
//  BarViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/26/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "BarViewController.h"
#import <KiipSDK/KiipSDK.h>

@interface BarViewController ()

@end

typedef enum {
    DemoTableViewRowDefaultSettings = 0,
    DemoTableViewRowCustomProperties,
    DemoTableViewRowCustomSubclasses,
    DemoTableViewNumberOfRows
} DemoTableViewRow;


@implementation BarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
int dialog = 0;


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    
    if ([PFUser currentUser]) {
        [_welcomeLabel setText:[NSString stringWithFormat:@"Welcome %@!", [[PFUser currentUser] username]]];
    } else {
        
        [_welcomeLabel setText:@"Not logged in"];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    if (username && password && username.length && password.length) {
        return YES;
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Make sure you fill out all of the information!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    return NO;
}


- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}


- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - PFSignUpViewControllerDelegate


- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || !field.length) {
            informationComplete = NO;
            break;
        }
    }
    
    
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Make sure you fill out all of the information!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}



- (IBAction)kiip:(id)sender {
     [[Kiip sharedInstance] saveMoment:@"Test Moment" withCompletionHandler:nil];
}

- (IBAction)login:(id)sender {
    if (![PFUser currentUser]) {
        
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [logInViewController setSignUpController:signUpViewController];
        
        [self presentViewController:logInViewController animated:YES completion:NULL];

    }
}
- (IBAction)logout:(id)sender {
    dialog+=1;
    
    if (dialog == 1) {
        
         _welcomeLabel.text = @"Not Logged In.";
        
    }
    else if (dialog > 3){
        
        _welcomeLabel.text = @"Seriously Stop.";
    }
    else if(dialog > 5){
        
        _welcomeLabel.text = @"Ok You win....";
    }
    [PFUser logOut];
    
}
@end
