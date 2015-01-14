//
//  AddSocialPanel.h
//  Floadt
//
//  Created by Pradyumn Nukala on 12/14/14.
//  Copyright (c) 2014 Floadt. All rights reserved.
//

#import "MYIntroductionPanel.h"
#import "Data.h"

@interface AddSocialPanel : MYIntroductionPanel <UITextViewDelegate> {
    
    __weak IBOutlet UIView *CongratulationsView;
}


- (IBAction)didPressEnable:(id)sender;

@end
