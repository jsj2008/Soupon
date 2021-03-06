//
//  SPCommon.m
//  Soupon
//
//  Created by Yuan on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPCommon.h"
#import "SPCityData.h"
#import "SPAdsData.h"
#import "SPHotData.h"
#import "SPShowInfo.h"
#import "SPAroundInfo.h"
#import "SPCheckUser.h"
#import "SPPartition.h"

@implementation SPCommon
//解析XML
+(NSMutableArray*)parserXML:(NSString *)dataString type:(ParserType)type{
	if (!dataString) {
		return nil;
	}
	NSMutableArray *dataArray = [[[NSMutableArray alloc]init]autorelease];
	TBXML *tbXml = [TBXML tbxmlWithXMLString:dataString];
    TBXMLElement * root = tbXml.rootXMLElement;
	if (type == xHotlist||type ==xSearchlist) {
		TBXMLElement *coupon = [TBXML childElementNamed:@"coupon" parentElement:root];
        while (coupon!=nil) {
            SPHotData *hot = [[SPHotData alloc] init];
            hot.s_hotid = [TBXML valueOfAttributeNamed:@"id" forElement:coupon];
            hot.s_caption = [TBXML valueOfAttributeNamed:@"caption" forElement:coupon];
            hot.s_description = [TBXML valueOfAttributeNamed:@"description" forElement:coupon];
            hot.s_icon = [TBXML valueOfAttributeNamed:@"icon" forElement:coupon];
            hot.s_popularity = [TBXML valueOfAttributeNamed:@"popularity" forElement:coupon];
            coupon = [TBXML nextSiblingNamed:@"coupon" searchFromElement:coupon];
			
			[dataArray addObject:hot];
		    [hot release];
		}
		
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
		TBXMLElement *registers = [TBXML childElementNamed:@"register" parentElement:root];
		while (registers!=nil) {
            SPCheckUser *check = [[SPCheckUser alloc] init];
            check.s_result = [TBXML valueOfAttributeNamed:@"result" forElement:root];
            check.s_description = [TBXML valueOfAttributeNamed:@"description" forElement:root];
			
			[dataArray addObject:check];
		    [check release];
		}
		
	}
	if (type ==xSearcharound ) {
		TBXMLElement *node = [TBXML childElementNamed:@"node" parentElement:root];
        while (node!=nil) {
            SPAroundInfo *around = [[SPAroundInfo alloc] init];
            around.s_id = [TBXML valueOfAttributeNamed:@"id" forElement:node];
            around.s_caption = [TBXML valueOfAttributeNamed:@"caption" forElement:node];
            around.s_description = [TBXML valueOfAttributeNamed:@"description" forElement:node];
            around.s_icon = [TBXML valueOfAttributeNamed:@"icon" forElement:node];
            around.s_distance = [TBXML valueOfAttributeNamed:@"distance" forElement:node];
			around.s_address = [TBXML valueOfAttributeNamed:@"address" forElement:node];
			around.s_categoryid = [TBXML valueOfAttributeNamed:@"categoryid" forElement:node];
            around.s_categorycaption = [TBXML valueOfAttributeNamed:@"categorycaption" forElement:node];
            around.s_brandcaption = [TBXML valueOfAttributeNamed:@"brandcaption" forElement:node];
            around.s_brandid = [TBXML valueOfAttributeNamed:@"brandid" forElement:node];
            around.s_districtcaption = [TBXML valueOfAttributeNamed:@"districtcaption" forElement:node];
			around.s_districtid = [TBXML valueOfAttributeNamed:@"districtid" forElement:node];
			
            node = [TBXML nextSiblingNamed:@"node" searchFromElement:node];
			
			[dataArray addObject:around];
		    [around release];
		}

	}

	if (type == xAds) {
		TBXMLElement *ads = [TBXML childElementNamed:@"ad" parentElement:root];
		while (ads!=nil) {
			SPAdsData *data = [[SPAdsData alloc]init];
			data.s_adID =[TBXML valueOfAttributeNamed:@"id" forElement:ads];
			data.s_adName = [TBXML valueOfAttributeNamed:@"poster" forElement:ads];
			data.s_adURL = [TBXML valueOfAttributeNamed:@"url" forElement:ads];
			ads = [TBXML nextSiblingNamed:@"ad" searchFromElement:ads];
			[dataArray addObject:data];
			[data release];
		}
	}
	if (type == xPartitionB||type == xPartitionC||type == xPartitionD) {
		NSString *string = @"";
		switch (type) {
			case xPartitionB:
				string = @"brand";
				break;
				
			case xPartitionC:
				string = @"category";
				break;	
			case xPartitionD:
				string = @"district";
				break;
			default:
				break;
		}
		TBXMLElement *ads = [TBXML childElementNamed:string parentElement:root];
		while (ads!=nil) {
			SPPartition *data = [[SPPartition alloc]init];
			data.s_id =[TBXML valueOfAttributeNamed:@"id" forElement:ads];
			data.s_caption = [TBXML valueOfAttributeNamed:@"caption" forElement:ads];
			data.s_keyword = [TBXML valueOfAttributeNamed:@"keyword" forElement:ads];
			ads = [TBXML nextSiblingNamed:string searchFromElement:ads];
			[dataArray addObject:data];
			[data release];
		}
	}
	
	return dataArray;
}

+ (NSMutableArray *)parserKeySearchXML:(NSString *)dataString type:(KeySearchType)type{
	NSMutableArray *dataArray = [[[NSMutableArray alloc]init]autorelease];
	TBXML *tbXml = [TBXML tbxmlWithXMLString:dataString];
    TBXMLElement * root = tbXml.rootXMLElement;
	if (type == xCategory) {
		TBXMLElement *category = [TBXML childElementNamed:@"category" parentElement:root];
        while (category!=nil) {
            
		}
		
	}

	return dataArray;
}

+ (BOOL)check:(NSString *)string{
	//获取应用程序沙盒的Documents目录
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *plistPath1 = [paths objectAtIndex:0];
	//得到完整的文件名
	NSString *filename=[plistPath1 stringByAppendingPathComponent:@"test.plist"];

	//读出来看看
	NSDictionary* data1 = [[NSDictionary alloc] initWithContentsOfFile:filename];
	
	for (NSString *s in data1) {
		if ([s isEqualToString:string]) return YES;
	}
	return NO;
}

@end