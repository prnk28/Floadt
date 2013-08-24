//
//  StreamViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/26/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//
#define INSTAGRAM_CLIENT_ID @"88b3fb2cd93c4aacb053b44b35b86187"
#import "StreamViewController.h"



@implementation StreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAccessoryViewIcons];
    
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

- (void)transitionDropDown
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"modalView"];
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:vc];
    formSheet.transitionStyle = MZFormSheetTransitionStyleDropDown;
    formSheet.shouldDismissOnBackgroundViewTap = YES;
    [formSheet presentAnimated:YES completionHandler:^(UIViewController *presentedFSViewController) {
        
    }];
    formSheet.didTapOnBackgroundViewCompletionHandler = ^(CGPoint location)
    {
        
    };
}
-(void)setAccessoryViewIcons{
    BOOL instagramLog = [[User data]returnInstagramState];
    BOOL googleLog = [[User data] returnGoogleState];
    BOOL facebookLog = [[User data] returnFacebookState];
    BOOL twitterLog = [[User data] returnTwitterState];
    BOOL linkedinLog = [[User data] returnLinkedinState];
    
    if (!instagramLog) {
        UIImage *instagramInactive = [UIImage imageNamed:@"InstagramInactive.png"];
        [self.instagram setBackgroundImage:instagramInactive forState:UIControlStateNormal];
    }
    if (!googleLog) {
        UIImage *googleInactive = [UIImage imageNamed:@"GoogleInactive.png"];
        [self.google setBackgroundImage:googleInactive forState:UIControlStateNormal];
    }
    if (!facebookLog) {
        
    }
    if (!googleLog) {
        
    }
    if (!facebookLog) {
        
    }
    if (!twitterLog) {
        
    }
    if (!linkedinLog) {
        
    }
}

-(void)displayEditorForImage:(UIImage *)imageToEdit

{
    
    AFPhotoEditorController *editorController = [[AFPhotoEditorController alloc] initWithImage:imageToEdit];
    
    [editorController setDelegate:self];
    
    [self presentViewController:editorController animated:YES completion:nil];
    
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
/*
        NSDictionary *entry = [self entries][indexPath.row];
        NSDictionary *text = [self entries][indexPath.row];
        NSString *user = entry[@"user"][@"full_name"];
        NSString *caption = text[@"caption"][@"text"];
        
        if (![user isEqual:[NSNull null]] && ![caption isEqual:[NSNull null]]){
            RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:user message:caption];
            [modal show];
        }else{
            NSLog(@"Didnt Work");
        }
*/
    [self transitionDropDown];
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
    //NSLog(@"%@", url);
    [cell.imageView setImageWithURL:url];
    cell.backgroundColor = [UIColor whiteColor];
    
   // TwitterCell *tweetCell = (TwitterCell *)[collectionView
   // dequeueReusableCellWithReuseIdentifier:@"twitterCell"
   // forIndexPath:indexPath];
    
    //if(indexPath.row % 2 == 0){
        return cell;
  //  }else{
  //      return tweetCell;
        
    //}
    
   
    
    
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

- (void)photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image

{
    NSLog(@"Image Retrieved");
    
    image = self.imageForPost;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)photoEditorCanceled:(AFPhotoEditorController *)editor

{
 
    NSLog(@"Editor Dissmissed");
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (IBAction)cameraDown:(id)sender{
    NSLog(@"Camera Down");
    
    UIImage *image = [UIImage imageNamed:@"01-refresh.png"];
    [self displayEditorForImage:image];


}

- (IBAction)googleDown:(id)sender {
  //  UIImage *newImage = [UIImage imageNamed:@"G+H"];
  //  [_google setBackgroundImage:newImage forState:UIControlStateNormal];
    NSLog(@"Google Down");
}

- (IBAction)facebookDown:(id)sender {
    NSLog(@"Facebook Down");
}

- (IBAction)instagramDown:(id)sender {
    NSLog(@"Instagram Down");
}

- (IBAction)twitterDown:(id)sender {
    NSLog(@"Twitter Down");
    [[TwitterClient sharedClient] getTimeline];
}

- (IBAction)linkedinDown:(id)sender {
    NSLog(@"LinkedIn Down");
}
@end

