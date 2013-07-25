//
//  AppDelegate.h
//  Floadt
//
//  Created by Pradyumn Nukala on 3/25/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KiipSDK/KiipSDK.h>
#import "AwesomeMenu.h"
#import "AFOAuth1Client.h"
#import "AFJSONRequestOperation.h"
#import "Imports.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,KiipDelegate, AwesomeMenuDelegate>{
    


}

@property (strong, nonatomic) UIWindow *window;

@end
