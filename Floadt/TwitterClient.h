//
//  TwitterClient.h
//  Floadt
//
//  Created by Pradyumn Nukala on 8/16/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "AFOAuth1Client.h"
#import "Data.h"
#import "Lockbox.h"

@interface TwitterClient : AFOAuth1Client {
    NSUserDefaults *user;
}

+ (instancetype)sharedClient;
-(void)authenticateWithTwitter;
-(void)getTimeline;

@end
