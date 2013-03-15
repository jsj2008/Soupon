//
//  SPThirdViewController.h
//  Soupon
//
//  Created by rjxy rjxy on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCommon.h"
#import "SPAroundInfo.h"
#import "HJObjManager.h"
#import "HJManagedImageV.h"
#import "PullToRefreshTableView.h"
#import "SPCell.h"
#import<CoreLocation/CoreLocation.h>

@interface SPThirdViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>{
	UIBarButtonItem *rightItem;
	NSArray *aroundArray;
	HJObjManager* objMan;
	CLLocationManager *locManager;
	NSString *lon;
	NSString *lat;
}
@property (strong ,nonatomic) PullToRefreshTableView *tabelView;
@property (nonatomic ,retain) SPAroundInfo *cityData;
@end
