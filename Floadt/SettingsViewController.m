//
//  SettingsViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/31/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsViewController.h"
#import "AwesomeDataSource.h"
#import "QuadCurveDefaultMenuItemFactory.h"
#import "QuadCurveLinearDirector.h"

@interface SettingsViewController ()


@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"classy_fabric.png"]]];
    
    self.TAuth.buttonBackgroundColor = [UIColor colorWithRed:0.32f green:0.64f blue:0.32f alpha:1.00f]; //[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.60f alpha:1.0f];
    self.TAuth.buttonForegroundColor = [UIColor colorWithHue:0.0f saturation:0.0f brightness:1.0f alpha:1.0f];
    self.TAuth.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.TAuth setFlatTitle:@"  Login to Twitter"];
    [self.TAuth setFlatImage:[UIImage imageNamed:@"cog_02.png"]];
    
 /*
    
    AwesomeDataSource *dataSource = [[AwesomeDataSource alloc] init];
    
    QuadCurveMenu *menu = [[QuadCurveMenu alloc] initWithFrame:self.view.bounds dataSource:dataSource];
    
        [menu setMenuDirector:[[QuadCurveLinearDirector alloc] initWithAngle:M_PI/2 andPadding:15.0]];
    
        [menu setMainMenuItemFactory:[[QuadCurveDefaultMenuItemFactory alloc] initWithImage:[UIImage imageNamed:@"facebook.png"] highlightImage:[UIImage imageNamed:nil]]];
    
      [menu setMenuItemFactory:[[QuadCurveDefaultMenuItemFactory alloc] initWithImage:[UIImage imageNamed:@"unknown-user.png"] highlightImage:[UIImage imageNamed:nil]]];
    
    menu.delegate = self;
	[self.view addSubview:menu];
*/  
	
}

#pragma mark - QuadCurveMenuDelegate Adherence

- (void)quadCurveMenu:(QuadCurveMenu *)menu didTapMenu:(QuadCurveMenuItem *)mainMenuItem {
    NSLog(@"Menu - Tapped");
}

- (void)quadCurveMenu:(QuadCurveMenu *)menu didLongPressMenu:(QuadCurveMenuItem *)mainMenuItem {
    NSLog(@"Menu - Long Pressed");
}

- (void)quadCurveMenu:(QuadCurveMenu *)menu didTapMenuItem:(QuadCurveMenuItem *)menuItem {
    PFUser *user = [PFUser currentUser];
    
    if (![PFTwitterUtils isLinkedWithUser:user]) {
        [PFTwitterUtils linkUser:user block:^(BOOL succeeded, NSError *error) {
            if ([PFTwitterUtils isLinkedWithUser:user]) {
                NSLog(@"Woohoo, user logged in with Twitter!");
            }
        }];
    
    

    
    
    NSLog(@"Menu Item (%@) - Tapped",menuItem.dataObject);
   }
}

- (void)quadCurveMenu:(QuadCurveMenu *)menu didLongPressMenuItem:(QuadCurveMenuItem *)menuItem {
    NSLog(@"Menu Item (%@) - Long Pressed",menuItem.dataObject);
}

- (void)quadCurveMenuWillExpand:(QuadCurveMenu *)menu {
    NSLog(@"Menu - Will Expand");
}

- (void)quadCurveMenuDidExpand:(QuadCurveMenu *)menu {
    NSLog(@"Menu - Did Expand");
}

- (void)quadCurveMenuWillClose:(QuadCurveMenu *)menu {
    NSLog(@"Menu - Will Close");
}

- (void)quadCurveMenuDidClose:(QuadCurveMenu *)menu {
    NSLog(@"Menu - Did Close");
}

- (BOOL)quadCurveMenuShouldClose:(QuadCurveMenu *)menu {
    return YES;
}

- (BOOL)quadCurveMenuShouldExpand:(QuadCurveMenu *)menu {
    return YES;
}


- (IBAction)tweetLogin:(id)sender {
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Twitter login.");
            return;
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in with Twitter!");
        } else {
            NSLog(@"User logged in with Twitter!");
        }     
    }];

}

@end
