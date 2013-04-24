//
//  AppDelegate.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/25/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "AppDelegate.h"
#import <KiipSDK/KiipSDK.h>
#import <Parse/Parse.h>
#import <NewRelicAgent/NewRelicAgent.h>

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [Parse setApplicationId:@"dv6sMGqcQXmrr7lRCLqZhgtvCYb3nn6yL4PagAAe" clientKey:@"JmTZvpZO6CVukRxvpZ9fd9r7P8ITvQKNhihMTrxq"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    Kiip *kiip = [[Kiip alloc] initWithAppKey:@"01007bf4acea9a6bb2af55812d670e13" andSecret:@"98580e21b66e08b2fcc8e371dbb1adaf"];
    kiip.delegate = self;
    [Kiip setSharedInstance:kiip];
    
    [PFTwitterUtils initializeWithConsumerKey:@"citoWm6LNlooU6jBNEarpA" consumerSecret:@"mLSwLz5o9l5TLHxDucGn9SYkXxBEHh03cUtQXu1Ts"];
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
