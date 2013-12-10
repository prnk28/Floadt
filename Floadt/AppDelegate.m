//
//  AppDelegate.m
//  Floadt
//
//  Created by Pradyumn Nukala on 10/9/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    #ifdef DEBUG
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    #endif
    
    UIFont *newFont = [UIFont fontWithName:@"Aerovias_Brasil_NF" size:14];
    [[UILabel appearance] setFont:newFont];
    
    // Override point for customization after application launch.
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"] && [[NSUserDefaults standardUserDefaults] boolForKey:@"hasRegistered"])
    {
        // App Already launched
        NSLog(@"Application Already Launched Once.");

        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        // Override point for customization after application launch.
        self.updatedRootViewController = [[RootMenuController alloc] init];
        self.window.rootViewController = self.updatedRootViewController;
        [self.window makeKeyAndVisible];
    }
    else
    {
        NSLog(@"First time launch.");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // This is the first launch ever
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        // Override point for customization after application launch.
        self.viewController = [storyboard instantiateViewControllerWithIdentifier:@"Welcome"];
        self.window.rootViewController = self.viewController;
        [self.window makeKeyAndVisible];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    NSString *daURL = [url absoluteString];
    NSString *instagram;
    NSString *twitter;
    
    twitter = [daURL substringWithRange: NSMakeRange (0, 16)];
    instagram = [daURL substringWithRange:NSMakeRange(0, 27)];
    
    if ([twitter isEqual: @"floadt://success"]) {
        NSNotification *notification = [NSNotification notificationWithName:kAFApplicationLaunchedWithURLNotification object:nil userInfo:[NSDictionary dictionaryWithObject:url forKey:kAFApplicationLaunchOptionsURLKey]];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }else{
        [[InstagramClient sharedClient] handleOAuthCallbackWithURL:url];
    }
    
    return YES;
}

#ifdef DEBUG
void uncaughtExceptionHandler(NSException *ex)
{
    NSLog(@"CRASH :\n %@", ex.reason);
    NSLog(@"STACK TRACE :\n %@", ex.callStackSymbols);
    exit(0);
}
#endif

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
