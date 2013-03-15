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
#import "HJObjManager.h"
#import "HJManagedImageV.h"
#import "PullToRefreshTableView.h"
#import "FPPopoverController.h"

@interface SPFirstViewController : UIViewController <PagePhotosDataSource,NSXMLParserDelegate,SDWebImageManagerDelegate,UITableViewDataSource,UITableViewDelegate,FPPopoverControllerDelegate>
{
	SDWebImageManager *manager;
	UIBarButtonItem *leftItem;
	NSArray *hotArray;
	NSArray *adsArray;
	NSArray *cityArray;
	HJObjManager* objMan;
	PagePhotosView *pagePhotosView;
	FPPopoverController *popover;
}
@property (strong ,nonatomic) PullToRefreshTableView *tabelView;
@property (nonatomic ,retain) SPAdsData *adsData;
@property (nonatomic ,retain) SPCityData *cityData;

@property (nonatomic, retain) NSMutableArray *citys;

- (IBAction)leftItemClicked:(id)sender;
@end
