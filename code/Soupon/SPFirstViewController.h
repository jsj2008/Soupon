//
//  SPFirstViewController.h
//  Soupon
//
//  Created by Yuan on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//  第一个界面，包括滚动广告，热门优惠信息

#import <UIKit/UIKit.h>
#import "PagePhotosView.h"
#import "SPAdsData.h"
#import "SPCityData.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "HJObjManager.h"
#import "HJManagedImageV.h"
#import "PullToRefreshTableView.h"
#import "FPPopoverController.h"
#import "SPShowInfoViewController.h"
#import "ASIHTTPRequest.h"

@interface SPFirstViewController : UIViewController <PagePhotosDataSource,NSXMLParserDelegate,SDWebImageManagerDelegate,UITableViewDataSource,UITableViewDelegate,FPPopoverControllerDelegate,ASIHTTPRequestDelegate>
{
	SDWebImageManager *manager;
	UIBarButtonItem *leftItem;
	NSMutableArray *hotArray;
	NSArray *dataSorce;
	NSArray *adsArray;
	NSArray *cityArray;
	HJObjManager* objMan;
	PagePhotosView *pagePhotosView;
	FPPopoverController *popover;
	SPShowInfoViewController *con;
}
@property (strong ,nonatomic) PullToRefreshTableView *tabelView;
@property (nonatomic ,retain) SPAdsData *adsData;
@property (nonatomic ,retain) SPCityData *cityData;

@property (nonatomic, retain) NSMutableArray *citys;

- (IBAction)leftItemClicked:(id)sender;
@end
