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

@interface SPThirdViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
	UIBarButtonItem *rightItem;
	NSArray *aroundArray;
	HJObjManager* objMan;
}
@property (strong ,nonatomic) PullToRefreshTableView *tabelView;
@property (nonatomic ,retain) SPAroundInfo *cityData;
@end
