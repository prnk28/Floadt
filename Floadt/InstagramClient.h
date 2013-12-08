//
//  InstagramClient.h
//  Floadt
// //  Created by Pradyumn Nukala on 7/22/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "Data.h"


@interface InstagramClient : AFHTTPClient

+ (instancetype)sharedClient;

- (void)authenticateWithClientID:(NSString *)clientId callbackURL:(NSString *)callbackUrl;
- (void)handleOAuthCallbackWithURL:(NSURL *)url;
- (NSString *)accessToken;

@end
