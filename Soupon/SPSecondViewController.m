//
//  SPSecondViewController.m
//  Soupon
//
//  Created by Yuan on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//	第二个页面，包括优惠信息列表，根据条件进行搜索实现

#import "SPSecondViewController.h"
#import "SPCell.h"
#import "Status.h"
#import "SPCommon.h"
#import "SPPartition.h"

@interface SPSecondViewController (){
	int cl,br,bu;
}

@end

@implementation SPSecondViewController
@synthesize classifyButton;
@synthesize brandButton;
@synthesize businessButton;
@synthesize tabelView,cityData;




- (void)dealloc{
	[tabelView release];
	[cityData release];
	[rightItem release];
	[classifyButton release];
	[brandButton release];
	[businessButton release];
	[super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.title = NSLocalizedString(@"优惠搜索", @"优惠搜索");
		self.tabBarItem.image = [UIImage imageNamed:@"2.png"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
	[self.tabBarController.navigationItem setLeftBarButtonItem:nil];
	[self.tabBarController.navigationItem setRightBarButtonItem:rightItem];
	self.tabBarController.title = @"优惠搜索";
	
	NSUserDefaults *aDe = [NSUserDefaults standardUserDefaults];
	if ([aDe boolForKey:@"show"]) {
		cl =[[aDe objectForKey:@"cid"]intValue];
		br =[[aDe objectForKey:@"bid"]intValue];
		bu =[[aDe objectForKey:@"diid"]intValue];
		classifyButton.titleLabel.text = [aDe objectForKey:@"c"];
		businessButton.titleLabel.text = [aDe objectForKey:@"d"];
		brandButton.titleLabel.text = [aDe objectForKey:@"b"];
		NSString *s = [NSString stringWithFormat:@"http://www.sltouch.com/soupon/mobile/couponlist.aspx?category=%d&brand=%d&district=%d&begin=0&max=10",cl,br,bu];
		NSLog(@"sss%@",s);
		NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
		NSString *caString =  [NSString stringWithContentsOfURL:[NSURL URLWithString:s] usedEncoding:&encode error:nil];
		NSLog(@"%@",caString);
		searchArray = [[SPCommon parserXML:caString type:xHotlist]copy];
		[tabelView reloadData:YES];
	}
	
	
	[aDe setBool:NO forKey:@"show"];

}
							


- (void)viewDidLoad
{
    [super viewDidLoad];
	cl = br = bu = 0;
	
	
	
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
	
	
	tabelView  = [[PullToRefreshTableView alloc]initWithFrame:CGRectMake(0, 20, 320, 367)];
	tabelView.dataSource = self;
	tabelView.delegate = self;
	tabelView.tag = 10;
	if (isIPhone5) {
		CGRect mainRect = self.view.frame;  
		mainRect.size.height = ScreenHeight;  
		self.view.frame = mainRect; 
		
		CGRect rect = tabelView.frame;
		CGRect r =  CGRectMake(0, 0, 320, 456);
		rect.origin.y = MainHeight - rect.size.height;
		tabelView.frame = r; 
	}
	
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)parser{
	NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSString *categoryString =  [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PARTITION,@"category"]] usedEncoding:&encode error:nil];
	NSString *brandString =  [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PARTITION,@"brand"]] usedEncoding:&encode error:nil];
	NSString *districtString =  [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PARTITION,@"district"]] usedEncoding:&encode error:nil];
	NSString *hotstring =  [NSString stringWithContentsOfURL:[NSURL URLWithString:HOTLIST] usedEncoding:&encode error:nil];
	
	brandArray = [[SPCommon parserXML:brandString type:xPartitionB]copy];
	categoryhArray = [[SPCommon parserXML:categoryString type:xPartitionC]copy];
	districtArray = [[SPCommon parserXML:districtString type:xPartitionD]copy];
	
	//NSLog(@"error:%@\n",hotstring);
	if (![hotstring isEqualToString:@""]) {
		searchArray = [[SPCommon parserXML:hotstring type:xHotlist]copy];
	}else {
		NSLog(@"error");
	}
	dispatch_async(dispatch_get_main_queue(), ^{[self.view addSubview:tabelView];});
	
}

- (void)rightItemClicked{
	if ([classifyButton.titleLabel.text isEqualToString: @"全部分类"]) {
		cl = 0;
	}
	if ([brandButton.titleLabel.text isEqualToString: @"全部品牌"]) {
		br = 0;
	}
	if ([businessButton.titleLabel.text isEqualToString: @"全部商圈"]) {
		bu = 0;
	}
	NSString *s = [NSString stringWithFormat:@"http://www.sltouch.com/soupon/mobile/couponlist.aspx?category=%d&brand=%d&district=%d&begin=0&max=10",cl,br,bu];

	NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSString *caString =  [NSString stringWithContentsOfURL:[NSURL URLWithString:s] usedEncoding:&encode error:nil];
	NSLog(@"%@",caString);
	searchArray = [[SPCommon parserXML:caString type:xHotlist]copy];
	[tabelView reloadData:YES];
}

- (IBAction)clicked:(id)sender{
	UITableViewController *controller = [[UITableViewController alloc]init];
	controller.tableView.delegate =self;
	controller.tableView.dataSource = self;
	if (sender == classifyButton) {
		controller.tableView.tag = 1;
	}
	if (sender == brandButton) {
		controller.tableView.tag = 2;
	}
	if (sender == businessButton) {
		controller.tableView.tag = 3;
	}
    popover = [[FPPopoverController alloc] initWithViewController:controller];
    [controller release];

    popover.tint = FPPopoverLightGrayTint;
    popover.arrowDirection = FPPopoverArrowDirectionAny;
	popover.contentSize = CGSizeMake(200, 350);
    
    [popover presentPopoverFromView:sender];
}

- (void)viewDidUnload
{
	[self setClassifyButton:nil];
	[self setBrandButton:nil];
	[self setBusinessButton:nil];
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
- (void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[tableView1 deselectRowAtIndexPath:indexPath animated:YES];
	if (tableView1.tag == 10) {
		if (!con) {
			con = [[SPShowInfoViewController alloc]init];
		}
		SPHotData *b = (SPHotData*)[searchArray objectAtIndex:indexPath.row];
		NSString *s = [NSString stringWithFormat:@"%@%@",SHOWINFO,b.s_hotid];
		//NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
		//NSString *hotstring =  [NSString stringWithContentsOfURL:[NSURL URLWithString:s] usedEncoding:&encode error:nil];
		//NSLog(@"%@",hotstring);
		[con setAll:s];
		[self.navigationController pushViewController:con animated:YES];
	}
	SPPartition *datas = nil;
	switch (tableView1.tag) {
		case 1:
			datas = [categoryhArray objectAtIndex:indexPath.row];
			classifyButton.titleLabel.text = datas.s_caption;
			cl = [datas.s_id intValue];
			break;
		case 2:
			datas = [brandArray objectAtIndex:indexPath.row];
			brandButton.titleLabel.text = datas.s_caption;
			br = [datas.s_id intValue];
			break;
		case 3:
			datas = [districtArray objectAtIndex:indexPath.row];
			businessButton.titleLabel.text = datas.s_caption;
			bu = [datas.s_id intValue];
			break;
		default:
			break;
	}
	[popover dismissPopoverAnimated:YES];
	
	
}

- (NSInteger )tableView:(UITableView *)tableView1 numberOfRowsInSection:(NSInteger)section{
	if (tableView1.tag== 10) {
		return [searchArray count];
	}
	int i = 0;
	switch (tableView1.tag) {
		case 1:
			i = [categoryhArray count];
			break;
		case 2:
			i =[brandArray count];
			break;
		case 3:
			i = [districtArray count];
			break;
		default:
			break;
	}
	return i;
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	if (tableView1.tag==10) {
		HJManagedImageV* mi;
		SPCell *cell = (SPCell *)[tableView1 dequeueReusableCellWithIdentifier:@"SPCell"];
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
	
	UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	SPPartition *datas = nil;
	switch (tableView1.tag) {
		case 1:
			datas = [categoryhArray objectAtIndex:indexPath.row];
			break;
		case 2:
			datas = [brandArray objectAtIndex:indexPath.row];
			//cell.textLabel.font = [UIFont fontWithName:@"Arial" size:17];
			break;
		case 3:
			datas = [districtArray objectAtIndex:indexPath.row];
			
			break;
		default:
			break;
	}
	cell.textLabel.text = datas.s_caption;
	return cell;
	
}

-(CGFloat)tableView:(UITableView *)tableView1 heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{	
	if (tableView1.tag == 10) {
		return 70;
	}
	return 40;
}

@end
