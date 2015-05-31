//
//  User.m
//  Floadt
//
//  Created by Pradyumn Nukala on 10/9/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import "User.h"

@implementation User

// Twitter Properties
@synthesize twitterFollowerCount;
@synthesize twitterFollowingCount;
@synthesize twitterFullName;
@synthesize twitterProfilePic;
@synthesize twitterUsername;
@synthesize userID;


+ (instancetype)sharedClient {
    static User *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    });
    
    return _sharedClient;
}

- (void)setTwitterInfoWithUsername:(NSString *)username withFullName:(NSString *)fullName WithProfilePic:(NSString *)profilePic withFollowerCount:(NSString *)followerCount withFollowingCount:(NSString *)followingCount withUserID:(NSString *)userid{
    twitterUsername = username;
    twitterProfilePic = profilePic;
    twitterFullName = fullName;
    twitterFollowingCount = followingCount;
    twitterFollowerCount = followerCount;
    userID = userid;
}

@end
