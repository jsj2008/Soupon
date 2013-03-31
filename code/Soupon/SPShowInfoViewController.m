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
	


	
//	NSString *urlStirng = [NSString stringWithFormat:@"%@%@",GETIMAGE,[dic objectForKey:@"image"]];
//	NSLog(@"url:%@",urlStirng);
//	UIImage *cachedImage = [manager imageWithURL:[NSURL URLWithString:urlStirng]]; 
//	
//	// 将需要缓存的图片加载进来 
//	if(cachedImage) { 
//		theImageView.image = cachedImage;
//	}  else{ 
//		// 如果Cache没有命中，则去下载指定网络位置的图片，并且给出一个委托方法          
//		
//		[manager downloadWithURL:[NSURL URLWithString:urlStirng] delegate:self];
//		
//	}
//	NSLog(@"dddd:%@",[dic objectForKey:@"image"]);
//	if ([[dic objectForKey:@"image"]isEqualToString:@""]) {
//		NSLog(@"kkkkkk");
//		theImageView.image = [UIImage imageNamed:@"detail_image_no.png"];
//	}else{
//		theImageView.image = [UIImage imageNamed:@"detail_image_bg.png"];
//		theImageView.image = cachedImage;
//	}

}

- (void)imageDownloader:(SDWebImageDownloader *)downloader didFinishWithImage:(UIImage *)image{
	NSLog(@"ok");
		theImageView.image = image;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[contentTextView setFont:[UIFont fontWithName:@"System" size:10.0]];
	manager = [SDWebImageManager sharedManager];
	//设置详细页面北京颜色
	[self.view setBackgroundColor:InfoColor];
	if (isIPhone5) {
		theImageView.frame = CGRectMake(theImageView.frame.origin.x, theImageView.frame.origin.y+70, theImageView.frame.size.width, theImageView.frame.size.height);
		self.label1.frame = CGRectMake(self.label1.frame.origin.x, self.label1.frame.origin.y+70, self.label1.frame.size.width, self.label1.frame.size.height);
		self.label2.frame = CGRectMake(self.label2.frame.origin.x, self.label2.frame.origin.y+70, self.label2.frame.size.width, self.label2.frame.size.height);
		self.cellectButton.frame = CGRectMake(self.cellectButton.frame.origin.x, self.cellectButton.frame.origin.y+70, self.cellectButton.frame.size.width, self.cellectButton.frame.size.height);
		self.lineDateLabel.frame = CGRectMake(self.lineDateLabel.frame.origin.x, self.lineDateLabel.frame.origin.y+70, self.lineDateLabel.frame.size.width, self.lineDateLabel.frame.size.height);
		self.contentTextView.frame = CGRectMake(self.contentTextView.frame.origin.x, self.contentTextView.frame.origin.y, self.contentTextView.frame.size.width, self.contentTextView.frame.size.height+60);
		
	}
	
}

- (void)setAll:(NSString*)couponid{
	lineDateLabel.text = nil;
	contentTextView.text = nil;
	captionLabel.text = nil;
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:couponid]];
	
	[request setDelegate:self];
	
	[request startAsynchronous];
	
}
-(void)requestFinished:(ASIHTTPRequest
						*)request

{
	//Use when fetching text data
	NSLog(@"Success");
	NSData *responseData = [request responseData];
	NSXMLParser *parser = [[NSXMLParser alloc]initWithData:responseData];
	[parser setDelegate:self];
	[parser parse];
}

-(void)requestFailed:(ASIHTTPRequest
					  *)request{
	
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"获取数据失败，请稍后重试。" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
	[alert show];
	[alert release];
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
		lineDateLabel.text = [dic objectForKey:@"indate"];
		contentTextView.text = [dic objectForKey:@"content"];
		captionLabel.text = [dic objectForKey:@"caption"];
		NSString *urlStirng = [NSString stringWithFormat:@"%@%@",GETIMAGE,[dic objectForKey:@"image"]];
		NSLog(@"url:%@",urlStirng);
		UIImage *cachedImage = [manager imageWithURL:[NSURL URLWithString:urlStirng]];
		
		// 将需要缓存的图片加载进来
		if(cachedImage) {
			theImageView.image = cachedImage;
		}  else{
			// 如果Cache没有命中，则去下载指定网络位置的图片，并且给出一个委托方法
			
			[manager downloadWithURL:[NSURL URLWithString:urlStirng] delegate:self];
			
		}
		NSLog(@"dddd:%@",[dic objectForKey:@"image"]);
		if ([[dic objectForKey:@"image"]isEqualToString:@""]) {
			NSLog(@"kkkkkk");
			theImageView.image = [UIImage imageNamed:@"detail_image_no.png"];
		}else{
			theImageView.image = [UIImage imageNamed:@"detail_image_bg.png"];
			theImageView.image = cachedImage;
		}
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
		NSLog(@"收藏成功！");

		UIAlertView *a  = [[UIAlertView alloc]initWithTitle:@"收藏成功！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
		
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
	[self setLabel1:nil];
	[self setLabel2:nil];
    [super viewDidUnload];
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
	[_label1 release];
	[_label2 release];
	[super dealloc];
}
@end
