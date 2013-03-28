//
//  SPCommon.h
//  Soupon
//
//  Created by Yuan on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
#import "Status.h"

@interface SPCommon : NSObject{

}

+ (NSMutableArray *)parserXML:(NSString *)dataString type:(ParserType)type;
+ (NSMutableArray *)parserKeySearchXML:(NSString *)dataString type:(KeySearchType)type;
@end
