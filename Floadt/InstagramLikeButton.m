//
//  InstagramLikeButton.m
//  Floadt
//
//  Created by Pradyumn Nukala on 6/21/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import "InstagramLikeButton.h"

@implementation InstagramLikeButton
@synthesize objectID;
@synthesize likesCount;

-(void)increaseLikeCount:(InstagramLikeButton *)sender {
    sender.likesCount += 1;
}


@end
