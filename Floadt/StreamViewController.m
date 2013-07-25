//
//  StreamViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/26/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//
#define INSTAGRAM_CLIENT_ID @"88b3fb2cd93c4aacb053b44b35b86187"


#import "StreamViewController.h"
#import "InstagramClient.h"
#import "ImageCell.h"
#import "CredentialStore.h"
#import "InstagramClient.h"
#import "ImageCell.h"

@interface StreamViewController ()
@property (nonatomic, strong) NSDictionary *timelineResponse;
@property (nonatomic, strong) CredentialStore *credentialStore;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation StreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView = _collectionView;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
  //  [self.collectionView registerClass:[ImageCell class]
   //         forCellWithReuseIdentifier:@"imageCell"];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgNoise.png"]];
    
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [barButton setTitle:@"" forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"barButton.png"] forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"barButton_s.png"] forState:UIControlStateHighlighted];
    [barButton addTarget:self action:@selector(didTapBarButton:) forControlEvents:UIControlEventTouchUpInside];
    barButton.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    self.navBar.leftBarButtonItem = barButtonItem;
    
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [postButton setTitle:@"" forState:UIControlStateNormal];
    [postButton setBackgroundImage:[UIImage imageNamed:@"pen_usIMG.png"] forState:UIControlStateNormal];
    [postButton setBackgroundImage:[UIImage imageNamed:@"pen_sIMG.png"] forState:UIControlStateHighlighted];
    [postButton addTarget:self action:@selector(didTapPostButton:) forControlEvents:UIControlEventTouchUpInside];
    postButton.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    UIBarButtonItem *postButtonItem = [[UIBarButtonItem alloc] initWithCustomView:postButton];
    
    self.navBar.rightBarButtonItem = postButtonItem;
    
    [self.collectionView reloadData];

}

-(void)didTapPostButton:(id)sender {
    [[InstagramClient sharedClient] getPath:@"users/self/feed"
                                 parameters:nil
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        NSLog(@"Response: %@", responseObject);
                                        self.timelineResponse = responseObject;
                                        [self.collectionView reloadData];
                                        
                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        NSLog(@"Failure: %@", error);
                                    }];
    
}

- (NSArray *)entries {
    return self.timelineResponse[@"data"];
}

- (NSURL *)imageUrlForEntryAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *entry = [self entries][indexPath.row];
    NSString *imageUrlString = entry[@"images"][@"low_resolution"][@"url"];
    return [NSURL URLWithString:imageUrlString];
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int y = arc4random() % 200+50;
    
    return CGSizeMake(150, y);
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self entries] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCell *cell = (ImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell"
                                                                             forIndexPath:indexPath];
    NSURL *url = [self imageUrlForEntryAtIndexPath:indexPath];
    NSLog(@"%@", url);
    [cell.imageView setImageWithURL:url];
    cell.backgroundColor = [UIColor blackColor];
    
    return cell;
}



- (void)didTapBarButton:(id)sender {
    
    [self.sidePanelController showLeftPanelAnimated:YES];
    
}
         
@end

