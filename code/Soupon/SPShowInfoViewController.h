//
//  SPShowInfoViewController.h
//  Soupon
//
//  Created by Yuan on 13-3-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//  优惠劵详细信息

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "SPCollectViewController.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "SPShowInfoViewController.h"

@interface SPShowInfoViewController : UIViewController<UIApplicationDelegate,NSXMLParserDelegate,SDWebImageManagerDelegate>
{
	NSDictionary *dic;

	SDWebImageManager *manager;
} 

@property (retain, nonatomic) IBOutlet UILabel *captionLabel;
@property (retain, nonatomic) IBOutlet UITextView *contentTextView;
@property (retain, nonatomic) IBOutlet UIImageView *theImageView;
@property (retain, nonatomic) IBOutlet UILabel *lineDateLabel;
@property (retain, nonatomic) IBOutlet UIButton *cellectButton;

@property (nonatomic,retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic,retain) NSPersistentStoreCoordinator * persistentStoreCoordinator;
@property (nonatomic,retain) NSManagedObjectContext *managedObjectContext;

- (void)setAll:(NSString*)couponid;
- (void)setCollect:(NSDictionary *)collect;
- (IBAction)shoucang:(id)sender;

- (void)setButtonHidden;
@end
