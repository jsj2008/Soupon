//
//  SPFourthViewController.m
//  Soupon
//
//  Created by Yuan on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPFourthViewController.h"
#import "SPLoginViewController.h"
#import "SPCommon.h"
#import "SPCollectViewController.h"
#import "SPStoresViewController.h"

@interface SPFourthViewController ()

@end

@implementation SPFourthViewController
@synthesize myFavorable;
@synthesize myAttention;
@synthesize nwCourse;
@synthesize aboutUs;
@synthesize guess;
@synthesize im;

- (void)dealloc{
	
	[myFavorable release];
	[myAttention release];
	[nwCourse release];
	[aboutUs release];
	[guess release];
    [im release];
	[super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.title = NSLocalizedString(@"我的优惠", @"我的优惠");
		self.tabBarItem.image = [UIImage imageNamed:@"4.png"];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
	[self.tabBarController.navigationItem setLeftBarButtonItem:nil];
	[self.tabBarController.navigationItem setRightBarButtonItem:nil];
	[self.tabBarController.navigationItem setTitle:@"我的优惠"];
}

- (void)viewDidLoad
{	
    [super viewDidLoad];
	if (isIPhone5) {
		CGRect mainRect = self.view.frame;
		mainRect.size.height = ScreenHeight;
		self.view.frame = mainRect;
		
		CGRect r =  CGRectMake(0, -25, 320, 480);
		im.frame = r;
	}
}

- (void)viewDidUnload
{
	[self setMyFavorable:nil];
	[self setMyAttention:nil];
	[self setNwCourse:nil];
	[self setAboutUs:nil];
	[self setGuess:nil];
    [self setIm:nil];
    [super viewDidUnload];
}

- (IBAction)clicked:(id)sender{
	UIViewController *viewCon = [[UIViewController alloc]init];
	if (sender == aboutUs) {
		UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"aboutus_bg.png"]];
		[viewCon setView:imageView];
		[imageView release];
	}else if (sender == guess) {
		if (![[NSUserDefaults standardUserDefaults]objectForKey:@"phone"]) {
			SPLoginViewController *loginCon = [[[SPLoginViewController alloc]init]autorelease];
			[self presentModalViewController:loginCon animated:YES];
			[viewCon release];
			return;
		}
		NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
		NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"http://www.sltouch.com/soupon/mobile/guess.aspx?phone=",phone]]];
		
		UIWebView *webView = [[UIWebView alloc]init];
		[webView loadRequest:request];
		[viewCon setView:webView];
		[webView release];
	}else if (sender == nwCourse) {
		
		UIScrollView *view = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, 320, 460)];
		view.delegate =self;
		view.contentSize = CGSizeMake(4*320, 0) ;
		UIImageView *im1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
		UIImageView *im2 = [[UIImageView alloc]initWithFrame:CGRectMake(320, 0, 320, 480)];
		UIImageView *im3 = [[UIImageView alloc]initWithFrame:CGRectMake(640, 0, 320, 480)];
		UIImageView *im4 = [[UIImageView alloc]initWithFrame:CGRectMake(960, 0, 320, 480)];
		if (isIPhone5) {
			[im1 setFrame:CGRectMake(0, 0, 320, 504)];
			[im2 setFrame:CGRectMake(320, 0, 320, 504)];
			[im3 setFrame:CGRectMake(640, 0, 320, 504)];
			[im4 setFrame:CGRectMake(960, 0, 320, 504)];
		}
		
		
		[im1 setImage:[UIImage imageNamed:@"help_1.png"]];
		[im2 setImage:[UIImage imageNamed:@"help_2.png"]];
		[im3 setImage:[UIImage imageNamed:@"help_3.png"]];
		[im4 setImage:[UIImage imageNamed:@"help_4.png"]];
		
		
		pageCon = [[UIPageControl alloc]init];
		pageCon.frame = CGRectMake(140, 400, 40, 30);
		pageCon.numberOfPages = 4;
		[pageCon updateCurrentPageDisplay];
		[view addSubview:pageCon];
		[view addSubview:im1];
		[view addSubview:im2];
		[view addSubview:im3];
		[view addSubview:im4];
		
		
		[im1 release];
		[im2 release];
		[im3 release];
		[im4 release];
		[pageCon release];
		[viewCon setView:view];
		
	}else if (sender == myFavorable){
		if (![[NSUserDefaults standardUserDefaults]objectForKey:@"phone"]) {
			SPLoginViewController *loginCon = [[[SPLoginViewController alloc]init]autorelease];
			[self presentModalViewController:loginCon animated:YES];
			[viewCon release];
			return;
		}
		
		if (conCstore ==  nil) {
			conCstore= [[SPStoresViewController alloc]init];
		}
		else{[conCstore loadDa];}
		[self.navigationController pushViewController:conCstore animated:YES];
		[viewCon release];
		return;
	}else if (sender == myAttention) {
		if (![[NSUserDefaults standardUserDefaults]objectForKey:@"phone"]) {
			SPLoginViewController *loginCon = [[[SPLoginViewController alloc]init]autorelease];
			[self presentModalViewController:loginCon animated:YES];
			[viewCon release];
			return;
		}
		if (conC ==  nil) {
			conC = [[SPCollectViewController alloc]init];
		}
		else{[conC loadDa];}
		[self.navigationController pushViewController:conC animated:YES];
		[viewCon release];
		return;
	}

	[self.navigationController pushViewController:viewCon animated:YES];
	[viewCon release];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int page =scrollView.bounds.origin.x/160;
    [pageCon setCurrentPage:page];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
