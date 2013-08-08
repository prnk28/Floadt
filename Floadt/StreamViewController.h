//
//  StreamViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 3/26/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "Imports.h"
#import "AFOAuth1Client.h"
#import "AFJSONRequestOperation.h"
#import <UIKit/UIKit.h>

@interface StreamViewController : UIViewController {

    
}
@property (readwrite,assign) int screenWidth;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UIButton *google;
@property (weak, nonatomic) IBOutlet UIButton *facebook;
@property (weak, nonatomic) IBOutlet UIButton *instagram;
@property (weak, nonatomic) IBOutlet UIButton *twitter;
@property (weak, nonatomic) IBOutlet UIButton *linkedin;



//Actions for AccessoryView
- (IBAction)cameraDown:(id)sender;
- (IBAction)googleDown:(id)sender;
- (IBAction)facebookDown:(id)sender;
- (IBAction)instagramDown:(id)sender;
- (IBAction)twitterDown:(id)sender;
- (IBAction)linkedinDown:(id)sender;


@end
