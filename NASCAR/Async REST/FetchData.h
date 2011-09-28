#import <Foundation/Foundation.h>

@interface FetchData : NSObject {
	NSMutableData *myData; // The data being received from the REST service
    id controller; // the controlling object to call once the download is complete
}

@property (nonatomic, retain) id controller;

- (void)getDataFrom:(NSURL *)theUrl forController:(id)controllingObject;

@end