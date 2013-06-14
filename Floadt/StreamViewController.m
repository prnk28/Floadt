//
//  StreamViewController.m
//  Floadt
//
//  Created by Pradyumn Nukala on 3/26/13.
//  Copyright (c) 2013 Pradyumn Nukala. All rights reserved.
//

#import "StreamViewController.h"
#import <SEMasonryView/SEJSONRequestOperation.h>
#import <SEMasonryView/SEMasonryCell.h>
#import "VerticalCell.h"

@interface StreamViewController (){

}

@end

@implementation StreamViewController

@synthesize masonryView;
@synthesize photos;
@synthesize screenWidth;
@synthesize navBar;

int pageCounter = 1;

- (void) fetchData {
    
    // set your MasonryView to be in loading state
    self.masonryView.loading = YES;
    
    // disable the reload button
    reloadButton.enabled = NO;
    
    // For this demo, we load data from Flickr's API. In this case, a search with the keyword "Lego" is made and 10 results are returned in each page.
    // The call uses AFNetworking Library, can be grabbed for free from https://github.com/AFNetworking/AFNetworking
    // Of course, you can use any networking library or Apple's default libraries for this task
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=5dcaac7a6155238356c4d94244c98f2d&text=lego&per_page=20&page=%d&format=json&nojsoncallback=1", pageCounter];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    SEJSONRequestOperation *operation = [SEJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        for (NSDictionary *photo in [[JSON dictionaryForKey:@"photos"] arrayForKey:@"photo"]) {
            
            // add each of the photo object to your array, so that you can reference them on other methods
            [self.photos addObject:photo];
            
            // create a cell for each photo and add it to your MasonryView
            SEMasonryCell *cell;
            
            if (self.masonryView.horizontalModeEnabled){
                cell = [[[NSBundle mainBundle] loadNibNamed:@"HorizontalCell" owner:self options:nil] objectAtIndex: 0];
                cell.horizontalModeEnabled = YES;
                
                // randomize image widths (for demonstration purposes only)
                cell.imageWidth = 150 + arc4random() % 150;
            }
            else {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"VerticalCell" owner:self options:nil] objectAtIndex: 0];
                cell.horizontalModeEnabled = NO;
                
                // randomize image heights (for demonstration purposes only)
                cell.imageHeight = 50 + arc4random() % 150;
            }
            
            // set a tag for your cell, so that you can refer to it when there are interactions like tapping etc..
            cell.tag = [self.photos indexOfObject:photo];
            
            // set the cell's size, if you want to play with cell spacings and stuff, this is the place
            if (screenWidth % 256 == 0) { // for ipad
                if (self.masonryView.horizontalModeEnabled)
                    [cell setFrame:CGRectMake(10, 10, cell.frame.size.width + 15, 216)];
                else
                    [cell setFrame:CGRectMake(10, 10, 236, cell.frame.size.height + 15)];
            }
            else { // for iphone
                [cell setFrame:CGRectMake(10, 10, 140, cell.frame.size.height + 15)];
            }
            
            // finally, update the cell's controls with the data coming from the API
            [cell updateCellInfo:photo];
            
            // add it to your MasonryView
            [self.masonryView addCell:cell];
        }
        // you are done loading, so turn off MasonryView's loading state
        self.masonryView.loading = NO;
        reloadButton.enabled = YES;
    }
                                                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                                                            NSLog(@"error");
                                                                                            // if there has been an error, again turn of MasonryView's loading state
                                                                                            self.masonryView.loading = NO;
                                                                                            reloadButton.enabled = YES;
                                                                                        }];
    [operation start];
    
    // increase the counter so that the next time this method loads, it is gonna load the next page
    pageCounter++;
}

- (void) clearItems {
    
    // clear the cells of your MasonryView
    [self.masonryView clearCells];
    
    // re-fetch data from the API
    [self fetchData];
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    // get the screenWidth to determine the resolution
    screenWidth = (int)[[UIScreen mainScreen] applicationFrame].size.width % 256;
    
    // initialize an empty array of objects
    self.photos = [NSMutableArray array];
    
    // create a MasonryView in any size you want
    self.masonryView = [[SEMasonryView alloc] initWithFrame:CGRectMake(0, 44.5, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    // set delegate to self
    self.masonryView.delegate = self;
    
    // set a size for each column, 256px wide columns means 4 columns for landscape and 3 for portrait (4*246=1024, 3*256=768)
    if ((int)[[UIScreen mainScreen] applicationFrame].size.width % 256 == 0){
        self.masonryView.columnWidth = 256;
        
        // if you are going to use the horizontal mode, set a row height otherwise, this is not necessary
        self.masonryView.rowHeight = 230;
    }
    else {
        // if iPhone, set it to 160px
        self.masonryView.columnWidth = 160;
        self.masonryView.rowHeight = 130;
    }
    
    // enable paging
    self.masonryView.loadMoreEnabled = YES;
    
    self.masonryView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgNoise.png"]];
    
    // optional
    self.masonryView.horizontalModeEnabled = NO;
    

    // add it to your default view
    [self.view addSubview:self.masonryView];
    
    // start fetching data from a remote API
    [self fetchData];

  

    

    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [barButton setTitle:@"" forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"barButton.png"] forState:UIControlStateNormal];
    [barButton setBackgroundImage:[UIImage imageNamed:@"barButton_s.png"] forState:UIControlStateHighlighted];
    [barButton addTarget:self action:@selector(didTapBarButton:) forControlEvents:UIControlEventTouchUpInside];
    barButton.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    
    self.navBar.leftBarButtonItem = barButtonItem;
    
     UIButton *settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
      [settingsButton setTitle:@"" forState:UIControlStateNormal];
      [settingsButton setBackgroundImage:[UIImage imageNamed:@"pen_usIMG.png"] forState:UIControlStateNormal];
      [settingsButton setBackgroundImage:[UIImage imageNamed:@"pen_sIMG.png"] forState:UIControlStateHighlighted];
      [settingsButton addTarget:self action:@selector(didTapSettingsButton:) forControlEvents:UIControlEventTouchUpInside];
      settingsButton.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
     UIBarButtonItem *settingsButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
    
      self.navBar.rightBarButtonItem = settingsButtonItem;
    
    [self fetchData];

    
}

- (void)didTapBarButton:(id)sender {
    
    [self.sidePanelController showLeftPanelAnimated:YES];
    
}


- (void)didTapSettingsButton:(id)sender {
    
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    [twitter setInitialText:@""];
                        
    [self presentViewController:twitter animated:YES completion:nil];
     twitter.completionHandler = ^(TWTweetComposeViewControllerResult res) {};
     [self dismissModalViewControllerAnimated:YES];
                                                               
}


#pragma mark - SEMasonryView Delegate Methods

- (void) didEnterLoadingMode {
    
    // fetch data again if it is dragged and released in the bottom

}

- (void) didSelectItemAtIndex:(int) index {
    
    // define some actions when a cell is tapped.
    // in this case an alert with the cell's title is shown
    
    NSDictionary *photo = [self.photos objectAtIndex:index];
    
    NSString *message = [NSString stringWithFormat:@"%@", [photo stringForKey:@"title"]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tapped!" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Interface Orientation Management

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    // reorder items when there is an orientation change
    [self.masonryView layoutCells];
}



@end


