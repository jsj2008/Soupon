//
//  SPSecondViewController.h
//  Soupon
//
//  Created by rjxy rjxy on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJObjManager.h"
#import "HJManagedImageV.h"
#import "PullToRefreshTableView.h"
#import "SPCityData.h"
@interface SPSecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
	UIBarButtonItem *rightItem;
	
	HJObjManager* objMan;
	NSArray *searchArray;
	NSArray *brandArray;
	NSArray *categoryhArray;
	NSArray *districtArray;
	
}
@property (strong ,nonatomic) PullToRefreshTableView *tabelView;
@property (nonatomic ,retain) SPCityData *cityData;

@end
