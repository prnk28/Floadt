//
//  AppDelegate.h
//  Floadt
//
//  Created by Pradyumn Nukala on 10/9/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AFOAuth1Client *twitterClient;
@end
