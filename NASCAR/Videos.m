//
//  Videos.m
//  NASCAR
//
//  Created by Mark Putnam on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Videos.h"

@implementation Videos

@synthesize myId;
@synthesize myTitle;
@synthesize mySubtitle;
@synthesize myHeadline;
@synthesize myText;
@synthesize myDuration;
@synthesize myThumbnailFilename;
@synthesize myThumbnailImage;
@synthesize myVideoFilename;

- (void)dealloc
{
    [myId release];
    [myTitle release];
    [mySubtitle release];
    [myHeadline release];
    [myText release];
    [myDuration release];
    [myThumbnailFilename release];
    [myThumbnailImage release];
    [myVideoFilename release];
    [super dealloc];
}

@end
