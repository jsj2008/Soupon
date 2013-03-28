//
//  Status.h
//  Soupon
//
//  Created by Yuan on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#ifndef Soupon_Status_h
#define Soupon_Status_h

//主要接口
#define HOTLIST @"http://www.sltouch.com/soupon/mobile/hotlist.aspx?city=1&begin=0&max=100"
#define GETIMAGE @"http://www.sltouch.com/soupon/mobile/upload/"
#define SEARCHAROUND @"http://www.sltouch.com/soupon/mobile/nearby.aspx?x=121.29&y=31.11&begin=0&max=10"
#define GETCITYS @"http://www.sltouch.com/soupon/mobile/citylist.aspx"
#define ADS @"http://www.sltouch.com/soupon/mobile/adbanner.aspx"
#define SHOWINFO @"http://www.sltouch.com/soupon/mobile/detail.aspx?couponid="
#define SEARCHLIST @"http://www.sltouch.com/soupon/mobile/couponlist.aspx?category=%@&brand=%@&district=%@&begin=%@&max=%@"
#define PARTITION @"http://www.sltouch.com/soupon/mobile/match.aspx?object="

#define KEYSEARCH @"http://www.sltouch.com/soupon/mobile/match.aspx?object=%@&keyword=%@"
#define CHECKUSER @"http://www.sltouch.com/soupon/mobile/register.aspx?action=%@&phone=%@&password=%@&email=%@"

//判断iphone5
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height  
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width  
#define StateBarHeight 20  
#define MainHeight (ScreenHeight - StateBarHeight)  
#define MainWidth ScreenWidth  
#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//设置详细信息背景界面
#define InfoColor  [UIColor colorWithRed:245.0f/255.0f green:254.0f/255.0f blue:191.0f/255.0f alpha:1.0]

//所有页面导航栏颜色设置
#define NavBarColor [UIColor colorWithRed:150.00f/255.0f green:0 blue:0 alpha:1]


//解析返回内容的类型
typedef enum{
	xHotlist = 0,               //热门优惠类型
    xGetImage = 1,				//获取图片类型
	xSearchlist = 2,
	xGetcitys = 3,
	xCheckuser = 4,
	xSearcharound = 5,
	xShowinfo = 6,
	xAds = 7,
	xPartitionC = 8,
	xPartitionB = 9,
	xPartitionD = 10,
}ParserType;


//搜索分类
typedef enum{
	xCategory = 0,
    xBrand = 1,
	xDistrict = 2,
}KeySearchType;

#endif
