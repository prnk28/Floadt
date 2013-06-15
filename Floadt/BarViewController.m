//
//  BarViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/26/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "BarViewController.h"
#import "SettingsViewController.h"
#import <KiipSDK/KiipSDK.h>
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import "StreamViewController.h"



@interface BarViewController ()

@end

typedef enum {
    DemoTableViewRowDefaultSettings = 0,
    DemoTableViewRowCustomProperties,
    DemoTableViewRowCustomSubclasses,
    DemoTableViewNumberOfRows
} DemoTableViewRow;


@implementation BarViewController

int dialog = 0;




- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"classy_fabric.png"]]];
    
    self.b1.buttonBackgroundColor = [UIColor colorWithRed:0.32f green:0.64f blue:0.32f alpha:1.00f]; //[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.60f alpha:1.0f];
    self.b1.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    self.b1.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.b1 setFlatTitle:nil];
    [self.b1 setFlatImage:[UIImage imageNamed:@"131-tower.png"]];
    
    self.b2.buttonBackgroundColor = [UIColor colorWithRed:1.0f green:0.16f blue:0.2f alpha:1.00f]; //[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.60f alpha:1.0f];
    self.b2.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    self.b2.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.b2 setFlatTitle:nil];
    [self.b2 setFlatImage:[UIImage imageNamed:@"101-gameplan.png"]];
    
    self.b3.buttonBackgroundColor = [UIColor colorWithRed:0.0f green:0.4f blue:1.0f alpha:1.00f]; //[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.60f alpha:1.0f];
    self.b3.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    self.b3.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.b3 setFlatTitle:nil];
    [self.b3 setFlatImage:[UIImage imageNamed:@"09-chat-2.png"]];
    
    self.b4.buttonBackgroundColor = [UIColor colorWithRed:0.278f green:0.337f blue:0.439f alpha:1.00f]; //[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.60f alpha:1.0f];
    self.b4.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    self.b4.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.b4 setFlatTitle:nil];
    [self.b4 setFlatImage:[UIImage imageNamed:@"06-magnify.png"]];
    
    self.b5.buttonBackgroundColor = [UIColor colorWithRed:0.32f green:0.14f blue:0.32f alpha:1.00f]; //[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.60f alpha:1.0f];
    self.b5.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    self.b5.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.b5 setFlatTitle:nil];
    [self.b5 setFlatImage:[UIImage imageNamed:@"111-user.png"]];
    
    self.b6.buttonBackgroundColor = [UIColor colorWithRed:1.0f green:0.505f blue:0.0f alpha:1.00f]; //[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.60f alpha:1.0f];
    self.b6.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    self.b6.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.b6 setFlatTitle:nil];
    [self.b6 setFlatImage:[UIImage imageNamed:@"158-wrench-2.png"]];
    
}


- (IBAction)td1:(id)sender {
    
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"centerPage"];

    self.sidePanelController.centerPanel = viewController;
    
    [self.sidePanelController showCenterPanelAnimated:YES];

    
}

- (IBAction)td2:(id)sender {
    NSLog(@"The Haunted BUTTON!");
    
}

- (IBAction)td3:(id)sender {
    

}

- (IBAction)td4:(id)sender {
}

- (IBAction)td5:(id)sender {
    PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
 // Set ourselves as the delegate
    
    // Create the sign up view controller
    PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
   // Set ourselves as the delegate
    
    // Assign our sign up controller to be displayed from the login controller
    [logInViewController setSignUpController:signUpViewController];
    
    // Present the log in view controller
    [self presentViewController:logInViewController animated:YES completion:NULL];
    
}

- (IBAction)td6:(id)sender {
    
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsPage"];
 
    self.sidePanelController.centerPanel = viewController;
    
    [self.sidePanelController showCenterPanelAnimated:YES];

}


#pragma mark - PFLoginViewController

- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    if (username && password && username.length && password.length) {
        return YES;
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Make sure you fill out all of the information!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
    return NO;
}


- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
    if ([PFUser currentUser]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        
    }
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
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    return informationComplete;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
