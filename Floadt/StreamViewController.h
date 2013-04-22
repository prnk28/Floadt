//
//  StreamViewController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 3/26/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "Imports.h"
#import <SEMasonryView/SEMasonryView.h>

@interface StreamViewController : UIViewController <SEMasonryViewDelegate> {
        UIBarButtonItem *reloadButton;
        
}

@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (readwrite,assign) int screenWidth;
@property (nonatomic, strong) SEMasonryView *masonryView;
@property (nonatomic, strong) NSMutableArray *photos;


@end
