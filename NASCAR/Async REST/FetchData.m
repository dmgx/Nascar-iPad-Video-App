#import "FetchData.h"

@implementation FetchData

@synthesize controller;

- (id) init {
    self = [super init];
    // myData gets initialized below
    return self;
}

// my method to call
- (void)getDataFrom:(NSURL *)theUrl forController:(id)controllingObject {
	// save the controller to call back
	self.controller = controllingObject;
	// show the network activity indicator
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	// build the request
	NSURLRequest *myRequest = [NSURLRequest requestWithURL:theUrl 
										 cachePolicy:NSURLRequestReloadIgnoringCacheData 
									 timeoutInterval:30.0];
	// start the async request
	[NSURLConnection connectionWithRequest:myRequest delegate:self];
	return;
}

# pragma mark NSURLConnection delegate methods

//  Received at the start of the response from the server. This may get called multiple times in certain redirect scenerios.
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
		NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
		int status = [httpResponse statusCode];
		if (!((status >= 200) && (status < 300))) {
			NSLog(@"Connection failed with status %@ (while fetching data)", status);
			[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		}
        else {
            // make the working space for the REST data buffer.
			[myData release];
			myData = [[NSMutableData alloc] initWithCapacity:1024];
		}
	}
}

// Can be called multiple times with chunks of the transfer
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [myData appendData:data];
}

// Called once at the end of the request
- (void)connectionDidFinishLoading:(NSURLConnection *)conn {

//	// do a little debug dump
//	NSString *theReceivedData = [[NSString alloc] initWithData:myData encoding:NSUTF8StringEncoding];
//	NSLog(@"Received data: %@", theReceivedData);
//	[theReceivedData release];
//
//	// call the controller to let it know that the download is complete
//    if ([controller respondsToSelector:@selector(foundPersonsDataReceived)]) {
//		[controller performSelector:@selector(foundPersonsDataReceived)];
//	}
//	// turn off the network indicator
//	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

// Something bad happened before the response started
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"Connection failed (fetching data)");
    // call the controller to let it know that the download is complete
    if ([controller respondsToSelector:@selector(errorWhileFetchingData)]) {
        [controller performSelector:@selector(errorWhileFetchingData)];
    }
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void) dealloc {
    [myData release];
	[controller release];
	[super dealloc];
}
@end
