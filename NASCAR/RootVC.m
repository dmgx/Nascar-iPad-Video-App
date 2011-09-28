//
//  RootVC.m
//  NASCAR
//
//  Created by Mark Putnam on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootVC.h"
#import "VideoVC.h"
#import "VideoTVCell.h"
#import "NSData+Base64.h"
#import "MyDataSingleton.h"
#import "Videos.h"
#import "Conveniences.h"

@implementation RootVC
		
@synthesize myVideoVC;
@synthesize myTableViewCell;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 735.0);
    self.tableView.backgroundColor = [UIColor darkGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

		
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[MyDataSingleton sharedDataSingleton] myArrayOfVideoObjects] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 245;
}

		
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"VideoTVCell" owner:self options:nil];
        cell = myTableViewCell;
        self.myTableViewCell = nil;
    }

    // configure the cell
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Videos *aVideosObject = [[[MyDataSingleton sharedDataSingleton] myArrayOfVideoObjects] objectAtIndex:indexPath.row];

    // get the remote thumbnail image
    UIImageView *thumbnailImageView = (UIImageView *)[cell viewWithTag:1];
    thumbnailImageView.image = aVideosObject.myThumbnailImage;

    UILabel *titleLabel = (UILabel *)[cell viewWithTag:2];
    titleLabel.text = aVideosObject.myTitle;
    titleLabel.highlightedTextColor = [UIColor blackColor];
    UILabel *subtitleLabel = (UILabel *)[cell viewWithTag:3];
    subtitleLabel.text = aVideosObject.mySubtitle;
    subtitleLabel.highlightedTextColor = [UIColor blackColor];
    
    UILabel *durationLabel = (UILabel *)[cell viewWithTag:4];
    int durationInSeconds = [aVideosObject.myDuration intValue];
    int minutes = durationInSeconds / 60;
    int remainingSeconds = durationInSeconds % 60;
    durationLabel.text = [NSString stringWithFormat:@"%i:%02i", minutes, remainingSeconds];
    durationLabel.highlightedTextColor = [UIColor blackColor];
    
    // set the background color for the "selected" state
    UIView *aView = [[[UIView alloc] init] autorelease];
    aView.backgroundColor = [UIColor lightGrayColor];
    cell.selectedBackgroundView = aView;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Videos *aVideosObject = [[[MyDataSingleton sharedDataSingleton] myArrayOfVideoObjects] objectAtIndex:indexPath.row];
    
    myVideoVC.myHeadlineTV.text = aVideosObject.myHeadline;
    myVideoVC.myTextTV.text = aVideosObject.myText;
    
    [myVideoVC prepareAndPlayMovie:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSString fetchPListObject:@"NASCAR-Prefs.plist" forKey:@"pathToVideos"], aVideosObject.myVideoFilename]]];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [myTableViewCell release];
    [myVideoVC release];
    [super dealloc];
}

# pragma mark - my methods

- (void)refreshMenuOfVideos
{
    [self.tableView reloadData];
}

@end
