//
//  TwitterClient.h
//  Floadt
//
//  Created by Pradyumn Nukala on 8/16/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "AFOAuth1Client.h"
#import "Imports.h"
#import "Lockbox.h"

@interface TwitterClient : AFOAuth1Client

+ (instancetype)sharedClient;
-(void)authenticateWithTwitter;
-(void)getTimeline;

@end
