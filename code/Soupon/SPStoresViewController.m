//
//  SPStoresViewController.m
//  Soupon
//
//  Created by Yuan on 13-3-23.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPStoresViewController.h"
#import "SPCell.h"
#import "Status.h"
#import <QuartzCore/QuartzCore.h>

@interface SPStoresViewController (){
	int y;
	NSIndexPath *x;
}

@end

@implementation SPStoresViewController

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

- (void)viewWillAppear:(BOOL)animated{

	[self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.alertView.frame = CGRectMake(25, 80, 270, 182);
	self.alertView.layer.borderWidth = 5.0f;
	self.alertView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
	self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6);
	
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
	NSString *filename=[plistPath1 stringByAppendingPathComponent:@"store.plist"];  
	
	
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
	[aa release];
	//[self searchData];
}

- (void)loadDa{
	//获取应用程序沙盒的Documents目录  
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);  
	NSString *plistPath1 = [paths objectAtIndex:0]; 
	//得到完整的文件名  
	NSString *filename=[plistPath1 stringByAppendingPathComponent:@"store.plist"];  
	
	
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
	[aa release];
	[tabel reloadData];
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

- (IBAction)hide:(id)sender{
	[self.alertView removeFromSuperview];
    self.alertView.alpha = 0;
	self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
}

- (IBAction)attention:(id)sender{
	[dataSource_ removeObjectAtIndex:y];
	[tabel reloadData];
	
	//获取应用程序沙盒的Documents目录
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *plistPath1 = [paths objectAtIndex:0];
	
	//得到完整的文件名
	NSString *filename=[plistPath1 stringByAppendingPathComponent:@"store.plist"];
	NSMutableDictionary *plist = [NSMutableDictionary dictionaryWithContentsOfFile:filename];
	[plist removeObjectForKey:[dataSource_ objectAtIndex:y]];
	[plist writeToFile:filename atomically:YES];
	[self hide:nil];
}

- (IBAction)favorable:(id)sender{
	[self.alertView removeFromSuperview];
	NSString *da = [dataSource_ objectAtIndex:y];
	NSDictionary *d = [data1 objectForKey:da];
	
	NSUserDefaults *aDe = [NSUserDefaults standardUserDefaults];
	[aDe setObject:[d objectForKey:@"cid"] forKey:@"cid"];
	[aDe setObject:[d objectForKey:@"diid"] forKey:@"diid"];
	[aDe setObject:[d objectForKey:@"bid"] forKey:@"bid"];
	[aDe setObject:[d objectForKey:@"c"] forKey:@"c"];
	[aDe setObject:[d objectForKey:@"d"] forKey:@"d"];
	[aDe setObject:[d objectForKey:@"b"] forKey:@"b"];
	[aDe setBool:YES forKey:@"show"];
	[aDe synchronize];
	

	
	[self.navigationController popViewControllerAnimated:YES];
	
}




- (void)viewDidUnload
{
    [self setAlertView:nil];
	[self setStoreName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
	x = indexPath;
	NSInteger r = [indexPath row];
	NSString *da = [dataSource_ objectAtIndex:r];NSLog(@"rrr:%@",da);
	NSDictionary *d = [data1 objectForKey:da];
	SPHotData *h = [[SPHotData alloc]init];
	h.s_caption = [d objectForKey:@"caption"];
	
	
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"欢迎位临" message:h.s_caption delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"取消关注",@"店内优惠", nil];
	
	[alert show];
	[alert release];

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if( (0 == indexPath.section) && (indexPath.row != [dataSource_ count]) ){
		return UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleNone;
    }
}
	


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
		[o release];
		
	}	
	SPHotData *h = [[SPHotData alloc]init];
	h.s_caption = [d objectForKey:@"caption"];
	h.s_description = [d objectForKey:@"content"];
	h.s_popularity = [d objectForKey:@"indate"];
	[cell setHotData:h];
	[h release];
	
	return cell;
}



-(CGFloat)tableView:(UITableView *)tableViews heightForRowAtIndexPath:(NSIndexPath *)indexPath  
{
    return 70;
}



- (void)dealloc {
    [_alertView release];
	[_storeName release];
    [super dealloc];
}
@end