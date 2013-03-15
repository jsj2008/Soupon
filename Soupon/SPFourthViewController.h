//
//  SPFourthViewController.h
//  Soupon
//
//  Created by rjxy rjxy on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPFourthViewController : UIViewController<UIScrollViewDelegate>
{
	UIPageControl *pageCon;
}

@property (retain, nonatomic) IBOutlet UIButton *myFavorable;
@property (retain, nonatomic) IBOutlet UIButton *myAttention;
@property (retain, nonatomic) IBOutlet UIButton *nwCourse;
@property (retain, nonatomic) IBOutlet UIButton *aboutUs;
@property (retain, nonatomic) IBOutlet UIButton *guess;

- (IBAction)clicked:(id)sender;
@end
