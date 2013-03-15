//
//  SPSecondViewController.m
//  Soupon
//
//  Created by rjxy rjxy on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPSecondViewController.h"
#import "SPCell.h"
#import "Status.h"
#import "SPCommon.h"

@interface SPSecondViewController (){

}

@end

@implementation SPSecondViewController
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
		self.title = NSLocalizedString(@"优惠搜索", @"优惠搜索");
		self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
	[self.tabBarController.navigationItem setLeftBarButtonItem:nil];
	[self.tabBarController.navigationItem setRightBarButtonItem:rightItem];
	self.tabBarController.title = @"优惠搜索";

}
							


- (void)viewDidLoad
{
    [super viewDidLoad];
	NSThread* myThread = [[NSThread alloc] initWithTarget:self
												 selector:@selector(parser)
												   object:nil];
	[myThread start];
	
	
	rightItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClicked)];
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
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)parser{
	NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSString *categoryString =  [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PARTITION,@"category"]] usedEncoding:&encode error:nil];
	NSString *brandString =  [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PARTITION,@"brand"]] usedEncoding:&encode error:nil];
	NSString *districtString =  [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PARTITION,@"district"]] usedEncoding:&encode error:nil];
	NSString *hotstring =  [NSString stringWithContentsOfURL:[NSURL URLWithString:HOTLIST] usedEncoding:&encode error:nil];
	
	brandArray = [[[SPCommon parserXML:brandString type:xPartitionB]copy]autorelease];
	categoryhArray = [[[SPCommon parserXML:categoryString type:xPartitionC]copy]autorelease];
	districtArray = [[[SPCommon parserXML:districtString type:xPartitionD]copy]autorelease];
	
	//NSLog(@"error:%@\n",hotstring);
	if (![hotstring isEqualToString:@""]) {
		searchArray = [[SPCommon parserXML:hotstring type:xHotlist]copy];
	}else {
		NSLog(@"error");
	}
	dispatch_async(dispatch_get_main_queue(), ^{[self.view addSubview:tabelView];});
	
}

- (void)rightItemClicked{

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
	return [searchArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
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
	SPHotData *h = (SPHotData*)[searchArray objectAtIndex:indexPath.row];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{  
    return 70;
}

@end
