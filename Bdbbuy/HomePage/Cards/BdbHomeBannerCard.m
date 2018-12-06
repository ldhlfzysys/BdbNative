//
//  BdbHomeBannerCard.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/6.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbHomeBannerCard.h"
#import "SDCycleScrollView.h"

@implementation BdbHomeBannerCard


static NSUInteger BannerHeight = 120;
#pragma mark - BdbCardProtocol
- (UIView *)viewWithCardData:(NSDictionary *)data
{
    NSArray *bannerArr = [data objectForKey:@"data"];
    CGFloat cellWidth = [data objectForKey:@"cellWidth"] ? [[data objectForKey:@"cellWidth"] floatValue] : [UIScreen mainScreen].bounds.size.width;
    
    CGRect frame = CGRectMake(0, 0, cellWidth, BannerHeight);
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame imageNamesGroup:bannerArr];
    return cycleScrollView;
}


- (CGFloat)computeCardHeight
{
    return BannerHeight;
}

@end
