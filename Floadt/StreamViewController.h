//
//  StreamViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 3/26/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
#import <KiipSDK/KiipSDK.h>
#import <Parse/Parse.h>

@interface StreamViewController : UIViewController{
        CGFloat _progress;
}

@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;


@end
