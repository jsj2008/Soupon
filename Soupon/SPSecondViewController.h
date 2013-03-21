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
#import "SPShowInfoViewController.h"
#import "FPPopoverController.h"
#import "SPAroundInfo.h"

@interface SPSecondViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,FPPopoverControllerDelegate>{
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

- (IBAction)clicked:(id)sender;
@end
