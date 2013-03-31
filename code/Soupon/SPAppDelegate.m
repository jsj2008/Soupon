//
//  SPAppDelegate.m
//  Soupon
//
//  Created by Yuan on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPAppDelegate.h"

#import "SPFirstViewController.h"

#import "SPSecondViewController.h"

#import "SPThirdViewController.h"

#import "SPFourthViewController.h"

#import "Status.h"

@implementation SPAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize navController = _navController;

- (void)dealloc
{
	[_window release];
	[_tabBarController release];
	[_navController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[[UIApplication sharedApplication]setStatusBarHidden:NO];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
	UIViewController *viewController1 = [[[SPFirstViewController alloc] initWithNibName:@"SPFirstViewController" bundle:nil] autorelease];
	UIViewController *viewController2 = [[[SPSecondViewController alloc] initWithNibName:@"SPSecondViewController" bundle:nil] autorelease];
	UIViewController *viewController3 = [[[SPThirdViewController alloc] initWithNibName:@"SPThirdViewController" bundle:nil] autorelease];
	UIViewController *viewController4 = [[[SPFourthViewController alloc] initWithNibName:@"SPFourthViewController" bundle:nil] autorelease];
	UIImage *dImage = [UIImage imageNamed:@"tbg.png"];
	self.tabBarController = [[[UITabBarController alloc] init] autorelease];
	self.tabBarController.tabBar.selectedImageTintColor = [UIColor whiteColor];
	
	self.tabBarController.tabBar.selectionIndicatorImage = dImage;
	
	self.navController = [[[UINavigationController alloc] initWithRootViewController:self.tabBarController]autorelease];
	self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, viewController3,viewController4,nil];
	self.navController.navigationBar.tintColor = NavBarColor;

	UIImageView * i = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hot_bar_bg.png"]] autorelease];
	i.frame = CGRectMake(0, 0, 320, 44);
	//[self.navController.navigationBar insertSubview:i atIndex:1];
	[self.navController.navigationBar setBackgroundImage:i.image forBarMetrics:UIBarMetricsDefault];
	
	self.window.rootViewController = self.navController;
	
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//// Optional UITabBarControllerDelegate method.
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//	NSLog(@"selel");
//	self.navController.navigationItem.title = @"erererer";
//}
//
//
//
//// Optional UITabBarControllerDelegate method.
//- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
//{
//	NSLog(@"end");
//}


@end
