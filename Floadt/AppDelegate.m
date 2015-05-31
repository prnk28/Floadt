//
//  AppDelegate.m
//  Floadt
//
//  Created by Pradyumn Nukala on 10/9/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import "AppDelegate.h"
#import "SettingsViewController.h"
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    #ifdef DEBUG
    //NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    #endif
    
    [Fabric with:@[TwitterKit]];

    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *sessison, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // Call this method EACH time the session state changes,
                                          //  NOT just when the session open
                                          //[self sessionStateChanged:session state:state error:error];
                                      }];
    }
    UIFont *newFont = [UIFont fontWithName:@"Aerovias_Brasil_NF" size:14];
    [[UILabel appearance] setFont:newFont];
    
    return YES;
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
        
    }else if([instagram isEqual: @"floadt://instagram_callback"]){
        [[InstagramClient sharedClient] handleOAuthCallbackWithURL:url];
    }else{
     return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    }
    return YES;
}

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"facebookActive"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        NSLog(@"Session closed");
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"facebookActive"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
        } else {
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                // https://developers.facebook.com/docs/ios/errors/
            } else {
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
            }
        }
        [FBSession.activeSession closeAndClearTokenInformation];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"facebookActive"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
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
