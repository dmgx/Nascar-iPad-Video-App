//
//  FetchDataPackage.h
//  NASCAR
//
//  Created by Mark Putnam on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// This class extends certain methods of the FetchData class to add specific functionality

#import <Foundation/Foundation.h>
#import "FetchData.h" // import the super-class here

@class FetchData;
@class XMLParser;

@interface FetchDataPackage : FetchData {
    XMLParser *myXMLparser;
}

@property (nonatomic, retain) XMLParser *myXMLparser;

@end