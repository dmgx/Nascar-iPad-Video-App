//
//  VideoTVCell.m
//  NASCAR
//
//  Created by Mark Putnam on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VideoTVCell.h"


@implementation VideoTVCell

@synthesize myThumbnailIV;
@synthesize myTitleLabel;
@synthesize mySubtitleLabel;
@synthesize myDurationLabel;

- (void)dealloc
{
    [myThumbnailIV release];
    [myTitleLabel release];
    [mySubtitleLabel release];
    [myDurationLabel release];
    [super dealloc];
}

@end
