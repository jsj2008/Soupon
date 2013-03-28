//
//  SPFourthViewController.h
//  Soupon
//
//  Created by Yuan on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCollectViewController.h"
#import "SPStoresViewController.h"

@interface SPFourthViewController : UIViewController<UIScrollViewDelegate>
{
	UIPageControl *pageCon;
	SPCollectViewController *conC;
	SPStoresViewController *conCstore;
}

@property (retain, nonatomic) IBOutlet UIButton *myFavorable;
@property (retain, nonatomic) IBOutlet UIButton *myAttention;
@property (retain, nonatomic) IBOutlet UIButton *nwCourse;
@property (retain, nonatomic) IBOutlet UIButton *aboutUs;
@property (retain, nonatomic) IBOutlet UIButton *guess;

@property (retain, nonatomic) IBOutlet UIImageView *im;
- (IBAction)clicked:(id)sender;
@end
