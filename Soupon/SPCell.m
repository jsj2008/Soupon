//
//  SPCell.m
//  Soupon
//
//  Created by Yuan on 13-3-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//  每一行优惠信息的model类

#import "SPCell.h"
#import "SPCommon.h"

@implementation SPCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	[super initWithStyle:style reuseIdentifier:reuseIdentifier];
	
	if (self) {
		contentTextView = [[UITextView alloc]initWithFrame:CGRectZero];
		[[self contentView]addSubview:contentTextView];
		
		addressTextView = [[UITextView alloc]initWithFrame:CGRectZero];
		
		
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
	CGRect bounds = [[self contentView] bounds];

	CGRect nameLabelFrame = CGRectMake(72, inset, 230, 14);
	[nameLabel setFrame:nameLabelFrame];
	CGRect contentLabelFrame = CGRectMake(65, inset+8, 230, 36);
	[contentTextView setFrame:contentLabelFrame];
	CGRect downNumLabelFrame = CGRectMake(90, bounds.size.height-13, 230, 12);
	[downNumLabel setFrame:downNumLabelFrame];
	
	CGRect addressTextViewFrame = CGRectMake(65, 27, 260, 36);
	[addressTextView setFrame:addressTextViewFrame];	
	
	CGRect imageFrame = CGRectMake(75, bounds.size.height-14, 12, 12);
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
	
	[tImageView setImage:[UIImage imageNamed:@"listview_times_icon.png"]];
}

- (void)setAroundData:(SPAroundInfo *)info{
	nameLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
	nameLabel.textColor = [UIColor redColor];
	[nameLabel setText:info.s_caption];
	
	contentTextView.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
	[contentTextView setEditable:NO];
	[contentTextView setUserInteractionEnabled:NO];
	contentTextView.textColor = [UIColor darkGrayColor];
	[contentTextView setText:info.s_description];
	
	addressTextView.font = [UIFont fontWithName:@"Helvetica-Bold" size:10];
	[addressTextView setEditable:NO];
	[addressTextView setBackgroundColor:[UIColor clearColor]];
	[addressTextView setUserInteractionEnabled:NO];
	addressTextView.textColor = [UIColor darkGrayColor];
	[addressTextView setText:info.s_address];
	[[self contentView]addSubview:addressTextView];
	
	downNumLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
	downNumLabel.textColor = [UIColor darkGrayColor];
	[downNumLabel setText:info.s_distance];

	[tImageView setImage:[UIImage imageNamed:@"nodelist_distance_icon.png"]];

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
