//
//  FavoriteLabel.m
//  Floadt
//
//  Created by Pradyumn Nukala on 8/19/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import "FavoriteLabel.h"

@implementation FavoriteLabel

-(id)init {
    self = [super init];
    if (self) {
        self.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        self.textColor = [UIColor grayColor];
    }
    return self;
}

- (void)select {
    selected = YES;
    if (selected) {
        self.textColor = [UIColor colorWithRed:0.949 green:0.624 blue:0.220 alpha:1.000];
    }else{
        [self deselect];
    }
}

- (void)deselect {
    selected = NO;
    self.textColor = [UIColor colorWithWhite:0.655 alpha:1.000];
}

@end
