//
//  StreamViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/26/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "StreamViewController.h"
#import "MGScrollView.h"
#import "MGTableBoxStyled.h"
#import "MGLineStyled.h"
#import "DLIDEKeyboardView.h"
#import "RNBlurModalView.h"
#import "WTStatusBar.h"


@interface StreamViewController ()

@end

MGLine *box;
MGBox *grid;

@implementation StreamViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"classy_fabric.png"]]];
 
    
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
    
    
    // ********************************---MGBOX---*******************************************************
    
    
    
     MGScrollView *scroller = [MGScrollView scrollerWithSize:CGSizeMake(320, 500)];
     scroller.origin = CGPointMake(0,44);
     [self.view addSubview:scroller];
     
     
     MGTableBoxStyled *section = MGTableBoxStyled.box;
     [scroller.boxes addObject:section];
     
     
     grid = [MGBox boxWithSize:[[UIScreen mainScreen] bounds].size];
     grid.contentLayoutMode = MGLayoutGridStyle;
     [scroller.boxes addObject:grid];
     
     for (int i = 0; i < 30; i++) {
         
         if(i%3){
     box = [MGLine lineWithSize:(CGSize){145, 175}];
     box.borderColors = UIColor.whiteColor;
     box.leftMargin = 10;
     box.topMargin = 10;
     box.textColor = [UIColor whiteColor];
     box.middleItems = (id)@"Post.";
     box.onTap = ^{
     NSLog(@"Tapped Box");
     };
     box.onLongPress = ^{
             
         NSLog(@"Let Go!");
         [WTStatusBar setStatusText:@"Hold On a Second..." animated:YES];
         [self performSelector:@selector(setTextStatusProgress2) withObject:nil afterDelay:0.5];
         
    };
     
     [grid.boxes addObject:box];
     }
     else if(i%3==1){
         
         MGLine *box2 = [MGLine lineWithSize:(CGSize){145, 120}];
         box2.borderColors = UIColor.whiteColor;
         box2.leftMargin = 10;
         box2.topMargin = 10;
         box2.textColor = [UIColor whiteColor];
         box2.middleItems = (id)@"Post.";

         box2.onTap = ^{
             NSLog(@"Tapped Box");
         };
         box2.onLongPress = ^{
             
             NSLog(@"Let Go!");
             
         };
         
              [grid.boxes addObject:box2];
         
     }
     else{
         
         MGLine *box3 = [MGLine lineWithSize:(CGSize){145, 60}];
         box3.borderColors = UIColor.whiteColor;
         box3.leftMargin = 10;
         box3.topMargin = 10;
         box3.textColor = [UIColor whiteColor];
         box3.middleItems = (id)@"Post.";

         box3.onTap = ^{
             NSLog(@"Tapped Box");
             
         };
         box3.onLongPress = ^{
             
             NSLog(@"Let Go!");
             
         };
         
         [grid.boxes addObject:box3];
         
     }
     
     
     [grid layoutWithSpeed:0.3 completion:nil];
     [scroller layoutWithSpeed:0.3 completion:nil];
     [scroller scrollToView:grid withMargin:10];
    
         
     }
}

    // ********************************---END MGBOX---*******************************************************

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

- (void)didTapSettingsButton:(id)sender {

    
    RNBlurModalView *modal;
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, 300, 240)];
        [DLIDEKeyboardView attachToTextView:textView];
        
        [textView setText:@"Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit,Bunch of Bullshit. "];
    
        [textView setTextColor:[UIColor whiteColor]];
        [self.view addSubview:textView];
    
        textView.backgroundColor = [UIColor darkGrayColor];
        textView.layer.cornerRadius = 5.f;
        textView.layer.borderColor = [UIColor blackColor].CGColor;
        textView.layer.borderWidth = 5.f;
    
              [DLIDEKeyboardView attachToTextView:textView];
        [textView becomeFirstResponder];
        
        modal = [[RNBlurModalView alloc] initWithView:textView];
    
    [modal show];

}

- (void)didTapBarButton:(id)sender {
    
    [self.sidePanelController showLeftPanelAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

