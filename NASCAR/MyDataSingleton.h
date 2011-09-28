//
//  MyDataSingleton.h
//  Build111
//
//  Created by Mark Putnam on 6/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDataSingleton : NSObject {
    NSString *myHeaderImageFilename;
    UIImage *myHeaderImage;
    NSMutableArray *myArrayOfVideoObjects; // must be mutable to allow sorting
}

@property (nonatomic, retain) NSString *myHeaderImageFilename;
@property (nonatomic, retain) UIImage *myHeaderImage;
@property (nonatomic, retain) NSMutableArray *myArrayOfVideoObjects;

+ (id)sharedDataSingleton;
- (void)reset;

@end
