//
//  RootVC.h
//  NASCAR
//
//  Created by Mark Putnam on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoVC;

@interface RootVC : UITableViewController {
    UITableViewCell *myTableViewCell;
}

@property (nonatomic, retain) IBOutlet VideoVC *myVideoVC;
@property (nonatomic, retain) IBOutlet UITableViewCell *myTableViewCell;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)refreshMenuOfVideos;

@end
