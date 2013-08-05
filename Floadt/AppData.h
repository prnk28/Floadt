//
//  AppData.h
//  Floadt
//
//  Created by Pradyumn Nukala on 8/4/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import <foundation/Foundation.h>

@interface AppData : NSObject {
    BOOL *instagramActive;
    BOOL *twitterActive;
}

@property (nonatomic, assign) BOOL *instagramActive;
@property (nonatomic, assign) BOOL *twitterActive;

+ (id)sharedManager;

@end