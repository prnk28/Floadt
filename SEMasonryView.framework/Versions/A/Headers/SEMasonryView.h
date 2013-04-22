//
//  SEMasonryView.h
//  MasonryViewDemo
//
//  Created by Sarp Erdag on 3/28/12.
//  Copyright (c) 2012 Apperto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"
#import "MessageInterceptor.h"
#import "SpinnerView.h"
#import "DictionaryHelper.h"

@protocol SEMasonryViewDelegate <UIScrollViewDelegate>
@optional

- (void) didSelectItemAtIndex:(int)index;
- (void) didEnterLoadingMode;

@end


@interface SEMasonryView : UIScrollView{
    MessageInterceptor * delegate_interceptor;
    SpinnerView *spinner;
    UILabel *spinnerLabel;
    BOOL loading;
    BOOL loadMoreEnabled;
    BOOL horizontalModeEnabled;
    NSInteger *columnHeights;
    NSInteger *rowWidths;
    int numberOfColumns;
    int numberOfRows;
    int lastVisibleItemIndex;
    int columnWidth;
    int rowHeight;
    BOOL readyToLoadWhenReleased;
    id <SEMasonryViewDelegate> delegate;
    UIView *headerView;
    UIView *contentView;
}

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSMutableArray *items;
@property int columnWidth;
@property int rowHeight;
@property BOOL loading;
@property BOOL loadMoreEnabled;
@property BOOL horizontalModeEnabled;
@property (nonatomic , unsafe_unretained) id <SEMasonryViewDelegate> delegate;

- (void) layoutCells;
- (void) clearCells;
- (void) addCell:(UIView *)cell;

@end



