//
//  MenuViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 10/20/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//
#import "Data.h"
#import "PureLayout.h"
#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController
@property (strong, nonatomic)  JSFlatButton *b1;
@property (strong, nonatomic)  JSFlatButton *b2;
@property (strong, nonatomic)  JSFlatButton *b3;
@property (strong, nonatomic)  JSFlatButton *b4;
@property (strong, nonatomic)  JSFlatButton *b5;
@property (strong, nonatomic)  JSFlatButton *b6;

- (void)td1:(id)sender;
- (void)td2:(id)sender;
- (void)td4:(id)sender;
- (void)td5:(id)sender;
- (void)td6:(id)sender;


@end
