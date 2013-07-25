//
//  InstagramClient.m
//  InstagramClient
//
//  Created by ben on 6/30/13.
//  Copyright (c) 2013 Fickle Bits. All rights reserved.
//

#define INSTAGRAM_AUTH_URL_FORMAT @"https://instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token"

#import "InstagramClient.h"
#import "CredentialStore.h"

@interface InstagramClient ()
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, strong) CredentialStore *credentialStore;
@end

@implementation InstagramClient

+ (instancetype)sharedClient {
    static InstagramClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"https://api.instagram.com/v1/"];
        _sharedClient = [[InstagramClient alloc] initWithBaseURL:baseURL];
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

- (void)authenticateWithClientID:(NSString *)clientId callbackURL:(NSString *)callbackUrl {
    NSString *urlString = [NSString stringWithFormat:INSTAGRAM_AUTH_URL_FORMAT, clientId, callbackUrl];
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
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
                                 NSString *authToken = self.accessToken;
                                 [self.credentialStore setAuthToken:authToken];
                             }
                         }];
    
}

- (void)setAuthTokenHeader {
    CredentialStore *store = [[CredentialStore alloc] init];
    NSString *authToken = [store authToken];
    [self setDefaultHeader:@"auth_token" value:authToken];
}

- (void)tokenChanged:(NSNotification *)notification {
    [self setAuthTokenHeader];
}


-(AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)urlRequest success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    NSMutableURLRequest *request = [urlRequest mutableCopy];
    NSString *separator = [request.URL query] ? @"&" : @"?";
    NSString *newURLString = [NSString stringWithFormat:@"%@%@access_token=%@", [request.URL absoluteString], separator, self.accessToken];
    NSURL *newURL = [[NSURL alloc] initWithString:newURLString];
    [self.credentialStore setAuthToken:_accessToken];
    [request addValue:nil forHTTPHeaderField:@"auth_token"];
    [request addValue:[self.credentialStore authToken] forHTTPHeaderField:@"auth_token"];
    [request setURL:newURL];
    return [super HTTPRequestOperationWithRequest:request success:success failure:failure];
    
}

@end
