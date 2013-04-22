//
//  BarViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 3/26/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <KiipSDK/KiipSDK.h>
#import "JSFlatButton.h"
#import "JASidePanelController.h"

@interface BarViewController : UIViewController


@property (weak, nonatomic) IBOutlet JSFlatButton *b1;
@property (weak, nonatomic) IBOutlet JSFlatButton *b2;
@property (weak, nonatomic) IBOutlet JSFlatButton *b3;
@property (weak, nonatomic) IBOutlet JSFlatButton *b4;
@property (weak, nonatomic) IBOutlet JSFlatButton *b5;
@property (weak, nonatomic) IBOutlet JSFlatButton *b6;

- (IBAction)td1:(id)sender;
- (IBAction)td2:(id)sender;
- (IBAction)td3:(id)sender;
- (IBAction)td4:(id)sender;
- (IBAction)td5:(id)sender;
- (IBAction)td6:(id)sender;



@end
