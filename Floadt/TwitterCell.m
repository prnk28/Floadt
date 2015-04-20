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
        self.clockIcon = [[UIImageView alloc] initWithFrame:CGRectMake(250, 8, 15, 15)];
        self.clockIcon.image = [UIImage imageNamed:@"clock.png"];
        [self addSubview:self.clockIcon];
        
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
    self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.numberOfLines = 1;
    [self.contentView addSubview:self.nameLabel];
    
    // Company label
    self.companyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.companyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.companyLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    self.companyLabel.textColor = [UIColor blackColor];
    self.companyLabel.numberOfLines = 1;
    [self.contentView addSubview:self.companyLabel];
    
    // Tweet label
    self.tweetLabel = [[AMAttributedHighlightLabel alloc] initWithFrame:CGRectZero];
    self.tweetLabel.delegate = self;
    self.tweetLabel.userInteractionEnabled = YES;
    self.tweetLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.tweetLabel.numberOfLines = 0; // Must be set for multi-line label to work
    self.tweetLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.tweetLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    self.tweetLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:self.tweetLabel];
    
    // Constrain
    NSDictionary *viewDict = NSDictionaryOfVariableBindings(_profilePicture, _nameLabel, _companyLabel, _tweetLabel);
    // Create a dictionary with buffer values
    NSDictionary *metricDict = @{@"sideBuffer" : @10, @"verticalBuffer" : @10, @"imageSize" : @50, @"verticalBufferImage" : @5};
    
    // Constrain elements horizontally
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-sideBuffer-[_profilePicture(imageSize)]-sideBuffer-[_nameLabel]-sideBuffer-|" options:0 metrics:metricDict views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-sideBuffer-[_profilePicture(imageSize)]-sideBuffer-[_companyLabel]-sideBuffer-|" options:0 metrics:metricDict views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-sideBuffer-[_tweetLabel]-sideBuffer-|" options:0 metrics:metricDict views:viewDict]];
    
    // Constrain elements vertically
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-verticalBuffer-[_profilePicture(imageSize)]" options:0 metrics:metricDict views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-verticalBuffer-[_nameLabel]-verticalBuffer-[_companyLabel]" options:0 metrics:metricDict views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_tweetLabel]-verticalBuffer-|" options:0 metrics:metricDict views:viewDict]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.companyLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.profilePicture attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.tweetLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.profilePicture attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
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

- (void)setupCellWithData:(NSDictionary *)data {
    // Pull out sample data
    NSString *nameString = data[@"user"][@"name"];
    //NSString *companyString = data[@"sampleCompany"];
    NSString *bioString = data[@"text"];
    
    // Set values
    self.nameLabel.text = nameString;
    self.tweetLabel.text = bioString;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *imageUrl = [[data objectForKey:@"user"] objectForKey:@"profile_image_url"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.profilePicture.image = [UIImage imageWithData:data];
            CALayer *imageLayer = self.profilePicture.layer;
            [imageLayer setCornerRadius:25];
            [imageLayer setMasksToBounds:YES];
        });
    });
}

// AMAttributedHighlightLabelDelegate methods
- (void)selectedMention:(NSString *)string {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Selected" message:string delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
- (void)selectedHashtag:(NSString *)string {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Selected" message:string delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
- (void)selectedLink:(NSString *)string {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Selected" message:string delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

+ (CGSize)defaultCellSize {
    return (CGSize){CGRectGetWidth([[UIScreen mainScreen] bounds]), 85};
}

@end
