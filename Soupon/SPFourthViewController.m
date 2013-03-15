//
//  SPFourthViewController.m
//  Soupon
//
//  Created by rjxy rjxy on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPFourthViewController.h"
#import "SPLoginViewController.h"

@interface SPFourthViewController ()

@end

@implementation SPFourthViewController
@synthesize myFavorable;
@synthesize myAttention;
@synthesize nwCourse;
@synthesize aboutUs;
@synthesize guess;

- (void)dealloc{
	
	[myFavorable release];
	[myAttention release];
	[nwCourse release];
	[aboutUs release];
	[guess release];
	[super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.title = NSLocalizedString(@"我的优惠", @"我的优惠");
		self.tabBarItem.image = [UIImage imageNamed:@"second"];
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
}

- (void)viewDidUnload
{
	[self setMyFavorable:nil];
	[self setMyAttention:nil];
	[self setNwCourse:nil];
	[self setAboutUs:nil];
	[self setGuess:nil];
    [super viewDidUnload];
}

- (IBAction)clicked:(id)sender{
	UIViewController *viewCon = [[UIViewController alloc]init];
	if (sender == aboutUs) {
		UIImageView *imageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"aboutus_bg.png"]]autorelease];
		[viewCon setView:imageView];
		
	}else if (sender == guess) {
		NSURLRequest *request =[[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]autorelease];
		
		UIWebView *webView = [[UIWebView alloc]init];
		[webView loadRequest:request];
		[viewCon setView:webView];
	}else if (sender == nwCourse) {
		NSLog(@"dsd:%@",self.parentViewController.parentViewController);
		UINavigationController *c = (UINavigationController *)self.parentViewController.parentViewController;
		c.navigationBar.tintColor = [UIColor colorWithRed:150.00f/255.0f green:0 blue:0 alpha:0.4];
		UIScrollView *view = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, 320, 460)];
		view.delegate =self;
		view.contentSize = CGSizeMake(4*320, 460) ;
		UIImageView *im1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
		UIImageView *im2 = [[UIImageView alloc]initWithFrame:CGRectMake(320, 0, 320, 480)];
		UIImageView *im3 = [[UIImageView alloc]initWithFrame:CGRectMake(640, 0, 320, 480)];
		UIImageView *im4 = [[UIImageView alloc]initWithFrame:CGRectMake(960, 0, 320, 480)];
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
		SPLoginViewController *loginCon = [[SPLoginViewController alloc]init];
		[viewCon setView:loginCon.view];
		
	}else if (sender == myAttention) {
		
	}

	[self.navigationController pushViewController:viewCon animated:YES];
	[viewCon release];

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int page =scrollView.bounds.origin.x/160;
    NSLog(@"sd:%d",page);
    [pageCon setCurrentPage:1];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
