//
//  SPThirdViewController.m
//  Soupon
//
//  Created by Yuan on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPThirdViewController.h"
#import "Status.h"
#import <QuartzCore/QuartzCore.h>
@interface SPThirdViewController (){
	int y;
}

@end

@implementation SPThirdViewController
@synthesize alertView;
@synthesize storeName;
@synthesize attentionButton;
@synthesize favorableButton;
@synthesize cancelButton;
@synthesize tabelView,cityData;
- (void)dealloc{
	[tabelView release];
	[cityData release];
	[rightItem release];
	[alertView release];
	[storeName release];
	[attentionButton release];
	[favorableButton release];
	[cancelButton release];
	[super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = NSLocalizedString(@"周边优惠", @"周边优惠");
		self.tabBarItem.image = [UIImage imageNamed:@"3.png"];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
	[self.navigationController setNavigationBarHidden:NO];
	[self.tabBarController.navigationItem setLeftBarButtonItem:nil];
	[self.tabBarController.navigationItem setRightBarButtonItem:rightItem];
	self.tabBarController.title = @"周边优惠";
}

- (void)viewWillDisappear:(BOOL)animated{
	[locManager stopUpdatingLocation];
}

- (void)viewDidLoad
{
	self.alertView.frame = CGRectMake(25, 80, 270, 182);
	self.alertView.layer.borderWidth = 5.0f;
	self.alertView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
	self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
	
	locManager = [[CLLocationManager alloc]init];
    [locManager setDelegate:self];
    [locManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locManager startUpdatingLocation];
	
	objMan = [[HJObjManager alloc] initWithLoadingBufferSize:6 memCacheSize:20];
	NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/flickr/"] ;
	HJMOFileCache* fileCache = [[[HJMOFileCache alloc] initWithRootPath:cacheDirectory] autorelease];
	objMan.fileCache = fileCache;
	
	// Have the file cache trim itself down to a size & age limit, so it doesn't grow forever
	fileCache.fileCountLimit = 100;
	fileCache.fileAgeLimit = 60*60*24*7; //1 week
	[fileCache trimCacheUsingBackgroundThread];
	
	tabelView  = [[PullToRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, 320, 367)];
	tabelView.dataSource = self;
	tabelView.delegate = self;
	[self.view addSubview:tabelView];
	//NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	//NSString *ss = [NSString stringWithFormat:@"http://www.sltouch.com/soupon/mobile/nearby.aspx?x=%@&y=%@&begin=0&max=10",lon,lat];
	//NSString *hotstring =  [NSString stringWithContentsOfURL:[NSURL URLWithString:SEARCHAROUND] usedEncoding:&encode error:nil];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:SEARCHAROUND]];
	
	[request setDelegate:self];
	
	[request startAsynchronous];


	if (isIPhone5) {
		CGRect mainRect = self.view.frame;
		mainRect.size.height = ScreenHeight;
		self.view.frame = mainRect;
		
		CGRect rect = tabelView.frame;
		CGRect r =  CGRectMake(0, 0, 320, 456);
		rect.origin.y = MainHeight - rect.size.height;
		tabelView.frame = r;
	}
	rightItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClicked)];
	[self.tabBarController.navigationItem setRightBarButtonItem:rightItem];
	
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)requestFinished:(ASIHTTPRequest
						*)request

{
	//Use when fetching text data
	NSLog(@"Success");
	NSString *responseString = [request responseString];
	if (![responseString isEqualToString:@""]) {
		aroundArray = [[SPCommon parserXML:responseString type:xSearcharound]copy];
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

- (void)rightItemClicked{
	
	[locManager startUpdatingHeading];
	[tabelView reloadData:YES];
	
}
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    CLLocationCoordinate2D loc = [newLocation coordinate];
    lat =[NSString stringWithFormat:@"%f",loc.latitude];//get latitude
    lon =[NSString stringWithFormat:@"%f",loc.longitude];//get longitude  
	locURLString = [NSString stringWithFormat:@"http://www.sltouch.com/soupon/mobile/nearby.aspx?x=%@&y=%@&begin=0&max=10",lon,lat];
	NSLog(@"sss%@",locURLString);
//	NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//	NSString *ss = [NSString stringWithFormat:@"http://www.sltouch.com/soupon/mobile/nearby.aspx?x=%@&y=%@&begin=0&max=10",lon,lat];
//	NSLog(@"ss:%@",ss);
//	NSString *hotstring =  [NSString stringWithContentsOfURL:[NSURL URLWithString:ss] usedEncoding:&encode error:nil];
//	if (![hotstring isEqualToString:@""]) {
//		//aroundArray = [[SPCommon parserXML:hotstring type:xSearcharound]copy];
//	}else {
//		NSLog(@"error");
//	}
	[manager stopUpdatingLocation];
    NSLog(@"%@ %@",lat,lon);
}
- (void)viewDidUnload
{
	[self setAlertView:nil];
	[self setStoreName:nil];
	[self setAttentionButton:nil];
	[self setFavorableButton:nil];
	[self setCancelButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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


- (void)bounceOutAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9, 0.9);
         self.alertView.alpha = 0.8;
     }
                     completion:^(BOOL finished){
                         [self bounceInAnimationStoped];
                     }];
}
- (void)bounceInAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
         self.alertView.alpha = 1.0;
     }
                     completion:^(BOOL finished){
                         [self animationStoped];
                     }];
}
- (void)animationStoped
{
    
}

- (IBAction)hide:(id)sender
{
	[self.alertView removeFromSuperview];
    self.alertView.alpha = 0;
	self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
}

- (IBAction)attention:(id)sender{
	//获取应用程序沙盒的Documents目录  
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);  
	NSString *plistPath1 = [paths objectAtIndex:0];  
	
	//得到完整的文件名  
	NSString *filename=[plistPath1 stringByAppendingPathComponent:@"store.plist"];  
	NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];  
	if(data == nil)
	{
		//1. 创建一个plist文件 
		NSFileManager* fm = [NSFileManager defaultManager];
		[fm createFileAtPath:filename contents:nil attributes:nil];        
	}
	NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:h.s_caption,@"caption",
																	h.s_districtcaption,@"content",
																	h.s_distance,@"indate",
																    h.s_categoryid,@"cid",
																	h.s_districtid,@"diid",
																	h.s_brandid,@"bid",
																	h.s_categorycaption,@"c",
																	h.s_districtcaption,@"d",
																	h.s_brandcaption,@"b",nil];
	[data setObject:dic forKey:h.s_caption]; 
	//输入写入  
	[data writeToFile:filename atomically:YES];  
	[data release];
	[dic release];
	//那怎么证明我的数据写入了呢？读出来看看  
	//NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];  
	//NSLog(@"%@", data1);
	
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"收藏成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
	[alert show];
	[alert release];
	[self hide:nil];
}


- (IBAction)favorable:(id)sender{
	[self.alertView removeFromSuperview];

	h = (SPAroundInfo*)[aroundArray objectAtIndex:y];
	NSUserDefaults *aDe = [NSUserDefaults standardUserDefaults];
	[aDe setObject:h.s_categoryid forKey:@"cid"];
	[aDe setObject:h.s_districtid forKey:@"diid"];
	[aDe setObject:h.s_brandid forKey:@"bid"];
	[aDe setObject:h.s_categorycaption forKey:@"c"];
	[aDe setObject:h.s_districtcaption forKey:@"d"];
	[aDe setObject:h.s_brandcaption forKey:@"b"];
	[aDe setBool:YES forKey:@"show"];
	[aDe synchronize];

	self.tabBarController.selectedIndex = 1;
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
#pragma marked AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	switch ((long)buttonIndex) {
		case 1:
			[self attention:nil];
			break;
		case 2:
			[self favorable:nil];
			break;
			
		default:
			break;
	}
}
#pragma marked TabelViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	y = indexPath.row;
	h = (SPAroundInfo*)[aroundArray objectAtIndex:indexPath.row];
	
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"欢迎位临" message:h.s_caption delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"关注店铺",@"店内优惠", nil];
	
	[alert show];
	[alert release];
	
//	self.storeName.text = h.s_caption;
//	[UIView animateWithDuration:0.2 animations:
//     ^(void){
//		 
//         self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1f, 1.1f);
//         self.alertView.alpha = 0.5;
//	 }
//                     completion:^(BOOL finished){
//                         [self bounceOutAnimationStoped];
//                     }];
}



- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [aroundArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	HJManagedImageV* mi;
	SPCell *cell = (SPCell *)[tableView dequeueReusableCellWithIdentifier:@"SPCell"];
	if (!cell) {
		cell = [[[SPCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SPCell"]autorelease];
		mi = [[[HJManagedImageV alloc] initWithFrame:CGRectMake(2,1.5,65,70)] autorelease];
		mi.tag = 999;
		
		
		[cell addSubview:mi];
		
	}
	else {
		//Get a reference to the managed image view that was already in the recycled cell, and clear it
		mi = (HJManagedImageV*)[cell viewWithTag:999];
		[mi clear];
	}
	h = (SPAroundInfo*)[aroundArray objectAtIndex:indexPath.row];
	[cell setAroundData:h];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    return 75;
}



@end
