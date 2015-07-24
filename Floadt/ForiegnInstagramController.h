//
//  ForiegnInstagramController.h
//  Floadt
//
//  Created by Pradyumn Nukala on 5/27/15.
//  Copyright (c) 2015 Floadt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Data.h"
#import "JGActionSheet.h"

@interface ForiegnInstagramController : UIViewController <JGActionSheetDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) id instagramData;
@property (strong, nonatomic) InstagramUser *instaUser;
@property (strong, nonatomic) id idValue;
@property BOOL *entersFromSearch;
@property (nonatomic, strong) NSMutableDictionary *instagramResponse;
@property (strong, nonatomic) NSMutableArray *instaPics;

@end
