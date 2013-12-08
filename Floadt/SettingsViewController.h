//
//  SettingsViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 3/31/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "Data.h"


@interface SettingsViewController : UIViewController <RRCircularMenuDelegate> {
    RRCircularMenu *menu;
}

@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;


@end
