//
//  User.m
//  Floadt
//
//  Created by Pradyumn Nukala on 8/20/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "User.h"

@implementation User

+(instancetype)data {
    static User *_data = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _data = [[User alloc] init];
    });
    
    return _data;
}

- (id)init {
    if (self = [super init]) {
        
        instagramLoggedIn = NO;
        twitterLoggedIn = NO;
        googleLoggedIn = NO;
        facebookLoggedIn = NO;
        linkedinLoggedIn = NO;

    }
    return self;
}

-(void)setInstagramLogged:(BOOL *)turtle{
    
    instagramLoggedIn = turtle;
}

-(BOOL)returnAllOff{
    if (!instagramLoggedIn && !twitterLoggedIn && !googleLoggedIn && !facebookLoggedIn && !linkedinLoggedIn) {
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)returnInstagramState{
    return instagramLoggedIn;
}

-(BOOL)returnTwitterState{
    return twitterLoggedIn;
}

-(BOOL)returnGoogleState{
    return googleLoggedIn;
}

-(BOOL)returnFacebookState{
    return facebookLoggedIn;
}

-(BOOL)returnLinkedinState{
    return linkedinLoggedIn;
}
@end
