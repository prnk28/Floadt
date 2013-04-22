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
#import <Twitter/Twitter.h>
#import "PSCollectionView.h"

@interface StreamViewController : UIViewController <PSCollectionViewDelegate, PSCollectionViewDataSource> {
      NSArray *tweets;
        CGFloat _progress;
        
}

@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;



@end
