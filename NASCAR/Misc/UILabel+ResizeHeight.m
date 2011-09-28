//
//  UILabel+ResizeHeight.m
//  SCDirectory
//
//  Created by Mark Putnam on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UILabel+ResizeHeight.h"


@implementation UILabel (UILabel_ResizeHeight)

// this method adjusts the UILabel's height to optimal
- (void)resizeHeight {
    self.numberOfLines = 0;
    CGSize constraintSize = CGSizeMake(self.frame.size.width, MAXFLOAT);
    CGSize myLabelSize = [self.text sizeWithFont:self.font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, myLabelSize.height);
}

@end
