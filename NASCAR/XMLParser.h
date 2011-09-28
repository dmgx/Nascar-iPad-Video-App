#import <UIKit/UIKit.h>

@class MyDataSingleton;
@class Videos;

@interface XMLParser : NSObject <NSXMLParserDelegate> {
    NSData *mySourceData;
    MyDataSingleton *myDataObject; // instance of our model object
    NSMutableString *currentElementValue;
    
    Videos *aVideosObject;
}

@property (nonatomic, retain) NSData *mySourceData;
@property (nonatomic, retain) MyDataSingleton *myDataObject;
@property (nonatomic, retain) NSMutableString *currentElementValue;

@property (nonatomic, retain) Videos *aVideosObject;

- (id)parseSourceData:(NSData *)sourceDataObject intoObject:(MyDataSingleton *)aDataStorageObject;
- (BOOL)parse;

@end