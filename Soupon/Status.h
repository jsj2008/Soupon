//
//  Status.h
//  Soupon
//
//  Created by rjxy rjxy on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#ifndef Soupon_Status_h
#define Soupon_Status_h

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

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height  
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width  
#define StateBarHeight 20  
#define MainHeight (ScreenHeight - StateBarHeight)  
#define MainWidth ScreenWidth  
#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


typedef enum{
	xHotlist = 0,
    xGetImage = 1,
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

typedef enum{
	xCategory = 0,
    xBrand = 1,
	xDistrict = 2,
}KeySearchType;

#endif
