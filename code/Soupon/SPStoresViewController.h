//
//  SPStoresViewController.h
//  Soupon
//
//  Created by Yuan on 13-3-23.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPStoresViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
	NSMutableArray *dataSource_;
	int coun;
	NSDictionary *data1;
	
}
@property (nonatomic,retain) NSMutableArray *dataSource;
@property (nonatomic,retain) UITableView *tabel;

@property (retain, nonatomic) IBOutlet UIView *alertView;
@property (retain, nonatomic) IBOutlet UILabel *storeName;
@property (retain, nonatomic) IBOutlet UIButton *attentionButton;
@property (retain, nonatomic) IBOutlet UIButton *favorableButton;
@property (retain, nonatomic) IBOutlet UIButton *cancelButton;

- (IBAction)hide:(id)sender;
- (IBAction)attention:(id)sender;
- (IBAction)favorable:(id)sender;
- (void)loadDa;
@end
