//
//  TweetDetailViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 11/11/13.
//  Copyright (c) 2013 Floadt. All rights reserved.
//

#import "TweetDetailViewController.h"

#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface TweetDetailViewController ()

@end

@implementation TweetDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    // Setup Back Button
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setTitle:@"" forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navItem.leftBarButtonItem = backButtonItem;
    
    if (self.detailItem) {
        NSLog(@"%@", self.detailItem);
        [self setUpLogo];
        [self detectEntitesAndOrganize];
    }
}
- (NSString*)numberWithShortcut:(NSNumber*)number
{
    unsigned long long value = [number longLongValue];
    
    NSUInteger index = 0;
    double dvalue = (double)value;
    
    NSArray *suffix = @[ @"", @"K", @"M", @"B", @"T", @"P", @"E" ];
    
    while ((value /= 1000) && ++index) dvalue /= 1000;
    
    NSString *svalue = [NSString stringWithFormat:@"%@%@",[NSNumber numberWithDouble:dvalue], [suffix objectAtIndex:index]];
    
    return svalue;
}

- (void)imageSetup {
    NSDictionary *tweet = self.detailItem;
    
    if ([[tweet objectForKey:@"entities"] objectForKey:@"media"]) {
        NSLog(@"something here");
       // NSString *picurl = tweet[@"entities"][@"media"][@"media_url"];
    } else {
        NSLog(@"nothing here");
    }
}

- (void)setUpLogo {
    NSDictionary *tweet = self.detailItem;
    
    //top view
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 150)];
    NSString *bannerURL = tweet[@"user"][@"profile_banner_url"];
    [topView sd_setImageWithURL:[NSURL URLWithString:bannerURL] placeholderImage:[UIImage imageNamed:@"user.png"]];
    [topView setBackgroundColor:RGBCOLOR(128, 26, 26)];
    
    UIImageView *circle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
    NSString *imageUrl = [[tweet objectForKey:@"user"] objectForKey:@"profile_image_url"];
    [circle sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"user.png"]];
    [circle setCenter:topView.center];
    [circle.layer setMasksToBounds:YES];
    [circle.layer setCornerRadius:30];
    [topView addSubview:circle];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, width, 20)];
    [label setText:[[tweet objectForKey:@"user"] objectForKey:@"name"]];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [topView addSubview:label];
    
    
    //masonary constraints for parallax view subviews (optional)
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (circle.mas_bottom).offset (10);
        make.centerX.equalTo (topView);
    }];
    [circle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo ([NSValue valueWithCGSize:CGSizeMake(65, 65)]);
        make.center.equalTo (topView);
    }];
    
    //create strechy parallax scroll view
    StrechyParallaxScrollView *strechy = [[StrechyParallaxScrollView alloc] initWithFrame:self.view.frame andTopView:topView];
    [self.view addSubview:strechy];
    
    //add dummy scroll view items
    float itemStartY = topView.frame.size.height + 10;
    for (int i = 1; i <= 10; i++) {
        [strechy addSubview:[self scrollViewItemWithY:itemStartY andNumber:i]];
        [strechy addSubview:[self scrollViewReplyButtonWithY:itemStartY andNumber:i]];
        [strechy addSubview:[self scrollViewFavoriteButtonWithY:itemStartY andNumber:i]];
        [strechy addSubview:[self scrollViewRetweetButtonWithY:itemStartY andNumber:i]];
        
        itemStartY += 190;
    }
    
    //set scrollable area (classic uiscrollview stuff)
    [strechy setContentSize:CGSizeMake(width, itemStartY)];
}

- (UILabel *)scrollViewItemWithY:(CGFloat)y andNumber:(int)num {
    NSDictionary *tweet = self.detailItem;
    UILabel *item = [[UILabel alloc] initWithFrame:CGRectMake(10, y, [UIScreen mainScreen].bounds.size.width-20, 180)];
    [item setBackgroundColor:[self randomColor]];
    item.lineBreakMode = NSLineBreakByWordWrapping;
    item.numberOfLines = 0;
    [item setText:[tweet objectForKey:@"text"]];
    [item setTextAlignment:NSTextAlignmentCenter];
    [item setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
    [item setTextColor:[UIColor whiteColor]];
    return item;
}

- (UIButton *)scrollViewReplyButtonWithY:(CGFloat)y andNumber:(int)num {
    UIButton *replyButton = [[UIButton alloc] initWithFrame:CGRectMake(50, y + 140, 20, 20)];
    [replyButton setBackgroundImage:[UIImage imageNamed:@"reply.png"] forState:UIControlStateNormal];
    [replyButton addTarget:self action:@selector(replyButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    return replyButton;
}

- (UIButton *)scrollViewFavoriteButtonWithY:(CGFloat)y andNumber:(int)num {
    UIButton *favoriteButton = [[UIButton alloc] initWithFrame:CGRectMake(140, y + 140, 20, 20)];
    [favoriteButton setBackgroundImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
    [favoriteButton addTarget:self action:@selector(favoriteButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    return favoriteButton;
}

- (UIButton *)scrollViewRetweetButtonWithY:(CGFloat)y andNumber:(int)num {
    UIButton *retweetButton = [[UIButton alloc] initWithFrame:CGRectMake(230, y + 140, 20, 20)];
    [retweetButton setBackgroundImage:[UIImage imageNamed:@"retweet.png"] forState:UIControlStateNormal];
    [retweetButton addTarget:self action:@selector(retweetButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    return retweetButton;
}

- (void)replyButtonEvent:(id)sender {
    NSLog(@"reply tapped");
}

- (void)favoriteButtonEvent:(id)sender {
    NSLog(@"favorite tapped");
}

- (void)retweetButtonEvent:(id)sender {
    NSLog(@"retweet tapped");
}

- (void)detectEntitesAndOrganize {
    NSDictionary *tweet = self.detailItem;
    NSMutableArray *hashtag = [[tweet objectForKey:@"entities"] objectForKey:@"hashtags"];
    NSLog(@"Number of Hashtags = %ld",hashtag.count);
    self.numberOfHashtags = hashtag.count;
    if (self.numberOfHashtags>0){
        for(NSString *strhastag in hashtag){
            NSLog(@"your strhastag = %@",strhastag); // This will return you all hastags
        }
    }
    NSMutableArray *url = [[tweet objectForKey:@"entities"] objectForKey:@"urls"];
    NSLog(@"Number of URL's = %ld",url.count);
    self.numberOfUrls = url.count;
    if (self.numberOfUrls>0){
        for(NSString *strhastag in url){
            NSLog(@"your strurl = %@",strhastag); // This will return you all hastags
        }
    }
    NSMutableArray *user_mention = [[tweet objectForKey:@"entities"] objectForKey:@"user_mentions"];
    NSLog(@"Number of User Mentions = %ld",user_mention.count);
    self.numberOfMentions = user_mention.count;
 
    NSMutableArray *media = [[tweet objectForKey:@"entities"] objectForKey:@"media"];
    NSLog(@"Number of Media = %ld",media.count);
    self.numberOfMedia = media.count;
    for(NSString *strhastag in media){
        NSLog(@"your strmedia = %@",strhastag); // This will return you all hastags
    }
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

-(void)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
