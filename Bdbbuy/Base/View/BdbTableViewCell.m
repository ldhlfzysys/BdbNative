//
//  BdbTableViewCell.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbTableViewCell.h"


@implementation BdbTableViewCell

@synthesize delegate;

- (void)setFrame:(CGRect)frame{
    // 解决右侧留白问题
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    frame.origin.x = 0;
    
    [super setFrame:frame];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (CGFloat)computeCellHeight
{
    return 0;
}

@end
