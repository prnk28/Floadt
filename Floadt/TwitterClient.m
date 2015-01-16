//
//  TwitterClient.m
//  Floadt
//
//  Created by Pradyumn Nukala on 8/16/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//
#define kAccessTokenTwitter    @""

#import "TwitterClient.h"
#import "User.h"

@interface TwitterClient()

@property (nonatomic, strong)AFOAuth1Client *twitterClient;

@end

@implementation TwitterClient

+(instancetype)sharedClient {
    static TwitterClient *_sharedClient = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"https://api.twitter.com/"];
        _sharedClient = [[TwitterClient alloc] initWithBaseURL:baseURL];
        
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    return self;
}

- (void)authenticateWithTwitter  {
    self.twitterClient = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/"]
                                                             key:@"tA5TT8uEtg88FwAHnVpBcbUoq"
                                                          secret:@"L5whWoi91HmzjrE5bNPNUgoMXWnImvpnkIPHZWQ4VmymaoXyYV"];
    
    [self.twitterClient authorizeUsingOAuthWithRequestTokenPath:@"oauth/request_token"
                                          userAuthorizationPath:@"oauth/authorize"
                                                    callbackURL:[NSURL URLWithString:@"floadt://success"]
                                                accessTokenPath:@"oauth/access_token"
                                                   accessMethod:@"GET"
                                                          scope:nil
                                                        success:^(AFOAuth1Token *accessToken, id response) {
                                                            [AFOAuth1Token storeCredential:accessToken withIdentifier:@"TwitterToken"];
                                                            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"twitterActive"];
                                                            [[NSUserDefaults standardUserDefaults] synchronize];
                                                            [self.twitterClient getPath:@"account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                NSLog(@"Error: %@", error);
                                                            }];
                                                        } failure:^(NSError *error) {
                                                            NSLog(@"Error: %@", error);
                                                        }];
}

- (void)logoutTwitter {
    [AFOAuth1Token deleteCredentialWithIdentifier:@"TwitterToken"];
}
@end
