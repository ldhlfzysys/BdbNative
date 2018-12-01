//
//  HomeGoodsCell.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomeGoodsCell.h"

@implementation HomeGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
        view.backgroundColor = [UIColor orangeColor];
        self.backgroundView = view;
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
