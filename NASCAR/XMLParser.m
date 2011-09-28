#import "XMLParser.h"
#import "MyDataSingleton.h"
#import "Videos.h"
#import "Conveniences.h"

@implementation XMLParser

@synthesize mySourceData;
@synthesize myDataObject;
@synthesize currentElementValue;
@synthesize aVideosObject;

// Sets the dataObject property to a dataObject object passed in from the calling script
- (id)parseSourceData:(NSData *)sourceDataObject intoObject:(MyDataSingleton *)aDataStorageObject
{
    if (self == [super init]) {
        mySourceData = sourceDataObject;
        myDataObject = aDataStorageObject;
        [self parse];
    }
    return self;
}

// Make sure objects are released
-(void)dealloc
{
    [aVideosObject release];
    [currentElementValue release];
    [myDataObject release];
    [mySourceData release];
    [super dealloc];
}

#pragma mark NSXMLParser Delegate Calls

// This method gets called every time NSXMLParser encounters a new element
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
        namespaceURI:(NSString *)namespaceURI
        qualifiedName:(NSString *)qualifiedName
        attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"video"]){
        // initialize a VideoObjectsClass object
        aVideosObject = [[Videos alloc] init];
    }
}

// This method gets called for every character NSXMLParser finds.
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if(!currentElementValue)
        currentElementValue = [[NSMutableString alloc] initWithString:[string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]];
	else
        [currentElementValue appendString:[string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

// This method is called whenever NSXMLParser reaches the end of an element
-(void)parser:(NSXMLParser *)parser
        didEndElement:(NSString *)elementName
        namespaceURI:(NSString *)namespaceURI
        qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"data"]) {
        // If we encounter the "data" element here, we are finished. Just return.
        return;
    }
    else {
        // set myDataObject.myHeaderImageFilename 
        if([elementName isEqualToString:@"header_image_filename"]) {
            myDataObject.myHeaderImageFilename = currentElementValue;
            
            // go ahead and fetch the image data
            NSData *myImagedata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSString fetchPListObject:@"NASCAR-Prefs.plist" forKey:@"pathToHeaderBanners"], currentElementValue]]];
            myDataObject.myHeaderImage = [[UIImage alloc] initWithData:myImagedata];
        }
        // if we are in the middle of a video
        else if(aVideosObject) {
            if([elementName isEqualToString:@"id"]) {
                aVideosObject.myId = currentElementValue;
            }
            else if([elementName isEqualToString:@"title"]) {
                aVideosObject.myTitle = currentElementValue;
            }
            else if([elementName isEqualToString:@"subtitle"]) {
                aVideosObject.mySubtitle = currentElementValue;
            }
            else if([elementName isEqualToString:@"headline"]) {
                aVideosObject.myHeadline = currentElementValue;
            }
            else if([elementName isEqualToString:@"text"]) {
                aVideosObject.myText = currentElementValue;
            }
            else if([elementName isEqualToString:@"duration"]) {
                aVideosObject.myDuration = currentElementValue;
            }
            else if([elementName isEqualToString:@"thumbnail_filename"]) {
                aVideosObject.myThumbnailFilename = currentElementValue;
                
                // go ahead and fetch the image data
                NSData *myImagedata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [NSString fetchPListObject:@"NASCAR-Prefs.plist" forKey:@"pathToThumbnails"], currentElementValue]]];
                aVideosObject.myThumbnailImage = [[UIImage alloc] initWithData:myImagedata];
            }
            else if([elementName isEqualToString:@"video_filename"]) {
                aVideosObject.myVideoFilename = currentElementValue;
            }
            else if([elementName isEqualToString:@"video"]) {
                // add aVideosObject to myArrayOfVideoObjects in myDataObject
                [myDataObject.myArrayOfVideoObjects addObject:aVideosObject];
                [aVideosObject release];
                aVideosObject = nil;
            }
        }
    }
    
    [currentElementValue release];
    currentElementValue = nil;
}

// start the parse
- (BOOL)parse
{
    // read the data to parse
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:mySourceData];
    
    // tell NSXMLParser that this class is its delegate
    [parser setDelegate:self];
    
    // kick off file parsing
    [parser parse];
    
    // clean up
    [parser setDelegate:nil];
    [parser release];
    return YES;
}

@end
