//
//  Conveniences.m
//  DVChargeCapture
//
//  Created by Mark Putnam on 7/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Conveniences.h"


@implementation NSObject (Conveniences)

// this method returns an object from the Prefs.plist for whichKey
- (id)fetchPListObject:(NSString *)whichPList forKey:(NSString *)whichKey
{
    // get an object for key from Prefs.plist
    NSString *pathToBundle = [[NSBundle mainBundle] bundlePath];
    NSString *pathToPlist = [pathToBundle stringByAppendingPathComponent:whichPList];
    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:pathToPlist];
    return [plistDictionary objectForKey:whichKey];
}


// this method returns a full name all cleaned up
- (NSString *)compileFullName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName
{
    NSString *compiledString;
    compiledString = lastName ? lastName : @"";
    compiledString = middleName ? [NSString stringWithFormat:@"%@ %@", middleName, compiledString] : compiledString;
    compiledString = firstName ? [NSString stringWithFormat:@"%@ %@", firstName, compiledString] : compiledString;
    
    return compiledString;
}

// this method returns a short name all cleaned up
- (NSString *)compileBriefName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName
{
    NSString *compiledString;
    compiledString = lastName ? lastName : @"";
    compiledString = firstName ? [NSString stringWithFormat:@"%@. %@", [firstName substringToIndex:1], compiledString] : compiledString;
    
    return compiledString;
}

@end
