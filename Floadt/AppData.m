//
//  AppData.h
//  Floadt
//
//  Created by Pradyumn Nukala on 8/4/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "AppData.h"

@implementation AppData

@synthesize instagramActive;
@synthesize twitterActive;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static AppData *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        instagramActive = nil;
        twitterActive = nil;
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end