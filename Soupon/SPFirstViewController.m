//
//  SPFirstViewController.m
//  Soupon
//
//  Created by rjxy rjxy on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPFirstViewController.h"
#import "Status.h"
#import "SPCommon.h"
#import "SPCell.h"


@interface SPFirstViewController ()

@end

@implementation SPFirstViewController
@synthesize adsData, cityData, adsArray, cityArray, citys, tabelView;
-(void)dealloc{
	[adsArray release];
	[cityArray release];
	[leftItem release];
	[super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = NSLocalizedString(@"热门优惠", @"热门优惠");
		self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
	[self.tabBarController.navigationItem setRightBarButtonItem:nil];
	[self.tabBarController.navigationItem setLeftBarButtonItem:leftItem];
	self.tabBarController.title = @"热门优惠";
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	tabelView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, 320, 218)];
	tabelView.dataSource = self;
	tabelView.delegate = self;
	[self.view addSubview:tabelView];
	manager = [SDWebImageManager sharedManager];
	adsArray = [[NSMutableArray alloc]init];
	cityArray = [[NSMutableArray alloc]init];
	NSURL *adsURL = [NSURL URLWithString:ADS];
	NSURL *cityListURL = [NSURL URLWithString:GETCITYS];

	NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSString *string =  [NSString stringWithContentsOfURL:cityListURL usedEncoding:&encode error:nil];
	NSLog(@"city:%@",string);
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfURL:adsURL]];
	[parser setShouldProcessNamespaces:NO];
	[parser setShouldReportNamespacePrefixes:NO];
	[parser setShouldResolveExternalEntities:NO];
	[parser setDelegate:self];
	[parser parse];
	NSXMLParser *cityParser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfURL:cityListURL]];
	[cityParser setShouldProcessNamespaces:NO];
	[cityParser setShouldReportNamespacePrefixes:NO];
	[cityParser setShouldResolveExternalEntities:NO];
	[cityParser setDelegate:self];
	[cityParser parse];
	
	leftItem = [[UIBarButtonItem alloc]initWithTitle:[citys objectAtIndex:0] style:UIBarButtonItemStyleDone target:self action:@selector(leftItemClicked)];

	PagePhotosView *pagePhotosView = [[PagePhotosView alloc] initWithFrame: CGRectMake(0,0,320,150) withDataSource:self];
    [self.view addSubview:pagePhotosView];
    [pagePhotosView release];

}

- (void)leftItemClicked{


}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// 有多少页
- (int)numberOfPages{
	return [adsArray count];
}

// 每页的图片
- (UIImage *)imageAtIndex:(int)index{
	SPAdsData *ad =  [adsArray objectAtIndex:index];
	NSString *urlStirng = [NSString stringWithFormat:@"%@%@",GETIMAGE,ad.s_adName];
	UIImage *cachedImage = [manager imageWithURL:[NSURL URLWithString:urlStirng]]; 
	//NSLog(@"u;%@----%@,%d",urlStirng,ad.s_adName,index);
	// 将需要缓存的图片加载进来 
	if(cachedImage) { 
		return cachedImage;
	}  else{ 
		// 如果Cache没有命中，则去下载指定网络位置的图片，并且给出一个委托方法          
		[manager downloadWithURL:[NSURL URLWithString:urlStirng] delegate:self]; 
		return nil;
	} 
	
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict

{	
	if ([elementName isEqualToString:@"abbanner"]||[elementName isEqualToString:@"ad"]) {
		adsData = [[SPAdsData alloc]init];
		for (NSString *s in attributeDict) {
			if ([s isEqualToString:@"id"]) {
				adsData.s_adID = [attributeDict objectForKey:s];			
			}
			if ([s isEqualToString:@"url"]) {
				adsData.s_adURL = [attributeDict objectForKey:s];
			}
			if ([s isEqualToString:@"poster"]) {
				adsData.s_adName= [attributeDict objectForKey:s];
			}
		}
		[adsArray addObject:adsData];
		[adsData release];
	}else if ([elementName isEqualToString:@"citylist"]||[elementName isEqualToString:@"city"]) {
		cityData = [[SPCityData alloc]init];
		citys = [[NSMutableArray alloc]init];
		for (NSString *s in attributeDict) {
			if ([s isEqualToString:@"id"]) {
				cityData.s_cityID = [attributeDict objectForKey:s];
				
			}
			if ([s isEqualToString:@"caption"]) {
				cityData.s_cityCaption = [attributeDict objectForKey:s];NSLog(@"ssss:%@",cityData.s_cityCaption);
				[citys addObject:cityData.s_cityCaption];
			}
		}
		[cityArray addObject:adsData];
		[cityData release];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string

{
	
	NSLog(@"Value:%@",string);
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName

{
}

- ( void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image { 
	
}

#pragma marked TabelViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	SPCell *cell = [[[SPCell alloc]init]autorelease];
	return cell;
}


@end
