//
//  NASCARAppDelegate.h
//  NASCAR
//
//  Created by Mark Putnam on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootVC;
@class VideoVC;

@interface NASCARAppDelegate : NSObject <UIApplicationDelegate> {
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UISplitViewController *mySplitVC;
@property (nonatomic, retain) IBOutlet RootVC *myRootVC;
@property (nonatomic, retain) IBOutlet VideoVC *myVideoVC;
@property (nonatomic, retain) IBOutlet UIViewController *theSplashVC;
@property (nonatomic, retain) IBOutlet UIImageView *theSplashIV;

- (void)dataReceived;

@end
