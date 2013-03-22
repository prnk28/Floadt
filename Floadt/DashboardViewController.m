//
//  DashboardViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/19/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "DashboardViewController.h"
#import "MGScrollView.h"
#import "MGTableBoxStyled.h"
#import "MGLineStyled.h"
@interface DashboardViewController ()

@end

@implementation DashboardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   
    

    MGScrollView *scroller = [MGScrollView scrollerWithSize:[[UIScreen mainScreen] bounds].size];
    [self.view addSubview:scroller];
   
    MGTableBoxStyled *section = MGTableBoxStyled.box;
    [scroller.boxes addObject:section];
    
    // a default row size
    CGSize rowSize = (CGSize){304, 40};
    
    // a header row
    MGLineStyled *header = [MGLineStyled lineWithLeft:@"My First Table" right:nil size:rowSize];
    header.leftPadding = header.rightPadding = 16;
    [section.topLines addObject:header];
    
    // a string on the left and a horse on the right
    MGLineStyled *row1 = [MGLineStyled lineWithLeft:@"Left text"
                                              right:[UIImage imageNamed:@"horse.png"] size:rowSize];
    [section.topLines addObject:row1];
    
    // a string with Mush markup
    MGLineStyled *row2 = MGLineStyled.line;
    row2.multilineLeft = @"This row has **bold** text, //italics// text, __underlined__ text, "
    "and some `monospaced` text. The text will span more than one line, and the row will "
    "automatically adjust its height to fit.|mush";
    row2.minHeight = 40;
    [section.topLines addObject:row2];

    MGTableBoxStyled *section2 = MGTableBoxStyled.box;
    [scroller.boxes addObject:section2];
    
    
    // a header row
    MGLineStyled *header2 = [MGLineStyled lineWithLeft:@"My Second Table" right:nil size:rowSize];
    header2.leftPadding = header2.rightPadding = 16;
    [section2.topLines addObject:header2];
    
    // a string on the left and a horse on the right
    MGLineStyled *row1a = [MGLineStyled lineWithLeft:@"Left text"
                                              right:[UIImage imageNamed:@"horse.png"] size:rowSize];
    [section2.topLines addObject:row1a];
    
    // a string with Mush markup
    MGLineStyled *row2a = MGLineStyled.line;
    row2a.multilineLeft = @"This row has **bold** text, //italics// text, __underlined__ text, "
    "and some `monospaced` text. The text will span more than one line, and the row will "
    "automatically adjust its height to fit.|mush";
    row2a.minHeight = 40;
    [section2.topLines addObject:row2a];

    
    [scroller layoutWithSpeed:0.3 completion:nil];
    [scroller scrollToView:section withMargin:8];
    
    
    MGBox *grid = [MGBox boxWithSize:[[UIScreen mainScreen] bounds].size];
    grid.contentLayoutMode = MGLayoutGridStyle;
    [scroller.boxes addObject:grid];
    
    for (int i = 0; i < 10; i++) {
        MGBox *box = [MGBox boxWithSize:(CGSize){100, 100}];
        
        box.borderColors = UIColor.redColor;
        box.leftMargin = box.topMargin = 10;
        [grid.boxes addObject:box];
    }

    

[grid layoutWithSpeed:0.3 completion:nil];
[scroller layoutWithSpeed:0.3 completion:nil];
[scroller scrollToView:grid withMargin:10];

}


@end
