//
//  RetweetLabel.h
//  Floadt
//
//  Created by Pradyumn Nukala on 8/19/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RetweetLabel : UILabel {
    BOOL selected;
}

- (void)deselect;
- (void)select;

@end
