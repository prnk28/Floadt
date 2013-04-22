//
//  VerticalCell.m
//  MasonryViewDemo
//
//  Created by Sarp Erdag on 3/30/12.
//  Copyright (c) 2012 Apperto. All rights reserved.
//

#import "VerticalCell.h"

@implementation VerticalCell

- (void) updateCellInfo:(NSDictionary *)data {
    
    self.text = [NSString stringWithFormat:@"%@ %@ %@", [data stringForKey:@"title"], [data stringForKey:@"title"], [data stringForKey:@"title"]];
    self.imageURL = [NSString stringWithFormat:@"http://farm%d.staticflickr.com/%@/%@_%@_q.jpg", [[data valueForKey:@"farm"] intValue], [data stringForKey:@"server"], [data stringForKey:@"id"], [data stringForKey:@"secret"]];
    
    [super updateCellInfo:data];
}

@end
