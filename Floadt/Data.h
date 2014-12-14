//
//  Data.h
//  Floadt
//
//  Created by Pradyumn Nukala on 10/9/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "RECommonFunctions.h"
#import "REComposeBackgroundView.h"
#import "REComposeSheetView.h"
#import "REComposeViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "SDImageCache.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "SDWebImageCompat.h"
#import "SDWebImageDecoder.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageDownloaderOperation.h"
#import "SDWebImageManager.h"
#import "SDWebImageOperation.h"
#import "SDWebImagePrefetcher.h"
#import "InstaPicDetailViewController.h"
#import "AFHTTPClient.h"
#import "CNPPopupController.h"
#import "Lockbox.h"
#import "AwesomeMenu.h"
#import "UIImageView+AFNetworking.h"
#import "UIColor+JSFlatButton.h"
#import "UIImage+JSFlatButton.h"
#import "JASidePanelController.h"
#import "JSFlatButton.h"
#import "UIImage+JSFlatButton.h"
#import "InstagramResultsCell.h"
#import "AwesomeMenuItem.h"
#import "MenuViewController.h"
#import "RootMenuController.h"
#import "TwitterCell.h"
#import "WelcomeScreenViewController.h"
#import "UIViewController+JASidePanel.h"
#import "CRGradientNavigationBar.h"
#import "ProfileViewController.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"
#import "AFOAuth1Client.h"
#import "AFOAuth2Client.h"
#import "RSTwitterEngine.h"
#import "WebViewController.h"
#import "MYBlurIntroductionView.h"
#import "MYIntroductionPanel.h"
#import "TweetDetailViewController.h"
#import "InstagramClient.h"
#import "StreamViewController.h"
#import "SettingsViewController.h"
#import "WelcomeScreenViewController.h"
#import "SettingsViewController.h"
#import "MenuViewController.h"
#import "RSOAuthEngine.h"

@interface Data : NSObject

+ (instancetype)sharedClient;

@property (strong, nonatomic) id instagramPics;

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;


@end
