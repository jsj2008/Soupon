//
//  Status.h
//  Soupon
//
//  Created by rjxy rjxy on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#ifndef Soupon_Status_h
#define Soupon_Status_h

#define HOTLIST @"http://www.sltouch.com/soupon/hotlist.aspx?city=1&begin=1&max=10"
#define GETIMAGE @"http://www.sltouch.com/soupon/upload/"
#define SEARCHLIST @"http://www.sltouch.com/soupon/couponlist.aspx?category=%@&brand=%@&district=%@&begin=%@&max=%@"
#define KEYSEARCH @"http://www.sltouch.com/soupon/match.aspx?object=%@&keyword=%@"
#define GETCITYS @"http://www.sltouch.com/soupon/citylist.aspx"
#define CHECKUSER @"http://www.sltouch.com/soupon/register.aspx?action=%@&phone=%@&password=%@&email=%@"
#define SEARCHAROUND @"http://www.sltouch.com/soupon/nearby.aspx?x=%@&y=%@&begin=%@&max=%@"
#define SHOWINFO @"http://www.sltouch.com/soupon/detail.aspx?couponid=%@"
#define ADS @"http://www.sltouch.com/soupon/adbanner.aspx"


typedef enum{
	xHotlist = 0,
    xGetImage = 1,
	xSearchlist = 2,
	xGetcitys = 3,
	xCheckuser = 4,
	xSearcharound = 5,
	xShowinfo = 6,
	xAds = 7,
}ParserType;

typedef enum{
	xCategory = 0,
    xBrand = 1,
	xDistrict = 2,
}KeySearchType;

#endif
