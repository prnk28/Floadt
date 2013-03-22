//
//  AppDelegate.m
//  Floadt
//
//  Created by Pradyumn Nukala on 2/20/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "TableViewController.h"
#import <KiipSDK/KiipSDK.h>

@implementation AppDelegate

//
//  AppDelegate.m
//  Floadt
//
//  Created by Pradyumn Nukala on 1/25/13.
//  Copyright (c) 2013 Pradyumn nukala. All rights reserved.
//
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Custom Stuff Initialization
    [Parse setApplicationId:@"dv6sMGqcQXmrr7lRCLqZhgtvCYb3nn6yL4PagAAe"
                  clientKey:@"JmTZvpZO6CVukRxvpZ9fd9r7P8ITvQKNhihMTrxq"];

    
    Kiip *kiip = [[Kiip alloc] initWithAppKey:@"01007bf4acea9a6bb2af55812d670e13" andSecret:@"98580e21b66e08b2fcc8e371dbb1adaf"];
    kiip.delegate = self;
    [Kiip setSharedInstance:kiip];
    
    //Create Table view controller
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    
 

    
    
    // Assign tab bar item with titles
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    
    tabBarItem1.title = @"Dashboard";
    tabBarItem1.titlePositionAdjustment = UIOffsetMake(0.0, -5.5);
    tabBarItem2.title = @"Interactions";
    tabBarItem2.titlePositionAdjustment = UIOffsetMake(0.0, -5.5);
    tabBarItem3.title = @"Messages";
    tabBarItem3.titlePositionAdjustment = UIOffsetMake(0.0, -5.5);
    tabBarItem4.title = @"Me";
    tabBarItem4.titlePositionAdjustment = UIOffsetMake(0.0, -5.5);
    
    
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"pen_sIMG.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"pen_usIMG.png"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"comment_sIMG.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"comment_usIMG.png"]];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"message_sIMG.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"message_usIMG.png"]];
    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"star_sIMG.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"star_usIMG.png"]];
    

    
    
    
    
    // Change the tab bar background
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabBarBg-icns.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabBarBg-selc.png"]];
    
    // Change the title color of tab bar items
    UIColor *titleNormColor = [UIColor colorWithRed:137/255.0 green:137/255.0 blue:137/255.0 alpha:1.0];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleNormColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    
    
    UIColor *titleHighlightedColor = [UIColor colorWithRed:73/255.0 green:130/255.0 blue:202/255.0 alpha:1.0];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateHighlighted];
    
    

    
    return YES;
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
