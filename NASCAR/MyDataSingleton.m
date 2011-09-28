//
//  MyDataSingleton.m
//  Build111
//
//  Created by Mark Putnam on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyDataSingleton.h"
#import "Conveniences.h"
#import "FetchDataPackage.h"

@implementation MyDataSingleton

@synthesize myHeaderImageFilename;
@synthesize myHeaderImage;
@synthesize myArrayOfVideoObjects;

static MyDataSingleton *mySharedDataSingleton = nil;

// Get the shared instance and create it if necessary.
+ (MyDataSingleton *)sharedDataSingleton
{
    if (mySharedDataSingleton == nil) {
        mySharedDataSingleton = [[super allocWithZone:NULL] init];
    }
    return mySharedDataSingleton;
}

// this is called ONCE when the singleton is first created
- (id)init
{
    // init the array immediately so it is available
    myArrayOfVideoObjects = [[NSMutableArray alloc] init];
    return self;
}

// We don't want to allocate a new instance, so return the current one.
+ (id)allocWithZone:(NSZone*)zone {
    return [[self sharedDataSingleton] retain];
}

// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

// Once again - do nothing, as we don't have a retain counter for this object.
- (id)retain {
    return self;
}

// Replace the retain counter so we can never release this object.
- (NSUInteger)retainCount {
    return NSUIntegerMax;
}

// This function is empty, as we don't want to let the user release this object.
- (void)release {
    
}

//Do nothing, other than return the shared instance - as this is expected from autorelease.
- (id)autorelease {
    return self;
}


# pragma mark - my methods

// this is a method I made to let me clear the singleton if I need to
-(void) reset
{
    myHeaderImage = nil;
    myArrayOfVideoObjects = nil;
}

@end
