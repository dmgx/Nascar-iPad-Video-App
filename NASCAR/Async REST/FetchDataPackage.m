//
//  FetchDataPackage.m
//  NSACAR
//
//  Created by Mark Putnam on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FetchDataPackage.h"
#import "MyDataSingleton.h"
#import "XMLParser.h"

@implementation FetchDataPackage

@synthesize myXMLparser;

// Called once at the end of the request
- (void)connectionDidFinishLoading:(NSURLConnection *)conn {
    
    // parse and save the fetched data in MyDataSingleton
    myXMLparser = [[XMLParser alloc] parseSourceData:myData intoObject:[MyDataSingleton sharedDataSingleton]];
    
    // call the controller to let it know that the download is complete
    if ([controller respondsToSelector:@selector(dataReceived)]) {
		[controller performSelector:@selector(dataReceived)];
	}
	// turn off the network indicator
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end