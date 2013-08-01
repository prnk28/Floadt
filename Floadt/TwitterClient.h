//
//  TwitterClient.h
//  Floadt
//
//  Created by Pradyumn Nukala on 7/31/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "Imports.h"
#import "AFNetworking.h"
#import "AFHTTPClient.h"

@interface TwitterClient : AFHTTPClient

+ (instancetype)sharedClient;

- (void)authenticateWithClientID:(NSString *)clientId callbackURL:(NSString *)callbackUrl;
- (void)handleOAuthCallbackWithURL:(NSURL *)url;

@end
