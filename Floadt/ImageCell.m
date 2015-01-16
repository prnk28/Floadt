//
//  ImageCell.m
//  Floadt
//
//  Created by Pradyumn Nukala on 1/11/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.imageView = [UIImageView new];
    
    [self addSubview:self.imageView];
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

@end
