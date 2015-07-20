//
//  InstagramLikeButton.h
//  Floadt
//
//  Created by Pradyumn Nukala on 6/21/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface InstagramLikeButton : UIButton {
    
    NSString *objectID;
    int likesCount;
    
}

@property (nonatomic, readwrite, retain) NSString* objectID;
@property int likesCount;

-(void)increaseLikeCount:(InstagramLikeButton *)sender;

@end
