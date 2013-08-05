//
//  TwitterClient.m
//  Floadt
//
//  Created by Pradyumn Nukala on 8/2/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#define TWITTER_AUTH_URL_FORMAT @"https://api.twitter.com/oauth/authorize?oauth_token=%@"

#import "TwitterClient.h"
#define kAuthToken @"MyKeyString"

@interface TwitterClient ()
@property (nonatomic, copy) NSString *accessToken;
@end

@implementation TwitterClient

+ (instancetype)sharedClient {
    static TwitterClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"https://api.twitter.com/1/"];
        _sharedClient = [[TwitterClient alloc] initWithBaseURL:baseURL];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setAuthTokenHeader];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(tokenChanged:)
                                                     name:@"token-changed"
                                                   object:nil];
    }
    return self;
}

- (void)authenticateWithTwitter{
    AFOAuth1Client *twitterClient;
    
    [twitterClient authorizeUsingOAuthWithRequestTokenPath:@"oauth/request_token"
                                          userAuthorizationPath:@"oauth/authorize"
                                                    callbackURL:[NSURL URLWithString:@"floadt://twitterConfirmed"]
                                                accessTokenPath:@"oauth/access_token"
                                                   accessMethod:@"POST"
                                                          scope:nil
                                                        success:^(AFOAuth1Token *accessToken, id response) {
                                                            
                                                            [twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
                                                            [twitterClient getPath:@"1.1/statuses/user_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                NSArray *responseArray = (NSArray *)responseObject;
                                                                [responseArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                                    NSLog(@"Success: %@", obj);
                                                                }];
                                                            }                                               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                NSLog(@"Error: %@", error);
                                                            }];
                                                            
                                                        } failure:^(NSError *error) {
                                                            NSLog(@"Error: %@", error);
                                                        }];
    
    
}

- (void)handleOAuthCallbackWithURL:(NSURL *)url {
    NSError *regexError = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[^#]*#access_token=(.*)$"
                                                                           options:0
                                                                             error:&regexError];
    NSString *input = [url description];
    [regex enumerateMatchesInString:input
                            options:0
                              range:NSMakeRange(0, [input length])
                         usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                             if ([result numberOfRanges] > 1) {
                                 NSRange accessTokenRange = [result rangeAtIndex:1];
                                 self.accessToken = [input substringWithRange:accessTokenRange];
                                 NSLog(@"Access Token: %@", self.accessToken);
                                 [Lockbox setString:self.accessToken forKey:kAuthToken];
                                 
                             }
                         }];
    
}

- (void)setAuthTokenHeader {
    NSString *authToken = [Lockbox stringForKey:kAuthToken];
    [self setDefaultHeader:@"auth_token" value:authToken];
}

- (void)tokenChanged:(NSNotification *)notification {
    [self setAuthTokenHeader];
}

- (NSString *)accessToken {
    return [Lockbox stringForKey:kAuthToken];
}

-(AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)urlRequest success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    NSMutableURLRequest *request = [urlRequest mutableCopy];
    NSString *separator = [request.URL query] ? @"&" : @"?";
    NSString *newURLString = [NSString stringWithFormat:@"%@%@access_token=%@", [request.URL absoluteString], separator, self.accessToken];
    NSURL *newURL = [[NSURL alloc] initWithString:newURLString];
    [request addValue:nil forHTTPHeaderField:@"auth_token"];
    [request setURL:newURL];
    return [super HTTPRequestOperationWithRequest:request success:success failure:failure];
    
}

@end
