//
//  StreamViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/26/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//
#define INSTAGRAM_CLIENT_ID @"88b3fb2cd93c4aacb053b44b35b86187"
#import "Lockbox.h"
#import "StreamViewController.h"
#import "InstagramClient.h"
#import "ImageCell.h"
#import "InstagramClient.h"
#import "ImageCell.h"
#import "YIPopupTextView.h"

@interface StreamViewController () <UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableDictionary *timelineResponse;
@property (nonatomic, strong) NSMutableArray *photosArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation StreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIImage *patternImage = [UIImage imageNamed:@"bgNoise"];
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    
    [self refreshInstagram];
    
    self.photosArray = [NSMutableArray new];
    
    //Refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(startRefresh:)
             forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refreshControl];
    
    //Instigate Navigation Bar Buttons
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
    
    //Reload by default
    [self.collectionView reloadData];
}

- (void)showPostView {
    
    UIView *accessoryView=[[[NSBundle mainBundle] loadNibNamed:@"AccessoryView" owner:self options:nil] lastObject];
    
    YIPopupTextView* popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"input here" maxCount:1000];
       popupTextView.caretShiftGestureEnabled = NO;   // default = NO
    popupTextView.inputAccessoryView = accessoryView;
    popupTextView.keyboardAppearance = UIKeyboardAppearanceDefault;
    [popupTextView showInView:self.view];

    
}

//Global refresh Instagram Method
- (void)refreshInstagram {

    [[InstagramClient sharedClient] getPath:@"users/self/feed"
                                 parameters:nil
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      //  NSLog(@"Response: %@",
                                      //  responseObject);
                                        
                                        self.timelineResponse = [responseObject mutableCopy];
                                        [self.photosArray addObjectsFromArray:responseObject[@"data"]];
                                        [self.collectionView reloadData];
                                        
                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        NSLog(@"Failure: %@", error);
                                    }];
    
}

- (void)nextInstagramPage:(NSIndexPath *)indexPath{
    NSDictionary *page = self.timelineResponse[@"pagination"];
    NSString *nextPage = page[@"next_url"];
    [SVProgressHUD showWithStatus:@"Getting Stuff..."];
    
    [[InstagramClient sharedClient] getPath:[NSString stringWithFormat:@"%@",nextPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        self.timelineResponse = [responseObject mutableCopy];
        [self.timelineResponse addEntriesFromDictionary:responseObject];
        [self.photosArray addObjectsFromArray:responseObject[@"data"]];
        [self.collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
    }];
    
    [SVProgressHUD dismiss];
    
}

- (NSMutableArray *)entries {
    return self.photosArray;
}

- (NSArray *)pages {
    return self.timelineResponse[@"pagination"];
}

- (NSURL *)imageUrlForEntryAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *entry = [self entries][indexPath.row];
    NSString *imageUrlString = entry[@"images"][@"standard_resolution"][@"url"];
    return [NSURL URLWithString:imageUrlString];
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //int y = arc4random() % 200+50;
    

    return CGSizeMake(150, 150);

    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *entry = [self entries][indexPath.row];
    NSDictionary *text = [self entries][indexPath.row];
    NSString *user = entry[@"user"][@"full_name"];
    NSString *caption = text[@"caption"][@"text"];
    
    if (![user isEqual:[NSNull null]] && ![caption isEqual:[NSNull null]]){
        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:user message:caption];
        [modal show];
    }else{
        NSLog(@"Fuck");
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y == roundf(scrollView.contentSize.height-scrollView.frame.size.height)) {
        NSLog(@"we are at the endddd");
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self nextInstagramPage:indexPath];
            

    }
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [[self entries] count];

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageCell *cell = (ImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell"
                                                                             forIndexPath:indexPath];
    NSURL *url = [self imageUrlForEntryAtIndexPath:indexPath];
    NSLog(@"%@", url);
    [cell.imageView setImageWithURL:url];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - NavigationBarButtons

- (void)didTapBarButton:(id)sender {
    
    [self.sidePanelController showLeftPanelAnimated:YES];
    
}

- (void)startRefresh:(UIRefreshControl *)sender {
    [self refreshInstagram];
    [sender endRefreshing];

}

-(void)didTapPostButton:(id)sender {
    
    [self showPostView];
    
}

- (IBAction)cameraDown:(id)sender {
    NSLog(@"Camera Down");
}

- (IBAction)googleDown:(id)sender {
    //UIImage *newImage = [UIImage imageNamed:@"G+H"];
    //[_google setBackgroundImage:newImage forState:UIControlStateNormal];
    
    

}

- (IBAction)facebookDown:(id)sender {
}

- (IBAction)instagramDown:(id)sender {
}

- (IBAction)twitterDown:(id)sender {
}

- (IBAction)linkedinDown:(id)sender {
}
@end

