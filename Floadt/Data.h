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
#import "Reachability.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "FacebookTableViewController.h"
#import "FacebookCell.h"
#import "InstagramTableViewController.h"
#import "TwitterTableViewController.h"
#import "SCFacebook.h"
#import "MCSwipeTableViewCell.h"
#import "TimelineContainerViewController.h"
#import "TimelineControllerViewController.h"
#import "RRCustomScrollView.h"
#import "RRMessageModel.h"
#import "RRSendMessageViewController.h"
#import "XLButtonBarPagerTabStripViewController.h"
#import "JNKeychain.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "SDImageCache.h"
#import "InstagramCell.h"
#import "UICollectionViewCellPhoto.h"
#import "ImageCell.h"
#import <AVFoundation/AVFoundation.h>
#import "SDWebImage/UIImageView+WebCache.h"
#import "SDWebImageCompat.h"
#import "SDWebImageDecoder.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageDownloaderOperation.h"
#import "SDWebImageManager.h"
#import "SDWebImageOperation.h"
#import "SDWebImagePrefetcher.h" 
#import "InstaPicDetailViewController.h"
#import "RRCustomScrollView.h"
#import "AFHTTPClient.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"
#import "UIColor+JSFlatButton.h"
#import "UIImage+JSFlatButton.h"
#import "JASidePanelController.h"
#import "JSFlatButton.h"
#import "UIImage+JSFlatButton.h"
#import "InstagramResultsCell.h"
#import "MenuViewController.h"
#import "RootMenuController.h"
#import "GHContextMenuView.h"
#import "TwitterCell.h"
#import "UIViewController+JASidePanel.h"
#import "ProfileViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "AFHTTPRequestOperation.h"
#import "AFOAuth1Client.h"
#import "AFOAuth2Client.h"
#import "WebViewVC.h"
#import "MYBlurIntroductionView.h"
#import "MYIntroductionPanel.h"
#import "TweetDetailViewController.h"
#import "Canvas.h"
#import "InstagramClient.h"
#import "SettingsViewController.h"
#import "SettingsViewController.h"
#import "MenuViewController.h"

@interface Data : NSObject

+ (instancetype)sharedClient;

@property (strong, nonatomic) id instagramPics;

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;


@end
