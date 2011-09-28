//
//  Conveniences.h
//  DVChargeCapture
//
//  Created by Mark Putnam on 7/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (Conveniences)

- (id)fetchPListObject:(NSString *)whichPList forKey:(NSString *)whichKey;

- (NSString *)compileFullName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName;
- (NSString *)compileBriefName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName;

@end
