//
//  VideoVC.m
//  NASCAR
//
//  Created by Mark Putnam on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VideoVC.h"
#import "MyDataSingleton.h"
#import "Conveniences.h"

@implementation VideoVC

@synthesize myMoviePlayerController;
@synthesize myPopoverController;
@synthesize myContainerView;
@synthesize myPortraitViewToolbar;
@synthesize myHeaderIV;
@synthesize myVideoView;
@synthesize mySubContainerView;
@synthesize myHeadlineTV;
@synthesize myTextTV;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
    
	// Release any retained subviews of the main view.
	self.myPopoverController = nil;
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [myMoviePlayerController release];
    [myPopoverController release];
    [myContainerView release];
    [myPortraitViewToolbar release];
    [myHeaderIV release];
    [myVideoView release];
    [mySubContainerView release];
    [myHeadlineTV release];
    [myTextTV release];
    
    // remove all movie notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [super dealloc];
}

#pragma mark - Split view support

// called when the view is in portrait orientation
- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController: (UIPopoverController *)popoverController
{
    barButtonItem.title = @"Videos";
    NSMutableArray *items = [[self.myPortraitViewToolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [self.myPortraitViewToolbar setItems:items animated:YES];
    [items release];
    self.myPopoverController = popoverController;
    
    myPortraitViewToolbar.hidden = NO;
    myContainerView.frame = CGRectMake(0, 44, 768, 980);
    
    // adjust the video frame if it is running
    myMoviePlayerController.view.frame = CGRectMake(0, 0, myVideoView.frame.size.width, myVideoView.frame.size.height);
}

// called when the view is in the split view (landscape), invalidating the button and popover controller.
- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // remove button items from the portraitViewToolbar
    NSMutableArray *items = [[self.myPortraitViewToolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [self.myPortraitViewToolbar setItems:items animated:YES];
    [items release];
    self.myPopoverController = nil;
    
    myPortraitViewToolbar.hidden = YES;
    myContainerView.frame = CGRectMake(0, 0, 704, 768);
    
    // adjust the video frame if it is running
    myMoviePlayerController.view.frame = CGRectMake(0, 0, myVideoView.frame.size.width, myVideoView.frame.size.height);
}

#pragma mark - video support

- (void)prepareAndPlayMovie:(NSURL *)myMovieURL
{
    // dismiss the popover if it is showing
    if (self.myPopoverController != nil) {
        [self.myPopoverController dismissPopoverAnimated:YES];
    }
    
    myMoviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:myMovieURL];
    myMoviePlayerController.view.frame = CGRectMake(0, 0, myVideoView.frame.size.width, myVideoView.frame.size.height);
    [myVideoView addSubview:myMoviePlayerController.view];
    
    if ([myMoviePlayerController respondsToSelector:@selector(loadState)]) 
    {
        // May help to reduce latency
		[myMoviePlayerController prepareToPlay];
        
		// Register that the load state changed (movie is ready)
		[[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(moviePlayerLoadStateChanged:) 
                                                     name:MPMoviePlayerLoadStateDidChangeNotification 
                                                   object:nil];
	}  
    else
    {
        // Register to receive a notification when the movie is in memory and ready to play.
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(moviePreloadDidFinish:) 
                                                     name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification 
                                                   object:nil];
    }
    
    // Register to receive a notification when the movie has finished playing. 
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(moviePlayBackDidFinish:) 
                                                 name:MPMoviePlayerPlaybackDidFinishNotification 
                                               object:nil];
}

- (void) moviePlayerLoadStateChanged:(NSNotification*)notification 
{
    // Unless state is unknown, start playback
	if ([myMoviePlayerController loadState] != MPMovieLoadStateUnknown)
    {
        // Remove observer
        [[NSNotificationCenter 	defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
        
        NSLog(@"starting playback");
        
        // Play the movie
		[myMoviePlayerController play];
	}
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification 
{    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
 	// Remove observer
    [[NSNotificationCenter 	defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    // get rid of the myMoviePlayerController
    myMoviePlayerController = nil;
}

# pragma mark - my methods

- (void)refreshHeaderBanner
{
    // only replace the default header banner if there was myImageData
    if([[MyDataSingleton sharedDataSingleton] myHeaderImage]) myHeaderIV.image = [[MyDataSingleton sharedDataSingleton] myHeaderImage];
}

@end
