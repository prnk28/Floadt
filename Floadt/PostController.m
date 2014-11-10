//
//  PostController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 11/8/14.
//  Copyright (c) 2014 Floadt. All rights reserved.
//

#import "PostController.h"

@implementation PostController

bool *twitterActive;
bool *instagramActive;
bool *facebookActive;
bool *pictureSupplied;

-(void)viewWillAppear:(BOOL)animated{
    [_textView becomeFirstResponder];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:(5/255.0) green:(134/255.0) blue:(147/255.0) alpha:1.00f]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpUI{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL *instagramActive = [user boolForKey:@"InstagramActive"];
    BOOL *twitterActive = [user boolForKey:@"TwitterActive"];
    
    
    // InputView
    [_camera setTitle:@"" forState:UIControlStateNormal];
    [_camera setBackgroundImage:[UIImage imageNamed:@"Camera.png"] forState:UIControlStateNormal];
    
    [_facebook setTitle:@"" forState:UIControlStateNormal];
    [_facebook setBackgroundImage:[UIImage imageNamed:@"Facebook.png"] forState:UIControlStateNormal];
    
    _textCount.text = [NSString stringWithFormat:@"%lu", (unsigned long)_textView.text.length];
    
    if (instagramActive) {
        [_instagram setTitle:@"" forState:UIControlStateNormal];
        [_instagram setBackgroundImage:[UIImage imageNamed:@"Instagram.png"] forState:UIControlStateNormal];
    }else{
        [_instagram setTitle:@"" forState:UIControlStateNormal];
        [_instagram setBackgroundImage:[UIImage imageNamed:@"InstagramInactive.png"] forState:UIControlStateNormal];
    }
    
    if (twitterActive) {
        [_twitter setTitle:@"" forState:UIControlStateNormal];
        [_twitter setBackgroundImage:[UIImage imageNamed:@"Twitter.png"] forState:UIControlStateNormal];
    }else{
        [_twitter setTitle:@"" forState:UIControlStateNormal];
        [_twitter setBackgroundImage:[UIImage imageNamed:@"TwitterInactive.png"] forState:UIControlStateNormal];
    }
    
    
    // Navigation Bar
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [closeButton setTitle:@"" forState:UIControlStateNormal];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(didTapCloseButton:) forControlEvents:UIControlEventTouchUpInside];
    closeButton.frame = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    UIBarButtonItem *closeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    
    self.navigationItem.leftBarButtonItem = closeButtonItem;
    
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [postButton setTitle:@"" forState:UIControlStateNormal];
    [postButton setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [postButton addTarget:self action:@selector(didTapPostButton:) forControlEvents:UIControlEventTouchUpInside];
    postButton.frame = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    UIBarButtonItem *postButtonItem = [[UIBarButtonItem alloc] initWithCustomView:postButton];
    
    self.navigationItem.rightBarButtonItem = postButtonItem;
    
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"AeroviasBrasilNF" size:30.0], NSFontAttributeName, nil]];
}

- (void)didTapPostButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapCloseButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cameraDown:(id)sender {
}

- (IBAction)facebookDown:(id)sender {
}

- (IBAction)instagramDown:(id)sender {
}

- (IBAction)twitterDown:(id)sender {
}

- (void)postToTwitter:(NSString*)text{
    
    NSDictionary *parameters = @{
                                 @"status" : @"hello"
                                 };
    
    [self.twitterClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self.twitterClient postPath:@"statuses/update.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"tweet sent");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        
    }];
}

@end
