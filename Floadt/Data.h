//
//  Data.h
//  Floadt
//
//  Created by Pradyumn Nukala on 10/9/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "UIPlaceholderTextView.h"
#import "Masonry.h"
#import "Reachability.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "InstagramTableViewController.h"
#import "TwitterTableViewController.h"
#import "InstagramUser.h"
#import "HMSegmentedControl.h"
#import "TimelineContainerViewController.h"
#import "Floadt-Swift.h"
#import "TimelineControllerViewController.h"
#import "RRCustomScrollView.h"
#import "RRMessageModel.h"
#import "RRSendMessageViewController.h"
#import "XLButtonBarPagerTabStripViewController.h"
#import "MBTwitterScroll.h"
#import "JNKeychain.h"
#import "ForeignTwitterController.h"
#import "ForiegnInstagramController.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "SDImageCache.h"
#import "InstagramCell.h"
#import "UICollectionViewCellPhoto.h"
#import <AVFoundation/AVFoundation.h>
#import "SDWebImage/UIImageView+WebCache.h"
#import "SDWebImageCompat.h"
#import "MessageTableViewCell.h"
#import "MessageTextView.h"
#import "MessageViewController.h"
#import "SDWebImageDecoder.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageDownloaderOperation.h"
#import "MBProgressHUD.h"
#import "SDWebImageManager.h"
#import "MXSegmentedPager+ParallaxHeader.h"
#import "SDWebImageOperation.h"
#import "SDWebImagePrefetcher.h" 
#import "RRCustomScrollView.h"
#import "AFHTTPClient.h"
#import "TwitterClient.h"
#import "LGPlusButtonsView.h"
#import "LGPlusButton.h"
#import "UIImageView+AFNetworking.h"
#import "UIColor+JSFlatButton.h"
#import "UIImage+JSFlatButton.h"
#import "JASidePanelController.h"
#import "JSFlatButton.h"
#import "UIImage+JSFlatButton.h"
#import "InstagramResultsCell.h"
#import "MenuViewController.h"
#import "STTweetLabel.h"
#import "RootMenuController.h"
#import "TwitterCell.h"
#import "UIViewController+JASidePanel.h"
#import "ProfileViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "AFHTTPRequestOperation.h"
#import "AFOAuth1Client.h"
#import "AFOAuth2Client.h"
#import "InstagramClient.h"
#import "SettingsViewController.h"
#import "SettingsViewController.h"
#import "MenuViewController.h"

@interface Data : NSObject

+ (instancetype)sharedClient;

@property (strong, nonatomic) id instagramPics;

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;


@end
