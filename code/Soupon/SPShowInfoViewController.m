//
//  SPShowInfoViewController.m
//  Soupon
//
//  Created by Yuan on 13-3-16.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPShowInfoViewController.h"
#import "Status.h"
#import "SPCommon.h"
#import "SPAppDelegate.h"
#import <CoreData/CoreData.h>

@interface SPShowInfoViewController ()

@end

@implementation SPShowInfoViewController
@synthesize theImageView;
@synthesize lineDateLabel;
@synthesize cellectButton;
@synthesize captionLabel;
@synthesize contentTextView;

@synthesize managedObjectContext,managedObjectModel,persistentStoreCoordinator;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
	
		lineDateLabel.text = [dic objectForKey:@"indate"];
		contentTextView.text = [dic objectForKey:@"content"];
		captionLabel.text = [dic objectForKey:@"caption"];
	NSString *urlStirng = [NSString stringWithFormat:@"%@%@",GETIMAGE,[dic objectForKey:@"image"]];
	
	UIImage *cachedImage = [manager imageWithURL:[NSURL URLWithString:urlStirng]]; 
	
	// 将需要缓存的图片加载进来 
	if(cachedImage) { 
		theImageView.image = cachedImage;
	}  else{ 
		// 如果Cache没有命中，则去下载指定网络位置的图片，并且给出一个委托方法          
		[manager downloadWithURL:[NSURL URLWithString:urlStirng] delegate:self]; 
		
	}

}

- (void)imageDownloader:(SDWebImageDownloader *)downloader didFinishWithImage:(UIImage *)image{
		theImageView.image = image;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	manager = [SDWebImageManager sharedManager];
	//设置详细页面北京颜色
	[self.view setBackgroundColor:InfoColor];
	
}

- (void)setAll:(NSString*)couponid{
	NSXMLParser *parser = [[NSXMLParser alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:couponid]]];
	[parser setDelegate:self];
	[parser parse];
}

- (void)setCollect:(NSDictionary *)collect{
	dic = collect;
	
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString*)qName attributes:(NSDictionary *)attributeDict{ 
	if (qName) { 
		elementName = qName; 
	} 
	if ([elementName isEqualToString:@"detail"]) { 
		dic = [[NSDictionary dictionaryWithDictionary:attributeDict]copy];
	}
} 

- (IBAction)shoucang:(id)sender{
	if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"phone"]isEqual:@""]) {
		NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"plistdemo" ofType:@"plist"];  
		NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];  
		NSLog(@"%@", data);
		[data release];
		//获取应用程序沙盒的Documents目录  
		NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);  
		NSString *plistPath1 = [paths objectAtIndex:0];  
		
		//得到完整的文件名  
		NSString *filename=[plistPath1 stringByAppendingPathComponent:@"test.plist"];  
		data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];  
		if(data == nil)
		{
			//1. 创建一个plist文件 
			NSFileManager* fm = [NSFileManager defaultManager];
			[fm createFileAtPath:filename contents:nil attributes:nil];        
		}
		
		[data setObject:dic forKey:[dic objectForKey:@"caption"]]; 
		//输入写入  
		[data writeToFile:filename atomically:YES];  
		[data release];
		
		//那怎么证明我的数据写入了呢？读出来看看  
		//NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];  
		//NSLog(@"%@", data1);
		
		
		
		
//		NSString *modelPath  = [[NSBundle mainBundle]pathForResource:@"collectModel" ofType:@"momd"];
//		NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
//		managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
//		
//		NSURL *storeURL = nil;
//		NSError *error = nil;
//
//		persistentStoreCoordinator  =[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:managedObjectModel];
//		storeURL  =[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
//		storeURL = [storeURL URLByAppendingPathComponent:@"collectModel.sqlite"];
//		[persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
//		managedObjectContext = [[NSManagedObjectContext alloc]init];
//		//NSManagedObjectContext *unused __attribute__((unused)) = managedObjectContext;
//		[managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
//		[managedObjectContext setMergePolicy:NSOverwriteMergePolicy];
//		
//		NSEntityDescription *description = [NSEntityDescription entityForName:@"Collect" inManagedObjectContext:managedObjectContext];
//		Collect *obj = [[[Collect alloc]initWithEntity:description insertIntoManagedObjectContext:nil]autorelease];
//		obj.caption  = [dic objectForKey:@"caption"];
//		obj.discreption = [dic objectForKey:@"content"];
//		obj.indate = [dic objectForKey:@"indate"];
//		obj.image = [dic objectForKey:@"image"];
//		[managedObjectContext insertObject:obj];
		
		//if ([managedObjectContext save:nil]) {
			NSLog(@"收藏成功！");
		//}
		UIAlertView *a  = [[UIAlertView alloc]initWithTitle:@"收藏成功！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
		//[cellectButton setHidden:YES];
		[a show];
		[a release];
	}
}

- (void)setButtonHidden{
	[cellectButton setHidden:YES];
}

- (void)viewDidUnload
{
	[self setCaptionLabel:nil];
	[self setContentTextView:nil];
	[self setTheImageView:nil];
	[self setLineDateLabel:nil];
	[self setCellectButton:nil];
	[dic release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
	[captionLabel release];
	[contentTextView release];
	[theImageView release];
	[lineDateLabel release];
	[cellectButton release];
	[super dealloc];
}
@end
