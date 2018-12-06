//
//  BdbCardTableViewCell.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/3.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbCardTableViewCell.h"

@implementation BdbCardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier cellCard:(BdbCard *)cellCard
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cellCard = cellCard;
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
