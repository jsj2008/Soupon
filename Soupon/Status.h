//
//  Status.h
//  Soupon
//
//  Created by rjxy rjxy on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#ifndef Soupon_Status_h
#define Soupon_Status_h

#define HOTLIST @"http://www.sltouch.com/soupon/hot.aspx?begin=%@&max=%@"
#define GETIMAGE @"http://www.sltouch.com/soupon/upload/"
#define SEARCHLIST @"http://www.sltouch.com/soupon/couponlist.aspx?category=%@&brand=%@&district=%@&begin=%@&max=%@"
#define KEYSEARCH @"http://www.sltouch.com/soupon/match.aspx?object=%@&keyword=%@"
#define GETCITYS @"http://www.sltouch.com/soupon/citylist.aspx"
#define CHECKUSER @"http://www.sltouch.com/soupon/register.aspx?action=%@&phone=%@&password=%@&email=%@"
#define SEARCHAROUNG @"http://www.sltouch.com/soupon/nearby.aspx?x=%@&y=%@&begin=%@&max=%@"
#define SHOWINFO @"http://www.sltouch.com/soupon/detail.aspx?couponid=%@"
#define ADS @"http://www.sltouch.com/soupon/adbanner.aspx"


typedef enum{
	xHotlist = 0,
    xGetImage = 1,
	xSearchlist = 2,
	xKeysearch = 3,
	xGetcitys = 4,
	xCheckuser = 5,
	xSearcharound = 6,
	xShowinfo = 7,
	xAds = 8,
}ParserType;


#endif