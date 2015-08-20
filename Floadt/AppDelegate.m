//
//  AppDelegate.m
//  Floadt
//
//  Created by Pradyumn Nukala on 10/9/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import "AppDelegate.h"
#import "SettingsViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    #ifdef DEBUG
    //NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    #endif
    
    UIFont *newFont = [UIFont fontWithName:@"Aerovias_Brasil_NF" size:14];
    [[UILabel appearance] setFont:newFont];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    // Callback from Web-browser
    NSString *daURL = [url absoluteString];
    NSString *instagram;
    NSString *twitter;
    
    twitter = [daURL substringWithRange: NSMakeRange (0, 16)];
    instagram = [daURL substringWithRange:NSMakeRange(0, 27)];
    
    if ([twitter isEqual: @"floadt://success"]) {
        NSNotification *notification = [NSNotification notificationWithName:kAFApplicationLaunchedWithURLNotification object:nil userInfo:[NSDictionary dictionaryWithObject:url forKey:kAFApplicationLaunchOptionsURLKey]];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }else {
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

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#ifdef DEBUG
void uncaughtExceptionHandler(NSException *ex)
{
    NSLog(@"CRASH :\n %@", ex.reason);
    NSLog(@"STACK TRACE :\n %@", ex.callStackSymbols);
    exit(0);
}
#endif

@end
