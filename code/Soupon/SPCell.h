//
//  SPCell.h
//  Soupon
//
//  Created by Yuan on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//	每一行优惠信息的model类

#import <UIKit/UIKit.h>
#import "SPHotData.h"
#import "SPAroundInfo.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
@interface SPCell : UITableViewCell<SDWebImageManagerDelegate>{
	UILabel *nameLabel;
	UITextView *addressTextView;
	UITextView *contentTextView;
	UILabel *downNumLabel;
	UIImageView *tImageView;
	SDWebImageManager *manager;
}

- (void)setHotData:(SPHotData *)data;
- (void)setAroundData:(SPAroundInfo *)info;
@end
