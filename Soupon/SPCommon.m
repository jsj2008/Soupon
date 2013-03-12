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

@implementation SPCommon

+(NSMutableArray*)parserXML:(NSString *)dataString type:(ParserType)type{
	if (!dataString) {
		return nil;
	}
//	NSMutableArray *dataArray = [[NSMutableArray alloc]init];
//	TBXML *tbXml = [TBXML tbxmlWithXMLString:dataString];
//    TBXMLElement * root = tbXml.rootXMLElement;
//	if (type == xHotlist) {
//		TBXMLElement *hotlist = [TBXML childElementNamed:@"info" parentElement:root];
//			while (hotlist != nil) {
//
//			}
//		}
//	
//	if (type == xGetImage) {
//		TBXMLElement *hotlist = [TBXML childElementNamed:@"info" parentElement:root];
//	}
//	if (type == xSearchlist) {
//		TBXMLElement *hotlist = [TBXML childElementNamed:@"info" parentElement:root];
//	}
//	if (type == xKeysearch) {
//		TBXMLElement *hotlist = [TBXML childElementNamed:@"info" parentElement:root];
//	}
//	if (type == xGetcitys) {
//		TBXMLElement *citylist = [TBXML childElementNamed:@"citylist" parentElement:root];
//		while (citylist != nil) {
//			SPCityData *data = [[SPCityData alloc]init];
//			TBXMLElement *cityid = [TBXML childElementNamed:@"id" parentElement:citylist];
//			TBXMLElement *citycaption = [TBXML childElementNamed:@"caption" parentElement:citylist];
//			
//			data.s_cityID =[TBXML textForElement: cityid];
//			data.s_cityCaption = [TBXML textForElement:citycaption];
//			
//			[dataArray addObject:data];
//		    [data release];
//		}
//	}
//	
//	if (type == xCheckuser) {
//		TBXMLElement *hotlist = [TBXML childElementNamed:@"info" parentElement:root];
//	}
//	if (type ==xSearcharound ) {
//		TBXMLElement *hotlist = [TBXML childElementNamed:@"info" parentElement:root];
//	}
//	if (type == xShowinfo) {
//		TBXMLElement *hotlist = [TBXML childElementNamed:@"info" parentElement:root];
//	}
//	if (type == xAds) {
//		
//		NSString *strPathXml = [[NSBundle mainBundle] pathForResource:@"images" ofType:@"xml"];
//		NSData *xmlData = [[NSData alloc] initWithContentsOfFile:strPathXml];
//		NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
//		[parser setShouldProcessNamespaces:NO];
//		[parser setShouldReportNamespacePrefixes:NO];
//		[parser setShouldResolveExternalEntities:NO];
//		
//		[parser setDelegate:self];
//		[parser parse];
//		
////		TBXMLElement *ads = [TBXML childElementNamed:@"adbanner" parentElement:root];
////		//TBXMLElement *ad =[TBXML  childElementNamed:@"ad" parentElement:ads];
////		
////			SPAdsData *data = [[SPAdsData alloc]init];
//////			TBXMLElement *adid = [TBXML childElementNamed:@"id" parentElement:ads];
//////			TBXMLElement *adposter = [TBXML childElementNamed:@"poster" parentElement:ads];
//////			TBXMLElement *adurl = [TBXML childElementNamed:@"url" parentElement:ads];
////			
////			data.s_adID =[TBXML valueOfAttributeNamed:@"ad" forElement:ads];
////			if (data.s_adID) {
////				;
////			}
////			//data.s_adName = [TBXML textForElement:adposter];
////			//data.s_adURL = [TBXML textForElement:adurl];
////			[dataArray addObject:data];
////		    [data release];
////			//ad = [TBXML nextSiblingNamed:@"id" searchFromElement:ads];
//		
//	}
	return nil;
}

@end