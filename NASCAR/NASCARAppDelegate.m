//
//  NASCARAppDelegate.m
//  NASCAR
//
//  Created by Mark Putnam on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NASCARAppDelegate.h"
#import "RootVC.h"
#import "VideoVC.h"
#import "Conveniences.h"
#import "FetchDataPackage.h"
#import "Reachability.h"
#import "MBProgressHUD.h"

@implementation NASCARAppDelegate

@synthesize window = _window;
@synthesize mySplitVC = _mySplitVC;
@synthesize myRootVC = _myRootVC;
@synthesize myVideoVC = _myVideoVC;
@synthesize theSplashVC = _theSplashVC;
@synthesize theSplashIV = _theSplashIV;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    Reachability *myReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [myReachability currentReachabilityStatus];
    if (internetStatus == NotReachable){
        // show an alert
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"No Internet Connection" message:@"This app requires a valid internet connection via WiFi or cellular network." delegate:self cancelButtonTitle:@"Quit" otherButtonTitles:nil];
        [myAlert setTag:1];
        [myAlert show];
        [myAlert release];
    }

    // begin an async request for data from thr remote XML source
    NSURL *dataPackageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?timestamp=%lf", [NSString fetchPListObject:@"NASCAR-Prefs.plist" forKey:@"pathToDataPackage"], [[NSDate date] timeIntervalSince1970]]];
    FetchDataPackage *FetchDataPackageClient = [[FetchDataPackage alloc] init];
    [FetchDataPackageClient getDataFrom:dataPackageURL forController:self];
    [FetchDataPackageClient release];
    
    // show the activity indicator
    [MBProgressHUD showHUDAddedTo:self.mySplitVC.view animated:YES];
    
    // Add the split view controller's view to the window and display.
    self.window.rootViewController = self.mySplitVC;
    [self.window makeKeyAndVisible];
    
    // add the splash IV to the window per the current orientation, then animate it away
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	if([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait){
		self.theSplashIV.image = [UIImage imageNamed:@"Default-Portrait~ipad.png"];
        self.theSplashIV.frame = CGRectMake(0, 20, 768, 1004);
	}
    else if([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown){
        self.theSplashIV.image = [UIImage imageNamed:@"Default-Portrait~ipad.png"];
        self.theSplashIV.transform = CGAffineTransformMakeRotation(M_PI);
        self.theSplashIV.frame = CGRectMake(0, 0, 768, 1004);
    }
	else if([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft){
		self.theSplashIV.image = [UIImage imageNamed:@"Default-Landscape~ipad.png"];
        self.theSplashIV.transform = CGAffineTransformMakeRotation(M_PI / 2);
        self.theSplashIV.frame = CGRectMake(0, 0, 748, 1024);
	}
    else if([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight){
		self.theSplashIV.image = [UIImage imageNamed:@"Default-Landscape~ipad.png"];
        self.theSplashIV.transform = CGAffineTransformMakeRotation(M_PI / -2);
        self.theSplashIV.frame = CGRectMake(20, 0, 748, 1024);
	}
	[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    
    [self.window addSubview:self.theSplashIV];
    
    float delayBeforeAnimation = 2.0;
    float speedOfAnimation = 0.25;
    
    [UIView animateWithDuration:speedOfAnimation
                          delay:delayBeforeAnimation
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.theSplashIV.frame = CGRectMake(
                                                             -(self.theSplashIV.frame.size.width),
                                                             -(self.theSplashIV.frame.size.height),
                                                             self.theSplashIV.frame.size.width * 3,
                                                             self.theSplashIV.frame.size.height * 3
                                                             );
                         self.theSplashIV.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [self.theSplashIV removeFromSuperview];
                         [self.theSplashIV release];
                     }];


    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

- (void)dealloc
{
    [_window release];
    [_mySplitVC release];
    [_myRootVC release];
    [_myVideoVC release];
    [_theSplashVC release];
    [_theSplashIV release];
    [super dealloc];
}

# pragma mark - my methods

// called by FetchDataPackage when the data is received
- (void)dataReceived
{
    // hide the activity indicator
    [MBProgressHUD hideHUDForView:self.mySplitVC.view animated:YES];
    
    // tell the VCs to init their data
    [self.myRootVC refreshMenuOfVideos];
    [self.myVideoVC refreshHeaderBanner];
}

#pragma mark alert delegate methods

// do this when an alert is dismissed
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if([alertView tag] == 1){ // it's the connectivity alert
        if (buttonIndex == [alertView cancelButtonIndex]) exit(0); // the "quit" button was pressed
    }
}

@end
