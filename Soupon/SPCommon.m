//
//  SPCommon.m
//  Soupon
//
//  Created by rjxy rjxy on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPCommon.h"
#import "SPCityData.h"
#import "SPAdsData.h"
#import "SPHotData.h"

@implementation SPCommon

+(NSMutableArray*)parserXML:(NSString *)dataString type:(ParserType)type{
	if (!dataString) {
		return nil;
	}
	NSMutableArray *dataArray = [[NSMutableArray alloc]init];
	TBXML *tbXml = [TBXML tbxmlWithXMLString:dataString];
    TBXMLElement * root = tbXml.rootXMLElement;
	if (type == xHotlist) {
		TBXMLElement *coupon = [TBXML childElementNamed:@"coupon" parentElement:root];
        while (coupon!=nil) {
            
            SPHotData *hot = [[SPHotData alloc] init];
            hot.s_hotid = [TBXML valueOfAttributeNamed:@"id" forElement:coupon];
            hot.s_caption = [TBXML valueOfAttributeNamed:@"caption" forElement:coupon];
            hot.s_description = [TBXML valueOfAttributeNamed:@"description" forElement:coupon];
            hot.s_icon = [TBXML valueOfAttributeNamed:@"icon" forElement:coupon];
            hot.s_popularrity = [TBXML valueOfAttributeNamed:@"popularity" forElement:coupon];
            coupon = [TBXML nextSiblingNamed:@"coupon" searchFromElement:coupon];
			
			[dataArray addObject:hot];
		    [hot release];
		}
		
	}
	if (type == xGetImage) {
		TBXMLElement *hotlist = [TBXML childElementNamed:@"info" parentElement:root];
	}
	if (type == xSearchlist) {
		TBXMLElement *hotlist = [TBXML childElementNamed:@"info" parentElement:root];
	}
	if (type == xKeysearch) {
		TBXMLElement *hotlist = [TBXML childElementNamed:@"info" parentElement:root];
	}
	if (type == xGetcitys) {
		TBXMLElement *city = [TBXML childElementNamed:@"city" parentElement:root];
		while (city != nil) {
			SPCityData *data = [[SPCityData alloc]init];
			data.s_cityID = [TBXML valueOfAttributeNamed:@"id" forElement:city];
			data.s_cityCaption = [TBXML valueOfAttributeNamed:@"caption" forElement:city];
			
			city = [TBXML nextSiblingNamed:@"city" searchFromElement:city];
			[dataArray addObject:data];
		    [data release];
		}
	}
	
	if (type == xCheckuser) {
		TBXMLElement *hotlist = [TBXML childElementNamed:@"info" parentElement:root];
	}
	if (type ==xSearcharound ) {
		TBXMLElement *hotlist = [TBXML childElementNamed:@"info" parentElement:root];
	}
	if (type == xShowinfo) {
		TBXMLElement *hotlist = [TBXML childElementNamed:@"info" parentElement:root];
	}
	if (type == xAds) {
		TBXMLElement *ads = [TBXML childElementNamed:@"ad" parentElement:root];

		
			SPAdsData *data = [[SPAdsData alloc]init];

			
			data.s_adID =[TBXML valueOfAttributeNamed:@"ad" forElement:ads];
		
			//data.s_adName = [TBXML textForElement:adposter];
			//data.s_adURL = [TBXML textForElement:adurl];
			[dataArray addObject:data];
		    [data release];
			ads = [TBXML nextSiblingNamed:@"ad" searchFromElement:ads];
		
	}
	return nil;
}

@end