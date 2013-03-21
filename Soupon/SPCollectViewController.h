//
//  SPCollectViewController.h
//  Soupon
//
//  Created by rjxy rjxy on 13-3-19.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPShowInfoViewController.h"

@interface SPCollectViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
	NSManagedObjectModel *managedObjectModel_;
	NSPersistentStoreCoordinator * persistentStoreCoordinator_;
	NSManagedObjectContext *managedObjectContext_;
	NSMutableArray *dataSource_;
	int coun;
	NSArray *aaa;
	
}

@property (nonatomic,retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic,retain) NSPersistentStoreCoordinator * persistentStoreCoordinator;
@property (nonatomic,retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,retain) NSMutableArray *dataSource;
@property (nonatomic,retain) UITableView *tabel;
//- (void)addData:(NSString*)captions discreption:(NSString *)dis indate:(NSString *)indate;
- (void)searchData;
- (void)deleteCollect:(id)sender;
@end
