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
        facebookLoggedIn = YES;
        linkedinLoggedIn = NO;

    }
    return self;
}

-(void)setInstagramLogged:(BOOL *)turtle{
    
    turtle = &(instagramLoggedIn);
}

-(BOOL)returnAllOff{
    if (!instagramLoggedIn && !twitterLoggedIn && !googleLoggedIn && !facebookLoggedIn && !linkedinLoggedIn) {
        NSLog(@"All are off");
        return YES;
    }else{
        NSLog(@"One or More Networks Enabled");
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
