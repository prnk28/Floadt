//
//  StreamViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/26/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "StreamViewController.h"
#import "DLIDEKeyboardView.h"
#import "RNBlurModalView.h"
#import "WTStatusBar.h"
#import <Twitter/Twitter.h>
#import "PSCollectionViewCell.h"


@interface StreamViewController ()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) PSCollectionView *collectionView;

@end


@implementation StreamViewController

- (void)viewDidLoad
{
    [self fetchTweets];
    [self makeInterface];
    
}

//Setup Stuff
-(void)makeInterface{
    
    UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [settingsButton setTitle:@"" forState:UIControlStateNormal];
    [settingsButton setBackgroundImage:[UIImage imageNamed:@"pen_usIMG.png"] forState:UIControlStateNormal];
    [settingsButton setBackgroundImage:[UIImage imageNamed:@"pen_sIMG.png"] forState:UIControlStateHighlighted];
    [settingsButton addTarget:self action:@selector(didTapSettingsButton:) forControlEvents:UIControlEventTouchUpInside];
    settingsButton.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    UIBarButtonItem *settingsButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    
    self.navBar.rightBarButtonItem = settingsButtonItem;
    
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [barButton setTitle:@"" forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"barButton.png"] forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"barButton_s.png"] forState:UIControlStateHighlighted];
    [barButton addTarget:self action:@selector(didTapBarButton:) forControlEvents:UIControlEventTouchUpInside];
    barButton.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    self.navBar.leftBarButtonItem = barButtonItem;
    
    self.collectionView = [[PSCollectionView alloc] initWithFrame:CGRectZero];
    self.collectionView.collectionViewDelegate = self;
    self.collectionView.collectionViewDataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.autoresizingMask = ~UIViewAutoresizingNone;
    
    if (isDeviceIPad()) {
        self.collectionView.numColsPortrait = 3;
        self.collectionView.numColsLandscape = 4;
    } else {
        self.collectionView.numColsPortrait = 1;
        self.collectionView.numColsLandscape = 2;
    }
    
}

- (void)setTextStatusProgress2
{
    [WTStatusBar setStatusText:@"Hey...." animated:YES];
    _progress = 0;
    [WTStatusBar setProgressBarColor:[UIColor redColor]];
    [self performSelector:@selector(setTextStatusProgress3) withObject:nil afterDelay:0.1];
}

- (void)setTextStatusProgress3
{
    if (_progress < 1.0)
    {
        _progress += 0.1;
        [WTStatusBar setProgress:_progress animated:YES];
        [self performSelector:@selector(setTextStatusProgress3) withObject:nil afterDelay:0.1];
    }
    else
    {
        [WTStatusBar setStatusText:@"Guess what..." animated:YES];
        _progress = 0;
        [WTStatusBar setProgressBarColor:[UIColor yellowColor]];
        [self performSelector:@selector(setTextStatusProgress4) withObject:nil afterDelay:0.3];
    }
}

- (void)setTextStatusProgress4
{
    if (_progress < 1.0)
    {
        _progress += 0.3;
        [WTStatusBar setProgress:_progress animated:YES];
        [self performSelector:@selector(setTextStatusProgress4) withObject:nil afterDelay:0.3];
    }
    else
    {
        [WTStatusBar setStatusText:@"It Works!" timeout:0.5 animated:YES];
    }
}

- (void)fetchTweets
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString: @"https://api.twitter.com/1/statuses/public_timeline.json"]];
        
        NSError* error;
        
        tweets = [NSJSONSerialization JSONObjectWithData:data
                                                 options:kNilOptions
                                                   error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    });
}

- (void)didTapSettingsButton:(id)sender {

    
    NSLog(@"Tapped");

}


- (void)didTapBarButton:(id)sender {
    
    [self.sidePanelController showLeftPanelAnimated:YES];
    
}


- (Class)collectionView:(PSCollectionView *)collectionView cellClassForRowAtIndex:(NSInteger)index {
    return [PSCollectionViewCell class];
}

- (NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView {
    return tweets.count;
}

- (UIView *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index {
    
    return @"hello";
}

- (CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index {
    return 10.0;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

