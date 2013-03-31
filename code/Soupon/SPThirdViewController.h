//
//  SPThirdViewController.h
//  Soupon
//
//  Created by Yuan on 13-3-11.
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
#import "ASIHTTPRequest.h"


@interface SPThirdViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>{
	UIBarButtonItem *rightItem;
	NSArray *aroundArray;
	HJObjManager* objMan;
	CLLocationManager *locManager;
	NSString *lon;
	NSString *lat;
	SPAroundInfo *h;
	NSString *locURLString;
}
@property (strong ,nonatomic) PullToRefreshTableView *tabelView;
@property (nonatomic ,retain) SPAroundInfo *cityData;

@property (retain, nonatomic) IBOutlet UIView *alertView;
@property (retain, nonatomic) IBOutlet UILabel *storeName;
@property (retain, nonatomic) IBOutlet UIButton *attentionButton;
@property (retain, nonatomic) IBOutlet UIButton *favorableButton;
@property (retain, nonatomic) IBOutlet UIButton *cancelButton;

- (IBAction)hide:(id)sender;
- (IBAction)attention:(id)sender;
- (IBAction)favorable:(id)sender;


@end
