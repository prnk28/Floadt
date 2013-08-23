//
//  SettingsController2.h
//  ADVFlatUI
//
//  Created by Tope on 05/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Imports.h"
#import "AwesomeMenu.h"

@interface SettingsController2 : UIViewController  <UITableViewDataSource, UITableViewDelegate,AwesomeMenuDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AFOAuth1Client *twitterClient;

@end
