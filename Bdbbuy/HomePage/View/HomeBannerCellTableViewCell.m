//
//  HomeBannerCellTableViewCell.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/2.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomeBannerCellTableViewCell.h"
#import "SDCycleScrollView.h"

static NSUInteger BannerHeight = 150;

@implementation HomeBannerCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSMutableArray *bannerArr = [NSMutableArray array];
    for (int i = 1; i <= 4; i++) {
        [bannerArr addObject:[NSString stringWithFormat:@"banner%d", i]];
    }
    self.contentView.backgroundColor = [UIColor blueColor];
    CGRect frame = CGRectMake(0, 0, self.contentView.width, BannerHeight);
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame imageNamesGroup:bannerArr];
    [self.contentView addSubview:cycleScrollView];
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
    return BannerHeight;
}

@end
