//
//  User.h
//  Floadt
//
//  Created by Pradyumn Nukala on 8/20/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject{
    BOOL twitterLoggedIn;
    BOOL facebookLoggedIn;
    BOOL instagramLoggedIn;
    BOOL googleLoggedIn;
    BOOL linkedinLoggedIn;
}

+ (instancetype)data;

-(BOOL)returnInstagramState;
-(BOOL)returnTwitterState;
-(BOOL)returnFacebookState;
-(BOOL)returnGoogleState;
-(BOOL)returnLinkedinState;
-(void)setInstagramLogged:(BOOL *)turtle;
-(BOOL)returnAllOff;

@end
