//
//  SPCommon.h
//  Soupon
//
//  Created by rjxy rjxy on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
#import "Status.h"

@interface SPCommon : NSObject{

}

+(NSMutableArray*)parserXML:(NSString *)dataString type:(ParserType)type;

@end
