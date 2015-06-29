//
//  TwitterCell.m
//  Floadt
//
//  Created by Pradyumn Nukala on 10/23/14.
//  Copyright (c) 2014 Floadt. All rights reserved.
//

#import "TwitterCell.h"

@implementation TwitterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Create ClockImageView
        self.clockIcon = [[UIImageView alloc] initWithFrame:CGRectMake(250, 12, 15, 15)];
        self.clockIcon.image = [UIImage imageNamed:@"clock.png"];
        [self addSubview:self.clockIcon];
        self.timeAgo = [[UILabel alloc] initWithFrame:CGRectMake(275, 12, 40, 15)];
        self.timeAgo.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        self.timeAgo.textColor = [UIColor darkGrayColor];
        self.timeAgo.numberOfLines = 1;
        [self.contentView addSubview:self.timeAgo];
        [self setupView];
    }
    return self;
}
- (void)setupView {
    self.backgroundColor = [UIColor whiteColor];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Fix for contentView constraint warning
    [self.contentView setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    
    // Create ProfileImageView
    self.profilePicture = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.profilePicture.translatesAutoresizingMaskIntoConstraints = NO;
    self.profilePicture.contentMode = UIViewContentModeScaleAspectFill;
    self.profilePicture.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.profilePicture];
    
    // Name label
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.numberOfLines = 1;
    [self.contentView addSubview:self.nameLabel];
    
    // Company label
    self.companyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.companyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.companyLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    self.companyLabel.textColor = [UIColor darkGrayColor];
    self.companyLabel.numberOfLines = 1;
    [self.contentView addSubview:self.companyLabel];
    
    // Tweet label
    self.tweetLabel = [[STTweetLabel alloc] initWithFrame:CGRectZero];
    self.tweetLabel.userInteractionEnabled = YES;
    self.tweetLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.tweetLabel.numberOfLines = 0; // Must be set for multi-line label to work
    self.tweetLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.tweetLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    self.tweetLabel.textColor = [UIColor darkGrayColor];
    
    self.tweetLabel.detectionBlock = ^(STTweetHotWord hotWord, NSString *string, NSString *protocol, NSRange range) {
        
        NSArray *hotWords = @[@"Handle", @"Hashtag", @"Link"];
        _tweetLabel.text = [NSString stringWithFormat:@"%@ [%d,%d]: %@%@", hotWords[hotWord], (int)range.location, (int)range.length, string, (protocol != nil) ? [NSString stringWithFormat:@" *%@*", protocol] : @""];
    };

    [self.contentView addSubview:self.tweetLabel];
    
    // Constrain
    NSDictionary *viewDict = NSDictionaryOfVariableBindings(_profilePicture, _nameLabel, _companyLabel, _tweetLabel);
    // Create a dictionary with buffer values
    NSDictionary *metricDict = @{@"sideBuffer" : @10, @"verticalBuffer" : @10, @"imageSize" : @35, @"verticalBufferImage" : @5, @"smallerVertBuffer" : @15};
    
    
    // Constrain elements horizontally
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-sideBuffer-[_profilePicture(imageSize)]-sideBuffer-[_nameLabel]-sideBuffer-|" options:0 metrics:metricDict views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-sideBuffer-[_profilePicture(imageSize)]-sideBuffer-[_companyLabel]-sideBuffer-|" options:0 metrics:metricDict views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-sideBuffer-[_tweetLabel]-sideBuffer-|" options:0 metrics:metricDict views:viewDict]];
    
    // Constrain elements vertically
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-verticalBuffer-[_profilePicture(imageSize)]" options:0 metrics:metricDict views:viewDict]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-verticalBuffer-[_nameLabel]-verticalBuffer-[_companyLabel]" options:0 metrics:metricDict views:viewDict]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_tweetLabel]" options:0 metrics:metricDict views:viewDict]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.companyLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.profilePicture attribute:NSLayoutAttributeBottom multiplier:1 constant:5]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.tweetLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.profilePicture attribute:NSLayoutAttributeBottom multiplier:1 constant:5]];
    
    // Set hugging/compression priorites for all labels.
    // This is one of the most important aspects of having the cell size
    // itself. setContentCompressionResistancePriority needs to be set
    // for all labels to UILayoutPriorityRequired on the Vertical axis.
    // This prevents the label from shrinking to satisfy constraints and
    // will not cut off any text.
    // Setting setContentCompressionResistancePriority to UILayoutPriorityDefaultLow
    // for Horizontal axis makes sure it will shrink the width where needed.
    [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.companyLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.companyLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.tweetLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.tweetLabel
     setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    self.tweetLabel.detectionBlock = ^(STTweetHotWord hotWord, NSString *string, NSString *protocol, NSRange range) {
        
        NSArray *hotWords = @[@"Handle", @"Hashtag", @"Link"];
        if ([hotWords[hotWord]  isEqual: @"Handle"]) {
            NSLog(@"Handle: %@",string);
        }
        
        if ([hotWords[hotWord]  isEqual: @"Hashtag"]) {
            NSLog(@"Hashtag: %@",string);
        }
        
        if ([hotWords[hotWord]  isEqual: @"Link"]) {
            NSLog(@"Link: %@",string);
        }
    };
    
    // Set max layout width for all multi-line labels
    // This is required for any multi-line label. If you
    // do not set this, you'll find the auto-height will not work
    // this is because "intrinsicSize" of a label is equal to
    // the minimum size needed to fit all contents. So if you
    // do not have a max width it will not constrain the width
    // of the label when calculating height.
    CGSize defaultSize = [[self class] defaultCellSize];
    self.tweetLabel.preferredMaxLayoutWidth = defaultSize.width - ([metricDict[@"sideBuffer"] floatValue] * 2);
}

+ (CGSize)defaultCellSize {
    return (CGSize){CGRectGetWidth([[UIScreen mainScreen] bounds]), 85};
}

@end
