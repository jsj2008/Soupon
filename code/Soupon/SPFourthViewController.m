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
		self.title = NSLocalizedString(@"我的优惠", @"");
		self.tabBarItem.image = [UIImage imageNamed:@"4.png"];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
	NSLog(@"ou");
	NSUserDefaults *aDe = [NSUserDefaults standardUserDefaults];
	if ([aDe boolForKey:@"show"]) {
		self.tabBarController.selectedIndex = 1;
	}
	[self.tabBarController.navigationItem setLeftBarButtonItem:nil];
	[self.tabBarController.navigationItem setRightBarButtonItem:nil];
	[self.navigationController setNavigationBarHidden:YES];
	[self.tabBarController.navigationItem setTitle:@"我的优惠"];
}

- (void)viewDidLoad
{	
    [super viewDidLoad];
	[self.myAttention setBackgroundImage:[UIImage imageNamed:@"mycoupon_on.png"] forState:UIControlStateNormal];
	[self.myAttention setBackgroundImage:[UIImage imageNamed:@"mycoupon_down.png"] forState:UIControlStateHighlighted];
	
	[self.myFavorable setBackgroundImage:[UIImage imageNamed:@"myshop_on.png"] forState:UIControlStateNormal];
	[self.myFavorable setBackgroundImage:[UIImage imageNamed:@"myshop_down.png"] forState:UIControlStateHighlighted];
	
	[self.aboutUs setBackgroundImage:[UIImage imageNamed:@"about_on.png"] forState:UIControlStateNormal];
	[self.aboutUs setBackgroundImage:[UIImage imageNamed:@"about_down.png"] forState:UIControlStateHighlighted];
	
	[self.guess setBackgroundImage:[UIImage imageNamed:@"guess_on.png"] forState:UIControlStateNormal];
	[self.guess setBackgroundImage:[UIImage imageNamed:@"guess_down.png"] forState:UIControlStateHighlighted];
	
	[self.nwCourse setBackgroundImage:[UIImage imageNamed:@"new_on.png"] forState:UIControlStateNormal];
	[self.nwCourse setBackgroundImage:[UIImage imageNamed:@"new_down.png"] forState:UIControlStateHighlighted];
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

		[self.tabBarController.navigationItem setTitle:@"退出"];	
		[self.navigationController setNavigationBarHidden:NO];
		
		UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"aboutus_bg.png"]];
		[viewCon setView:imageView];
		[imageView release];
	}else if (sender == guess) {
		[self.tabBarController.navigationItem setTitle:@"退出"];
		if (![[NSUserDefaults standardUserDefaults]objectForKey:@"phone"]) {
			SPLoginViewController *loginCon = [[[SPLoginViewController alloc]init]autorelease];
			[self presentModalViewController:loginCon animated:YES];
			[viewCon release];
			return;
		}

			
		[self.navigationController setNavigationBarHidden:NO];
		NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
		NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"http://www.sltouch.com/soupon/mobile/guess.aspx?phone=",phone]]];
		
		UIWebView *webView = [[UIWebView alloc]init];
		[webView loadRequest:request];
		[viewCon setView:webView];
		[webView release];
	}else if (sender == nwCourse) {

		[self.tabBarController.navigationItem setTitle:@"退出"];	
		[self.navigationController setNavigationBarHidden:NO];
		
		scrollView = [[APScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height+44)];
		
		scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 4, self.view.frame.size.height+44);
		scrollView.pagingEnabled = YES;
		
		UIImageView *im1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+44)];
		UIImageView *im2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height+44)];
		UIImageView *im3 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2, 0, self.view.frame.size.width,self.view.frame.size.height+44)];
		UIImageView *im4 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3, 0, self.view.frame.size.width, self.view.frame.size.height+44)];
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
		
		
		
		[scrollView addSubview:im1];
		[scrollView addSubview:im2];
		[scrollView addSubview:im3];
		[scrollView addSubview:im4];
		
		
		[im1 release];
		[im2 release];
		[im3 release];
		[im4 release];
		[viewCon setView:scrollView];
		
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
		//myAttention.selected = !myAttention.selected;
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

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    
//    int page =scrollView.bounds.origin.x/160;
//    [pageCon setCurrentPage:page];
//}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
