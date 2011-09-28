//
//  SplashVC.m
//  NASCAR
//
//  Created by Mark Putnam on 9/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SplashVC.h"

@implementation SplashVC

@synthesize theSplashIV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [theSplashIV release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([[UIApplication sharedApplication] statusBarOrientation] == UIDeviceOrientationPortrait){
        NSLog(@"Portrait");
        theSplashIV.image = [UIImage imageNamed:@"Default-Portrait~ipad.png"];
    }
    else{
        NSLog(@"Landscape");
        theSplashIV.image = [UIImage imageNamed:@"Default-Landscape~ipad.png"];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
