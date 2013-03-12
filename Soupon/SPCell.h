//
//  SPCell.h
//  Soupon
//
//  Created by rjxy rjxy on 13-3-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPCell : UITableViewCell

@property (strong ,nonatomic) IBOutlet UIView *viewCell;
@property (retain, nonatomic) IBOutlet UIImageView *bigImageView;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;

@end
