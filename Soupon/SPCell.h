//
//  SPCell.h
//  Soupon
//
//  Created by rjxy rjxy on 13-3-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPHotData.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
@interface SPCell : UITableViewCell<SDWebImageManagerDelegate>{
	UILabel *nameLabel;
	UITextView *contentTextView;
	UILabel *downNumLabel;
	UIImageView *tImageView;
	SDWebImageManager *manager;
}

- (void)setHotData:(SPHotData *)data;
@end
