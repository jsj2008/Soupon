//
//  SPCell.m
//  Soupon
//
//  Created by rjxy rjxy on 13-3-12.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SPCell.h"
#import "SPCommon.h"

@implementation SPCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	[super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	if (self) {
		contentTextView = [[UITextView alloc]initWithFrame:CGRectZero];
		[[self contentView]addSubview:contentTextView];
		
		nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
		[[self contentView]addSubview:nameLabel];
		
		downNumLabel = [[UILabel alloc]initWithFrame:CGRectZero];
		[[self contentView]addSubview:downNumLabel];
		
		tImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
		[[self contentView]addSubview:tImageView];
		
		[nameLabel release];
		[contentTextView release];
		[downNumLabel release];
		[tImageView release];
	}
	return self;
}

- (void)layoutSubviews{
	[super layoutSubviews];

	float inset = 3.0;

	CGRect nameLabelFrame = CGRectMake(72, inset, 230, 14);
	[nameLabel setFrame:nameLabelFrame];
	CGRect contentLabelFrame = CGRectMake(65, inset+8, 230, 36);
	[contentTextView setFrame:contentLabelFrame];
	CGRect downNumLabelFrame = CGRectMake(85, 55, 230, 12);
	[downNumLabel setFrame:downNumLabelFrame];
	
	CGRect imageFrame = CGRectMake(75, 55, 12, 12);
	[tImageView setImage:[UIImage imageNamed:@"listview_times_icon.png"]];
	[tImageView setFrame:imageFrame];
}

- (void)setHotData:(SPHotData *)data{
	nameLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
	nameLabel.textColor = [UIColor redColor];
	[nameLabel setText:data.s_caption];
	
	contentTextView.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
	[contentTextView setEditable:NO];
	[contentTextView setUserInteractionEnabled:NO];
	contentTextView.textColor = [UIColor darkGrayColor];
	[contentTextView setText:data.s_description];
	
	downNumLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
	downNumLabel.textColor = [UIColor darkGrayColor];
	[downNumLabel setText:data.s_popularity];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [super dealloc];
}
@end
