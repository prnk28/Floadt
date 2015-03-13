//
//  TweetDetailViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 11/11/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//
#import "Data.h"
#import <UIKit/UIKit.h>

@interface TweetDetailViewController : UIViewController {


}
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;
@property (strong, nonatomic) IBOutlet UILabel *tweetLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *PictureView;
@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) id detailItem;
@property NSInteger numberOfUrls;
@property NSString *url;
@property NSInteger numberOfHashtags;
@property NSString *hashtag;
@property NSInteger numberOfMentions;
@property NSString *mentions;
@property NSInteger numberOfMedia;
@property NSString *media;

@end
