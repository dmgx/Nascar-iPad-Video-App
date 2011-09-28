//
//  Videos.h
//  NASCAR
//
//  Created by Mark Putnam on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Videos : NSObject {
    NSString *myId;
    NSString *myTitle;
    NSString *mySubtitle;
    NSString *myHeadline;
    NSString *myText;
    NSString *myDuration;
    NSString *myThumbnailFilename;
    UIImage *myThumbnailImage;
    NSString *myVideoFilename;
}

@property (nonatomic, retain) NSString *myId;
@property (nonatomic, retain) NSString *myTitle;
@property (nonatomic, retain) NSString *mySubtitle;
@property (nonatomic, retain) NSString *myHeadline;
@property (nonatomic, retain) NSString *myText;
@property (nonatomic, retain) NSString *myDuration;
@property (nonatomic, retain) NSString *myThumbnailFilename;
@property (nonatomic, retain) UIImage *myThumbnailImage;
@property (nonatomic, retain) NSString *myVideoFilename;

@end
