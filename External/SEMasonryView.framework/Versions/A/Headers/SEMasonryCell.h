//
//  SEMasonryCell.h
//  MasonryViewDemo
//
//  Created by Sarp Erdag on 3/30/12.
//  Copyright (c) 2012 Apperto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DictionaryHelper.h"
#import "UIImageView+SENetworking.h"

@interface SEMasonryCell : UIView {
    IBOutlet UILabel *titleLabel;
    IBOutlet UIImageView *imageView;
}

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *imageURL;
@property BOOL horizontalModeEnabled;
@property CGFloat imageHeight;
@property CGFloat imageWidth;

- (void) updateCellInfo:(NSDictionary *)data;

@end
