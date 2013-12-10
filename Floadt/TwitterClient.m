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
        
        BOOL *twitterEnabled = [user boolForKey:@"TwitterAuthenticated"];
        
        if (twitterEnabled) {
            
            AFOAuth1Token *token = [AFOAuth1Token retrieveCredentialWithIdentifier:@"TweetKey"];
            token = self.aToken;
        }

    }
    return self;
}



-(void)authenticateWithTwitter{
    user = [NSUserDefaults standardUserDefaults];
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
                                                            [AFOAuth1Token storeCredential:accessToken withIdentifier:@"TwitterKey"];                                                            self.aToken = accessToken;
                                                            [user setBool:YES forKey:@"TwitterAuthenticated"];
                                                        } failure:^(NSError *error) {
                                                            NSLog(@"Error: %@", error);
                                                        }];
    
}



-(void)getTimeline{
        [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self.twitterClient getPath:@"1.1/statuses/user_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSArray *responseArray = (NSArray *)responseObject;
            [responseArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSLog(@"Success: %@", obj);
                //StreamViewController *vc = [[StreamViewController alloc] init];
                //vc.tweets = responseArray;
            }];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
}

@end
