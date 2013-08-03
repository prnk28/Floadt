//
//  TwitterClient.h
//  Floadt
//
//  Created by Pradyumn Nukala on 8/2/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "AFHTTPClient.h"
#import "Imports.h"
#import "AFNetworking.h"
#import "Lockbox.h"

@interface TwitterClient : AFHTTPClient

+ (instancetype)sharedClient;

- (void)authenticateWithOAuth:(NSString *)oKey;

- (void)handleOAuthCallbackWithURL:(NSURL *)url;

@end
