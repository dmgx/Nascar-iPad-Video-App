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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(interfaceOrientation == UIDeviceOrientationPortrait){
        theSplashIV.image = [UIImage imageNamed:@"Default-Portrait~ipad.png"];
    }
    else{
        theSplashIV.image = [UIImage imageNamed:@"Default-Landscape~ipad.png"];
    }

	return YES;
}

@end
