//
//  SPCollectViewController.m
//  Soupon
//
//  Created by Yuan on 13-3-19.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPCollectViewController.h"
#import "Status.h"
#import "SPCell.h"

@interface SPCollectViewController ()

@end

@implementation SPCollectViewController
@synthesize tabel ,dataSource = dataSource_;
//#ifdef _FOR_DEBUG_  
//-(BOOL) respondsToSelector:(SEL)aSelector {  
//    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);  
//    return [super respondsToSelector:aSelector];  
//}  
//#endif
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	tabel = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 416) style:UITableViewStylePlain];
	tabel.delegate = self;
	tabel.dataSource  =self;
	[self.view addSubview:tabel];
	if (isIPhone5) {
		CGRect mainRect = self.view.frame;  
		mainRect.size.height = ScreenHeight;  
		self.view.frame = mainRect; 
		
		CGRect rect = tabel.frame;
		CGRect r =  CGRectMake(0, 0, 320, 456);
		rect.origin.y = MainHeight - rect.size.height;
		tabel.frame = r; 
	}
	
	//获取应用程序沙盒的Documents目录  
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);  
	NSString *plistPath1 = [paths objectAtIndex:0]; 
	//得到完整的文件名  
	NSString *filename=[plistPath1 stringByAppendingPathComponent:@"test.plist"];  
	
	
	//读出来看看  
	data1 = [[NSDictionary alloc] initWithContentsOfFile:filename];  
	NSMutableArray *aa = [[NSMutableArray alloc]init];
	for (NSString *s in data1) {
		if (![s isEqualToString:@"c_key"]) {
			[aa addObject:s];
			NSLog(@"ddd:%@",s);
		}
	}
	
	self.dataSource = aa;
	//[self searchData];
}

- (void)loadDa{
	//获取应用程序沙盒的Documents目录  
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);  
	NSString *plistPath1 = [paths objectAtIndex:0]; 
	//得到完整的文件名  
	NSString *filename=[plistPath1 stringByAppendingPathComponent:@"test.plist"];  
	
	
	//读出来看看  
	data1 = [[NSDictionary alloc] initWithContentsOfFile:filename];  
	NSMutableArray *aa = [[NSMutableArray alloc]init];
	for (NSString *s in data1) {
		if (![s isEqualToString:@"c_key"]) {
			[aa addObject:s];
			NSLog(@"ddd:%@",s);
		}
		
	}
	
	self.dataSource = aa;
	[tabel reloadData];
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

- (void)deleteCollect:(id)sender{}
#pragma marked TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (dataSource_!=nil) {
		return [dataSource_ count];
	}
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger r = [indexPath row];
	NSString *da = [dataSource_ objectAtIndex:r];NSLog(@"rrr:%@",da);
	NSDictionary *d = [data1 objectForKey:da];
	SPCell *cell = (SPCell *)[tableView dequeueReusableCellWithIdentifier:@"SPCell"];
	if (!cell) {
		cell = [[[SPCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SPCell"]autorelease];
		UIImageView*o = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sp.png"]];
		o.frame = CGRectMake(0,-1,65,70);
		[cell addSubview:o];
		
	}	
	SPHotData *h = [[SPHotData alloc]init];
	h.s_caption = [d objectForKey:@"caption"];
	h.s_description = [d objectForKey:@"content"];
	h.s_popularity = [d objectForKey:@"indate"];
	[cell setHotData:h];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSInteger r = [indexPath row];
	NSString *da = [dataSource_ objectAtIndex:r];
	NSDictionary *d = [data1 objectForKey:da];
	
	SPShowInfoViewController *viewCon = [[SPShowInfoViewController alloc]init];
	[viewCon setCollect:d];
	[viewCon setButtonHidden];
	[self.navigationController pushViewController:viewCon animated:YES];
	[viewCon release];
}

-(CGFloat)tableView:(UITableView *)tableViews heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{
    return 70;
}

@end
