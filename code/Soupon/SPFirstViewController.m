//
//  SPFirstViewController.m
//  Soupon
//
//  Created by Yuan on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//  第一个界面，包括滚动广告，热门优惠信息

#import "SPFirstViewController.h"
#import "Status.h"
#import "SPCommon.h"
#import "SPCell.h"

@interface SPFirstViewController ()
{
	int cityNum;
	int pageNum ;
}

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
		self.tabBarItem.image = [UIImage imageNamed:@"1.png"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
	[self.navigationController setNavigationBarHidden:NO];
	[self.tabBarController.navigationItem setRightBarButtonItem:nil];
	[self.tabBarController.navigationItem setLeftBarButtonItem:leftItem];
	self.tabBarController.title = @"环旗优惠";
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {  
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];  
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"]; 
		
		NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"plistdemo" ofType:@"plist"];  
		NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];  NSLog(@"%@", data);  
		//添加一项内容  
		[data setObject:@"add some content" forKey:@"c_key"];  
		
		//获取应用程序沙盒的Documents目录  
		NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);  
		NSString *plistPath1 = [paths objectAtIndex:0];  
		
		//得到完整的文件名  
		NSString *filename=[plistPath1 stringByAppendingPathComponent:@"test.plist"];
		NSString *filename2=[plistPath1 stringByAppendingPathComponent:@"store.plist"];
		NSFileManager* fm = [NSFileManager defaultManager];
		[fm createFileAtPath:filename contents:(NSData*)data attributes:nil];
		[fm createFileAtPath:filename2 contents:(NSData*)data attributes:nil];
		[data release];
		data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];  
		
		//输入写入  
		[data writeToFile:filename atomically:YES];  
		[data writeToFile:filename2 atomically:YES];
		[data release];
		//那怎么证明我的数据写入了呢？读出来看看  
		//NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];  
		//NSLog(@"%@", data1);  
	}  
	else{  
		[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];  
	}
	
	
	pageNum = 10;
	
	//TableViewCell中图片的异步加载管理
	objMan = [[HJObjManager alloc] initWithLoadingBufferSize:6 memCacheSize:20];
	NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/flickr/"];
	HJMOFileCache* fileCache = [[[HJMOFileCache alloc] initWithRootPath:cacheDirectory] autorelease];
	objMan.fileCache = fileCache;
	// Have the file cache trim itself down to a size & age limit, so it doesn't grow forever
	fileCache.fileCountLimit = 100;
	fileCache.fileAgeLimit = 60*60*24*7; //1 week
	[fileCache trimCacheUsingBackgroundThread];
	
	
	tabelView  = [[PullToRefreshTableView alloc]initWithFrame:CGRectMake(0, 110, 320, 258)];
	tabelView.dataSource = self;
	tabelView.delegate = self;
	tabelView.tag =10;
	[self.view addSubview:tabelView];
	manager = [SDWebImageManager sharedManager];
	
	//对接口返回数据进行转码
	NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:HOTLIST]];
	
	[request setDelegate:self];
	request.downloadProgressDelegate = self ;
	[request startAsynchronous];
	
	
	NSString *citysString =  [NSString stringWithContentsOfURL:[NSURL URLWithString:GETCITYS] usedEncoding:&encode error:nil];

	cityArray = [[SPCommon parserXML:citysString type:xGetcitys]copy];
	SPCityData *b = (SPCityData*)[cityArray objectAtIndex:0];
	leftItem = [[UIBarButtonItem alloc]initWithTitle:b.s_cityCaption style:UIBarButtonItemStyleBordered target:self action:@selector(leftItemClicked:)];
	

	
	if (1) {
		NSString *adsString =  [NSString stringWithContentsOfURL:[NSURL URLWithString:ADS] usedEncoding:&encode error:nil];
		adsArray = [[SPCommon parserXML:adsString type:xAds]copy];
	}else {
		NSLog(@"error");
	}

	if (isIPhone5) {
		CGRect mainRect = self.view.frame;
		mainRect.size.height = ScreenHeight;
		self.view.frame = mainRect;
	
		CGRect r = CGRectMake(0, 110, 320, 356);
		tabelView.frame = r;
	}
	
	//滚动视图
	pagePhotosView = [[PagePhotosView alloc] initWithFrame: CGRectMake(0,0,320,110) withDataSource:self];
    [self.view addSubview:pagePhotosView];
    [pagePhotosView release];
}
- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes{
	NSLog(@"Receive:%lld",bytes);
}
-(void)requestFinished:(ASIHTTPRequest
					   *)request

{	
	//Use when fetching text data
	NSLog(@"Success");
	NSString *responseString = [request responseString];
	if (![responseString isEqualToString:@""]) {
		hotArray = [[SPCommon parserXML:responseString type:xHotlist]copy];
		[tabelView reloadData:YES];
	}else {
		NSLog(@"error");
	}
}

-(void)requestFailed:(ASIHTTPRequest
					 *)request{
	
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"获取数据失败，请稍后重试。" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
	[alert show];
	[alert release];
}


//城市选择按钮的触发事件
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

// 滚动视图有多少页
- (int)numberOfPages{
	return [adsArray count];
}

// 滚地视图每页的图片
- (UIImage *)imageAtIndex:(int)index{
	SPAdsData *ad =  [adsArray objectAtIndex:index];
	NSString *urlStirng = [NSString stringWithFormat:@"%@%@",GETIMAGE,ad.s_adName];
	
	UIImage *cachedImage = [manager imageWithURL:[NSURL URLWithString:urlStirng]]; 

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
			
			[self refresh];
			
            break;
            
        case k_RETURN_LOADMORE:
			[self loadMore];
            break;
            
        default:
            break;
    }
    [self performSelectorOnMainThread:@selector(updateTableView) withObject:nil waitUntilDone:NO];
    [pool release];
}
//刷新
- (void)refresh{
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:HOTLIST]];
	
	[request setDelegate:self];
	
	[request startAsynchronous];
}

//加载
- (void)loadMore{

	pageNum += pageNum;
	NSString *s = [NSString stringWithFormat:@"http://www.sltouch.com/soupon/mobile/hotlist.aspx?city=%d&begin=0&max=%d",cityNum,pageNum];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:s]];
	
	[request setDelegate:self];
	
	[request startAsynchronous];

}

- (void)updateTableView{
    if (5) {
        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [tabelView reloadData:NO];
    } else {
        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [tabelView reloadData:YES];
    }
}

#pragma mark -
#pragma mark Scroll View Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [tabelView tableViewDidDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSInteger returnKey = [tabelView tableViewDidEndDragging];
    
    //  returnKey用来判断执行的拖动是下拉还是上拖，如果数据正在加载，则返回DO_NOTHING
    if (returnKey != k_RETURN_DO_NOTHING) {
        NSString * key = [NSString stringWithFormat:@"%d", returnKey];
        [NSThread detachNewThreadSelector:@selector(updateThread:) toTarget:self withObject:key];
    }
}



#pragma marked TabelViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	self.tabBarController.title = @"返回";
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (tableView.tag == 12) {
		SPCityData *b = (SPCityData*)[cityArray objectAtIndex:indexPath.row];
		leftItem.title = b.s_cityCaption;
		[popover dismissPopoverAnimated:YES];
		
		NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
		NSString *s = [NSString stringWithFormat:@"http://www.sltouch.com/soupon/mobile/hotlist.aspx?city=%@&begin=0&max=100",b.s_cityID];
		cityNum = [b.s_cityID intValue];
		NSString *hotstring =  [NSString stringWithContentsOfURL:[NSURL URLWithString:s] usedEncoding:&encode error:nil];
		hotArray = [[SPCommon parserXML:hotstring type:xHotlist]copy];
		//[hotArray addObjectsFromArray:dataSorce];
		[tabelView reloadData:YES];
	}
	else {
		if (!con) {
			con = [[SPShowInfoViewController alloc]init];
		}

		SPHotData *b = (SPHotData*)[hotArray objectAtIndex:indexPath.row];
		NSString *s = [NSString stringWithFormat:@"%@%@",SHOWINFO,b.s_hotid];
		
		//NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
		//NSString *hotstring =  [NSString stringWithContentsOfURL:[NSURL URLWithString:s] usedEncoding:&encode error:nil];
		//NSLog(@"%@",hotstring);
		[con setAll:s];
		[self.navigationController pushViewController:con animated:YES];
	}
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if ([hotArray count] == 0) {
        //  本方法是为了在数据未空时，让“下拉刷新”视图可直接显示，比较直观
        tableView.contentInset = UIEdgeInsetsMake(k_STATE_VIEW_HEIGHT, 0, 0, 0);
    }
	
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
