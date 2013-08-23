//
//  AppDelegate.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/25/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "AppDelegate.h"
#import <KiipSDK/KiipSDK.h>
#import "Imports.h"
#import "UIViewController+JASidePanel.h"
#import "AFOAuth1Client.h"
#import "StackMob.h"
#import "AFOpenGLManager.h"
#import "User.h"
#import "DefaultViewController.h"
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
   //     CredentialStore *store = [[CredentialStore alloc] init];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    // Kiip Monetization
    Kiip *kiip = [[Kiip alloc] initWithAppKey:@"01007bf4acea9a6bb2af55812d670e13" andSecret:@"98580e21b66e08b2fcc8e371dbb1adaf"];
    kiip.delegate = self;
    [Kiip setSharedInstance:kiip];
    
    SMClient *client;
    client = [[SMClient alloc] initWithAPIVersion:@"0" publicKey:@"71f74f75-3998-4605-b994-2fb7e33ba409"];
    
    BOOL returnAllOff = [[User data] returnAllOff];
    /*
    if (returnAllOff) {

        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
    DefaultViewController *viewController = [[DefaultViewController alloc] init]; 
        self.window.rootViewController = viewController;
        [self.window makeKeyAndVisible];
    }
    */
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [AFOpenGLManager beginOpenGLLoad];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSString *daURL = [url absoluteString];
    NSString *instagram;
    NSString *twitter;
    
    twitter = [daURL substringWithRange: NSMakeRange (0, 16)];
    instagram = [daURL substringWithRange:NSMakeRange(0, 27)];
    
    if ([twitter isEqual: @"floadt://success"]) {
        NSLog (@"Twitter = %@", twitter);
        NSNotification *notification = [NSNotification notificationWithName:kAFApplicationLaunchedWithURLNotification object:nil userInfo:[NSDictionary dictionaryWithObject:url forKey:kAFApplicationLaunchOptionsURLKey]];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }else{
    [[InstagramClient sharedClient] handleOAuthCallbackWithURL:url];
    }
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

- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    
}

@end
