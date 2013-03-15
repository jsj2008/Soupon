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
@synthesize adsData, cityData, citys, tabelView;
-(void)dealloc{
	[adsArray release];
	[cityArray release];
	[leftItem release];
	[objMan release];
	[tabelView release];
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
	self.tabBarController.title = @"环旗优惠";
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];

	objMan = [[HJObjManager alloc] initWithLoadingBufferSize:6 memCacheSize:20];
	NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/flickr/"];
	HJMOFileCache* fileCache = [[[HJMOFileCache alloc] initWithRootPath:cacheDirectory] autorelease];
	objMan.fileCache = fileCache;
	// Have the file cache trim itself down to a size & age limit, so it doesn't grow forever
	fileCache.fileCountLimit = 100;
	fileCache.fileAgeLimit = 60*60*24*7; //1 week
	[fileCache trimCacheUsingBackgroundThread];
	
	tabelView  = [[PullToRefreshTableView alloc]initWithFrame:CGRectMake(0, 150, 320, 218)];
	tabelView.dataSource = self;
	tabelView.delegate = self;
	tabelView.tag =10;
	[self.view addSubview:tabelView];
	manager = [SDWebImageManager sharedManager];
	
	NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSString *hotstring =  [NSString stringWithContentsOfURL:[NSURL URLWithString:HOTLIST] usedEncoding:&encode error:nil];
	NSString *adsString =  [NSString stringWithContentsOfURL:[NSURL URLWithString:ADS] usedEncoding:&encode error:nil];
	NSString *citysString =  [NSString stringWithContentsOfURL:[NSURL URLWithString:GETCITYS] usedEncoding:&encode error:nil];
	cityArray = [[SPCommon parserXML:citysString type:xGetcitys]copy];
	SPCityData *b = (SPCityData*)[cityArray objectAtIndex:0];
	leftItem = [[UIBarButtonItem alloc]initWithTitle:b.s_cityCaption style:UIBarButtonItemStyleDone target:self action:@selector(leftItemClicked:)];
	
	if (![hotstring isEqualToString:@""]) {
		hotArray = [[SPCommon parserXML:hotstring type:xHotlist]copy];
	}else {
		NSLog(@"error");
	}
	if (![adsString isEqualToString:@""]) {
		adsArray = [[SPCommon parserXML:adsString type:xAds]copy];
	}else {
		NSLog(@"error");
	}

	pagePhotosView = [[PagePhotosView alloc] initWithFrame: CGRectMake(0,0,320,150) withDataSource:self];
    [self.view addSubview:pagePhotosView];
    [pagePhotosView release];
}

- (IBAction)leftItemClicked:(id)sender{
	UITableViewController *controller = [[UITableViewController alloc]init];
	controller.tableView.delegate =self;
	controller.tableView.dataSource = self;
	controller.tableView.tag = 12;
    popover = [[FPPopoverController alloc] initWithViewController:controller];
    [controller release];
    
    //popover.arrowDirection = FPPopoverArrowDirectionAny;
    popover.tint = FPPopoverLightGrayTint;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        popover.contentSize = CGSizeMake(100, 500);
    }
    popover.arrowDirection = FPPopoverArrowDirectionAny;
	popover.contentSize = CGSizeMake(120, 350);
    UIView *i = [[UIView alloc]initWithFrame:CGRectMake(20, 50, 40, 55)];
    //sender is the UIButton view
    [popover presentPopoverFromView:i];
	[i release];

}

- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController 
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
    [visiblePopoverController autorelease];
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
		return cachedImage;
	} 
}

- (void)imageDownloader:(SDWebImageDownloader *)downloader didFinishWithImage:(UIImage *)image{
	
}

- (void)updateThread:(NSString *)returnKey{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    sleep(2);
    switch ([returnKey intValue]) {
        case k_RETURN_REFRESH:

            break;
            
        case k_RETURN_LOADMORE:

            break;
            
        default:
            break;
    }
    [self performSelectorOnMainThread:@selector(updateTableView) withObject:nil waitUntilDone:NO];
    [pool release];
}

- (void)updateTableView{
    if (5) {
        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [tabelView reloadData:YES];
    } else {
        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [tabelView reloadData:YES];
    }
}




#pragma marked TabelViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (tableView.tag == 12) {
		SPCityData *b = (SPCityData*)[cityArray objectAtIndex:indexPath.row];
		leftItem.title = b.s_cityCaption;
		[popover dismissPopoverAnimated:YES];
		
		NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
		NSString *s = [NSString stringWithFormat:@"http://www.sltouch.com/soupon/hotlist.aspx?city=%@&begin=0&max=10",b.s_cityID];
		NSString *hotstring =  [NSString stringWithContentsOfURL:[NSURL URLWithString:s] usedEncoding:&encode error:nil];
		hotArray = [[SPCommon parserXML:hotstring type:xHotlist]copy];
		[tabelView reloadData:YES];
	}
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (tableView.tag == 12) {
		return [cityArray count];
	}
	return [hotArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	if (tableView.tag == 12) {
		UITableViewCell *cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"]autorelease];
		SPCityData *b = (SPCityData*)[cityArray objectAtIndex:indexPath.row];
		cell.textLabel.text = b.s_cityCaption;
		return cell;
	}
	
	
	HJManagedImageV* mi;
	SPCell *cell = (SPCell *)[tableView dequeueReusableCellWithIdentifier:@"SPCell"];
	if (!cell) {
		cell = [[[SPCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SPCell"]autorelease];
		mi = [[[HJManagedImageV alloc] initWithFrame:CGRectMake(1,-1,65,70)] autorelease];
		mi.tag = 999;
		[cell addSubview:mi];
		
	}
	else {
		//Get a reference to the managed image view that was already in the recycled cell, and clear it
		mi = (HJManagedImageV*)[cell viewWithTag:999];
		[mi clear];
	}
	SPHotData *h =(SPHotData*)[hotArray objectAtIndex:indexPath.row];
	[cell setHotData:h];
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	
	//set the URL that we want the managed image view to load
	NSString *urlStirng = [NSString stringWithFormat:@"%@%@",GETIMAGE,h.s_icon];
	urlStirng = [urlStirng stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
	mi.url = [NSURL URLWithString:urlStirng];
	
	//tell the object manager to manage the managed image view, 
	//this causes the cached image to display, or the image to be loaded, cached, and displayed
	[objMan manage:mi];
	return cell;
}

-(CGFloat)tableView:(UITableView *)tableViews heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{
	if (tableViews.tag == 12) {
		return 45;
	}
    return 70;
}


@end
