//
//  SPSecondViewController.m
//  Soupon
//
//  Created by rjxy rjxy on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPSecondViewController.h"

@interface SPSecondViewController ()

@end

@implementation SPSecondViewController

- (void)dealloc{


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
	
	rightItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClicked)];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)rightItemClicked{

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

@end
