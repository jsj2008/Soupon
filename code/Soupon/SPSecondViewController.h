//
//  SPSecondViewController.h
//  Soupon
//
//  Created by Yuan on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//  第二个页面，包括优惠信息列表，根据条件进行搜索实现

#import <UIKit/UIKit.h>
#import "HJObjManager.h"
#import "HJManagedImageV.h"
#import "PullToRefreshTableView.h"
#import "SPCityData.h"
#import "SPShowInfoViewController.h"
#import "FPPopoverController.h"
#import "SPAroundInfo.h"
#import "ASIHTTPRequest.h"

@interface SPSecondViewController : UIViewController<UISearchBarDelegate ,UITableViewDataSource,UITableViewDelegate,FPPopoverControllerDelegate>{
	UIBarButtonItem *rightItem;
	
	HJObjManager* objMan;
	NSArray *searchArray;
	NSArray *brandArray;
	NSArray *categoryhArray;
	NSArray *districtArray;
	SPShowInfoViewController *con;
	FPPopoverController *popover;
}
@property (retain, nonatomic) IBOutlet UIButton *classifyButton;
@property (retain, nonatomic) IBOutlet UIButton *brandButton;
@property (retain, nonatomic) IBOutlet UIButton *businessButton;
@property (strong ,nonatomic) PullToRefreshTableView *tabelView;
@property (nonatomic ,retain) SPCityData *cityData;
@property(retain) NSMutableArray *tableData;

- (IBAction)clicked:(id)sender;
- (void)searchBar:(UISearchBar *)searchBar activate:(BOOL) active;
@end
