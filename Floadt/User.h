//
//  User.h
//  Floadt
//
//  Created by Pradyumn Nukala on 10/9/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, retain) NSString *twitterUsername;
@property (nonatomic, retain) NSString *twitterFullName;
@property (nonatomic, retain) NSString *twitterProfilePic;
@property (nonatomic, retain) NSString *twitterFollowerCount;
@property (nonatomic, retain) NSString *twitterFollowingCount;

+ (instancetype)sharedClient;

- (void)setTwitterInfoWithUsername:(NSString *)username withFullName:(NSString *)fullName WithProfilePic:(NSString *)profilePic withFollowerCount:(NSString *)followerCount withFollowingCount:(NSString *)followingCount;


@end
