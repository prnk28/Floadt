//
//  TestLoginViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/2/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "TestLoginViewController.h"

@interface TestLoginViewController ()

@end

@implementation TestLoginViewController

//Class Variable Decleration
int dialog = 0;


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    
    if ([PFUser currentUser]) {
        [_label setText:[NSString stringWithFormat:@"Welcome %@!", [[PFUser currentUser] username]]];
    } else {
        
        [_label setText:@"Not logged in"];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
      if(self.navigationController.viewControllers.count > 1) {
        
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [backButton setTitle:@"" forState:UIControlStateNormal];
        [backButton setBackgroundImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
        [backButton setBackgroundImage:[UIImage imageNamed:@"backButton_s.png"] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(didTapBackButton:) forControlEvents:UIControlEventTouchUpInside];
        backButton.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        self.navigationItem.leftBarButtonItem = backButtonItem;
        
        
        UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [settingsButton setTitle:@"" forState:UIControlStateNormal];
        [settingsButton setBackgroundImage:[UIImage imageNamed:@"settingsButton.png"] forState:UIControlStateNormal];
        [settingsButton setBackgroundImage:[UIImage imageNamed:@"settingsButton_s.png"] forState:UIControlStateHighlighted];
        settingsButton.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
        UIBarButtonItem *settingsButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
        
        self.navigationItem.rightBarButtonItem = settingsButtonItem;
          
    }
    
}



- (void) didTapBackButton:(id)sender {
    if(self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


#pragma mark - PFLogInViewControllerDelegate


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


- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [[Kiip sharedInstance] saveMoment:@"Test Moment" withCompletionHandler:nil];
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}


- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}


- (IBAction)logInP:(id)sender {
    if (![PFUser currentUser]) {
        
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [logInViewController setSignUpController:signUpViewController];
        
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}

- (IBAction)logOutP:(id)sender {
    
    dialog+=1;
    
    if (dialog == 1) {
        
    }
    else if (dialog > 3){
        
        _label.text = @"Seriously Stop.";
    }
    else if(dialog > 5){
        
        _label.text = @"Ok You win....";
    }
    [PFUser logOut];
    
}

@end
