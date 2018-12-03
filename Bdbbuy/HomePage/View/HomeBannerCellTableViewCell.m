//
//  HomeBannerCellTableViewCell.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/2.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "HomeBannerCellTableViewCell.h"
#import "SDCycleScrollView.h"

static NSUInteger BannerHeight = 120;

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
    
    NSArray *bannerArr = [self.cellCard.dataDic objectForKey:@"data"];
    self.contentView.backgroundColor = [UIColor whiteColor];
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
