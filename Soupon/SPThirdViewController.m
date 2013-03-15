//
//  SPThirdViewController.m
//  Soupon
//
//  Created by rjxy rjxy on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPThirdViewController.h"
#import "Status.h"
@interface SPThirdViewController ()

@end

@implementation SPThirdViewController
@synthesize tabelView,cityData;
- (void)dealloc{
	[tabelView release];
	[cityData release];
	[rightItem release];
	[super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = NSLocalizedString(@"周边优惠", @"周边优惠");
		self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
	[self.tabBarController.navigationItem setLeftBarButtonItem:nil];
	[self.tabBarController.navigationItem setRightBarButtonItem:rightItem];
	self.tabBarController.title = @"周边优惠";
}

- (void)viewWillDisappear:(BOOL)animated{
	[locManager stopUpdatingLocation];
}

- (void)viewDidLoad
{
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
	NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSString *ss = [NSString stringWithFormat:@"http://www.sltouch.com/soupon/nearby.aspx?x=%@&y=%@&begin=0&max=10",lon,lat];
	NSString *hotstring =  [NSString stringWithContentsOfURL:[NSURL URLWithString:SEARCHAROUND] usedEncoding:&encode error:nil];
	NSLog(@"ho,%@",ss);
	if (![hotstring isEqualToString:@""]) {
		aroundArray = [[SPCommon parserXML:hotstring type:xSearcharound]copy];
	}else {
		NSLog(@"error");
	}
	
	rightItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClicked)];
	[self.tabBarController.navigationItem setRightBarButtonItem:rightItem];
	
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)rightItemClicked{
	[locManager startUpdatingHeading];
	[tabelView reloadData:YES];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    CLLocationCoordinate2D loc = [newLocation coordinate];
    lat =[NSString stringWithFormat:@"%f",loc.latitude];//get latitude
    lon =[NSString stringWithFormat:@"%f",loc.longitude];//get longitude  
	
	NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSString *ss = [NSString stringWithFormat:@"http://www.sltouch.com/soupon/nearby.aspx?x=%@&y=%@&begin=0&max=10",lon,lat];
	//NSLog(@"ss:%@",ss);
	NSString *hotstring =  [NSString stringWithContentsOfURL:[NSURL URLWithString:ss] usedEncoding:&encode error:nil];
	if (![hotstring isEqualToString:@""]) {
		aroundArray = [[SPCommon parserXML:hotstring type:xSearcharound]copy];
	}else {
		NSLog(@"error");
	}
	[manager stopUpdatingLocation];
    NSLog(@"%@ %@",lat,lon);
}
- (void)viewDidUnload
{
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
        [tabelView reloadData:NO];
    } else {
        //  一定要调用本方法，否则下拉/上拖视图的状态不会还原，会一直转菊花
        [tabelView reloadData:YES];
    }
}




#pragma marked TabelViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
	SPAroundInfo *h = (SPAroundInfo*)[aroundArray objectAtIndex:indexPath.row];
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
