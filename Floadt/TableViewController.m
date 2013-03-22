/*
 * Copyright (c) 2012, Pierre Bernard & Houdah Software s.à r.l.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the <organization> nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

#import "TableViewController.h"
#import "HHPanningTableViewCell.h"
#import "ISRefreshControl.h"
#import "KGStatusBar.h"
#import "MYIntroductionView.h"


@interface TableViewController ()

@property (nonatomic, retain) NSArray *rowTitles;

@end


@implementation TableViewController

#pragma mark -
#pragma mark Initialization


- (id)initWithStyle:(UITableViewStyle)style;
{
	self = [super initWithStyle:style];

    if (self != nil) {
		self.rowTitles = [NSArray arrayWithObjects:@"Pan direction: None", @"Pan direction: Right", @"Pan direction: Left", @"Pan direction: Both", @"Custom trigger", nil];
	}

	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{

	self = [super initWithCoder:aDecoder];

	if (self != nil) {
		self.rowTitles = [NSArray arrayWithObjects:@"Pan direction: None", @"Pan direction: Right", @"Pan direction: Left", @"Pan direction: Both", @"Custom trigger", nil];
	}

	return self;
}
 
- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    //STEP 1 Construct Panels
    MYIntroductionPanel *panel = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"SampleImage1"] description:@"Welcome to MYIntroductionView, your 100 percent customizable interface for introductions and tutorials! Simply add a few classes to your project, and you are ready to go!"];
    
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"SampleImage2"] description:@"MYIntroductionView is your ticket to a great tutorial or introduction!"];
    
    //STEP 2 Create IntroductionView
    
 
     MYIntroductionView *introductionView = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) headerImage:[UIImage imageNamed:@"SampleHeaderImage.png"] panels:@[panel, panel2] languageDirection:MYLanguageDirectionLeftToRight];
     
    
    A more customized version
    
    MYIntroductionView *introductionView = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) headerText:@"MYIntroductionView" panels:@[panel, panel2] languageDirection:MYLanguageDirectionLeftToRight];
    [introductionView setBackgroundImage:[UIImage imageNamed:@"SampleBackground"]];
    
    
    //Set delegate to self for callbacks (optional)
    introductionView.delegate = self;
    
    //STEP 3: Show introduction view
    [introductionView showInView:self.view];
    
*/
    

    [self.tableView setRowHeight:100.0f];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    
    // ****************CUSTOM INIT******************
    
    UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [settingsButton setTitle:@"" forState:UIControlStateNormal];
    [settingsButton setBackgroundImage:[UIImage imageNamed:@"settingsButton.png"] forState:UIControlStateNormal];
    [settingsButton setBackgroundImage:[UIImage imageNamed:@"settingsButton_s.png"] forState:UIControlStateHighlighted];
    [settingsButton addTarget:self action:@selector(didTapSettingsButton:) forControlEvents:UIControlEventTouchUpInside];
    settingsButton.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    UIBarButtonItem *settingsButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    
    self.navigationItem.rightBarButtonItem = settingsButtonItem;
    
    //FOR REFRESH CONTROL
    
    self.refreshControl = (id)[[ISRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
    
    //FOR MIXPANEL
    
    
    
    //******************END CUSTOM INIT***************
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

}

- (void)didTapSettingsButton:(id)sender {
}


#pragma mark -
#pragma mark Accessors

@synthesize rowTitles = _rowTitles;


#pragma mark -
#pragma mark Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
- (void)refresh
{
    
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        static BOOL flag = NO;
        if (flag) {
                [KGStatusBar showSuccessWithStatus:@"Successfully synced 1"];
            		self.rowTitles = [NSArray arrayWithObjects: @"Pan direction:None CHANGED", @"Pan direction: Right CHANGED", @"Pan direction: Left CHANGED", @"Pan direction: Both CHANGED", @"Custom trigger CHANGED", nil];
        }else {
                [KGStatusBar showSuccessWithStatus:@"Successfully synced 2"];
                    self.rowTitles = [NSArray arrayWithObjects:@"Pan direction: None ALTERED", @"Pan direction: Right ALTERED", @"Pan direction: Left ALTERED", @"Pan direction: Both ALTERED", @"Custom trigger ALTERED", nil];
        }
        flag = !flag;
        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    });
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.rowTitles count] * 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    HHPanningTableViewCell *cell = (HHPanningTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSInteger directionMask = indexPath.row % 5;

	if (cell == nil) {
		cell = [[HHPanningTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
											  reuseIdentifier:CellIdentifier];
			
		UIView *drawerView = [[UIView alloc] initWithFrame:cell.frame];
		
        // dark_dotted.png obtained from http://subtlepatterns.com/dark-dot/
        // Made by Tsvetelin Nikolov http://dribbble.com/bscsystem
		drawerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dark_dotted"]];
		
		cell.drawerView = drawerView;		
	}

    if (directionMask < 3) {
        cell.directionMask = directionMask;
    }
    else {
        cell.directionMask = HHPanningTableViewCellDirectionLeft + HHPanningTableViewCellDirectionRight;

        if (directionMask == 4) {
            cell.delegate = self;
        }
    }

	cell.textLabel.text = [self.rowTitles objectAtIndex:directionMask];

    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
	if ([cell isKindOfClass:[HHPanningTableViewCell class]]) {
		HHPanningTableViewCell *panningTableViewCell = (HHPanningTableViewCell*)cell;
		
		if ([panningTableViewCell isDrawerRevealed]) {
			return nil;
		}
	}
	
	return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self performSegueWithIdentifier:@"testLoginSeague" sender:nil];
    
}

#pragma mark -
#pragma mark HHPanningTableViewCellDelegate

- (void)panningTableViewCellDidTrigger:(HHPanningTableViewCell *)cell inDirection:(HHPanningTableViewCellDirection)direction
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Custom Action"
                                                    message:@"You triggered a custom action"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
