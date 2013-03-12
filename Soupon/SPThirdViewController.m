//
//  SPThirdViewController.m
//  Soupon
//
//  Created by rjxy rjxy on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPThirdViewController.h"

@interface SPThirdViewController ()

@end

@implementation SPThirdViewController

- (void)dealloc{
	
	
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

- (void)viewDidLoad
{
	rightItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClicked)];
	[self.tabBarController.navigationItem setRightBarButtonItem:rightItem];
	self.tabBarController.title = @"周边优惠";
	// Do any additional setup after loading the view, typically from a nib.
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

@end
