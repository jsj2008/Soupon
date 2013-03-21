//
//  SPShowInfoViewController.h
//  Soupon
//
//  Created by rjxy rjxy on 13-3-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Collect.h"
#import "SPCollectViewController.h"

@interface SPShowInfoViewController : UIViewController<UIApplicationDelegate,NSXMLParserDelegate>
{
	NSDictionary *dic;
	Collect *col;
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
- (void)setCollect:(Collect *)collect;
- (IBAction)shoucang:(id)sender;
@end
