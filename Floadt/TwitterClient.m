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
@property (nonatomic, copy) AFOAuth1Token *aToken;
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
        bool *twitterEnabled = [user boolForKey:@"TwitterActive"];
        if (twitterEnabled) {
            AFOAuth1Token *token = [AFOAuth1Token retrieveCredentialWithIdentifier:@"TwitterAuth"];
            token = self.aToken;
        }
    }
    return self;
}

-(void)authenticateWithTwitter{
    user = [NSUserDefaults standardUserDefaults];
    if (self.aToken == nil) {
    self.twitterClient = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/"]
                                                             key:@"4oFCF0AjP4PQDUaCh5RQ"
                                                          secret:@"NxAihESVsdUXSUxtHrml2VBHA0xKofYKmmGS01KaSs"];
    
    [self.twitterClient authorizeUsingOAuthWithRequestTokenPath:@"oauth/request_token"
                                          userAuthorizationPath:@"oauth/authorize"
                                                    callbackURL:[NSURL URLWithString:@"floadt://success"]
                                                accessTokenPath:@"oauth/access_token"
                                                   accessMethod:@"GET"
                                                          scope:nil
                                                        success:^(AFOAuth1Token *accessToken, id response) {
                                                            [AFOAuth1Token storeCredential:accessToken withIdentifier:@"TwitterAuth"];                                                            self.aToken = accessToken;
                                                            [user setBool:YES forKey:@"TwitterActive"];
                                                        } failure:^(NSError *error) {
                                                            NSLog(@"Error: %@", error);
                                                        }];
    }
}

-(AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)urlRequest success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    NSMutableURLRequest *request = [urlRequest mutableCopy];
    NSString *separator = [request.URL query] ? @"&" : @"?";
    NSString *newURLString = [NSString stringWithFormat:@"%@%@access_token=%@", [request.URL absoluteString], separator, self.aToken];
    NSURL *newURL = [[NSURL alloc] initWithString:newURLString];
    [request setURL:newURL];
    return [super HTTPRequestOperationWithRequest:request success:success failure:failure];
    
}

@end
