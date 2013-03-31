//
//  SPCollectViewController.h
//  Soupon
//
//  Created by Yuan on 13-3-19.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPShowInfoViewController.h"


@interface SPCollectViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
	NSMutableArray *dataSource_;
	int coun;
	NSDictionary *data1;
	
}
@property (nonatomic,retain) NSMutableArray *dataSource;
@property (nonatomic,retain) UITableView *tabel;


- (void)deleteCollect:(id)sender;
- (void)loadDa;
@end
