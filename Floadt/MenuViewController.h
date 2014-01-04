//
//  MenuViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 10/20/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//
#import "Data.h"
#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController
@property (strong, nonatomic) IBOutlet JSFlatButton *b1;
@property (strong, nonatomic) IBOutlet JSFlatButton *b2;
@property (strong, nonatomic) IBOutlet JSFlatButton *b3;
@property (strong, nonatomic) IBOutlet JSFlatButton *b4;
@property (strong, nonatomic) IBOutlet JSFlatButton *b5;
@property (strong, nonatomic) IBOutlet JSFlatButton *b6;

- (IBAction)td1:(id)sender;
- (IBAction)td2:(id)sender;
- (IBAction)td3:(id)sender;
- (IBAction)td4:(id)sender;
- (IBAction)td5:(id)sender;
- (IBAction)td6:(id)sender;


@end
