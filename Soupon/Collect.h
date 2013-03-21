//
//  Collect.h
//  Soupon
//
//  Created by rjxy rjxy on 13-3-19.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Collect : NSManagedObject

@property (nonatomic, retain) NSString * caption;
@property (nonatomic, retain) NSString * discreption;
@property (nonatomic, retain) NSString * indate;
@property (nonatomic, retain) UIImage* image;
 
@end
