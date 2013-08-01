//
//  FacebookClient.h
//  Floadt
//
//  Created by Pradyumn Nukala on 7/31/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "AFHTTPClient.h"
#import "Imports.h"
#import "AFNetworking.h"

@interface FacebookClient : AFHTTPClient

+ (instancetype)sharedClient;

- (void)authenticateWithClientID:(NSString *)clientId callbackURL:(NSString *)callbackUrl;
- (void)handleOAuthCallbackWithURL:(NSURL *)url;


@end
