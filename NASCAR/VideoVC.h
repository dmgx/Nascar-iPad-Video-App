//
//  VideoVC.h
//  NASCAR
//
//  Created by Mark Putnam on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VideoVC : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> {
    MPMoviePlayerController *myMoviePlayerController;
}

@property (nonatomic, retain) MPMoviePlayerController *myMoviePlayerController;
@property (nonatomic, retain) UIPopoverController *myPopoverController;
@property (nonatomic, retain) IBOutlet UIView *myContainerView;
@property (nonatomic, retain) IBOutlet UIToolbar *myPortraitViewToolbar;
@property (nonatomic, retain) IBOutlet UIImageView *myHeaderIV;
@property (nonatomic, retain) IBOutlet UIView *myVideoView;
@property (nonatomic, retain) IBOutlet UIView *mySubContainerView;
@property (nonatomic, retain) IBOutlet UITextView *myHeadlineTV;
@property (nonatomic, retain) IBOutlet UITextView *myTextTV;

- (void)prepareAndPlayMovie:(NSURL *)myMovieURL;
- (void)refreshHeaderBanner;

@end
