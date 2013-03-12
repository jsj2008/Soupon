//
//  SPFirstViewController.h
//  Soupon
//
//  Created by rjxy rjxy on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagePhotosView.h"
#import "SPAdsData.h"
#import "SPCityData.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"

@interface SPFirstViewController : UIViewController <PagePhotosDataSource,NSXMLParserDelegate,SDWebImageManagerDelegate,UITableViewDataSource,UITableViewDelegate>
{
	SDWebImageManager *manager;
	UIBarButtonItem *leftItem;
}
@property (strong ,nonatomic) UITableView *tabelView;
@property (nonatomic ,retain) SPAdsData *adsData;
@property (nonatomic ,retain) SPCityData *cityData;
@property (nonatomic, retain) NSMutableArray *adsArray;
@property (nonatomic, retain) NSMutableArray *cityArray;
@property (nonatomic, retain) NSMutableArray *citys;
@end
