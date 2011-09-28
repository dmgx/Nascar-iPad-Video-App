//
//  VideoTVCell.h
//  NASCAR
//
//  Created by Mark Putnam on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VideoTVCell : UITableViewCell {
    IBOutlet UIImageView *myThumbnailIV;
    IBOutlet UILabel *myTitleLabel;
    IBOutlet UILabel *mySubtitleLabel;
    IBOutlet UILabel *myDurationLabel;
}

@property (nonatomic, retain) UIImageView *myThumbnailIV;
@property (nonatomic, retain) UILabel *myTitleLabel;
@property (nonatomic, retain) UILabel *mySubtitleLabel;
@property (nonatomic, retain) UILabel *myDurationLabel;

@end
