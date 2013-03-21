//
//  SPLoginViewController.h
//  Soupon
//
//  Created by rjxy rjxy on 13-3-15.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCheckUser.h"

@interface SPLoginViewController : UIViewController<UITextFieldDelegate,NSXMLParserDelegate>
{
	SPCheckUser *user;
	NSMutableDictionary *d;
}

@property (retain, nonatomic) IBOutlet UITextField *phoneTextField;
@property (retain, nonatomic) IBOutlet UITextField *pawTextField;
@property (retain, nonatomic) IBOutlet UIButton *registerButton;
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@property (retain, nonatomic) IBOutlet UIButton *toRe;
@property (retain, nonatomic) IBOutlet UIButton *backButton;
@property (retain, nonatomic) IBOutlet UIView *reView;
@property (retain, nonatomic) IBOutlet UIView *fView;
@property (retain, nonatomic) IBOutlet UITextField *phoneTextField2;
@property (retain, nonatomic) IBOutlet UITextField *pawTextField2;
@property (retain, nonatomic) IBOutlet UITextField *checkpsdTextField;

- (IBAction)login:(id)sender;
- (IBAction)regist:(id)sender;
- (IBAction)toR:(id)sender;
- (IBAction)btnCancel:(id) sender;
@end
