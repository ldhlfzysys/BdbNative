//
//  BdbCard.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbCard.h"
#import "BdbTableViewCell.h"

@implementation BdbCard

#pragma mark - Public
+ (NSString *)getCardTypeWithType:(BdbCardType)type
{
    NSString *cardType =@"";
    switch (type) {
        case BdbCardTypeHomeBanner:
        {
            cardType = @"BdbHomeBannerCard";
        }
            break;
        case BdbCardTypeHomeCatogery:
        {
            cardType = @"BdbHomeCatogeryCard";
        }
            break;
        case BdbCardTypeHomeProducts:
        {
            cardType = @"BdbHomeProductsCard";
        }
            break;
        case BdbCardTypeHomeRecommend:
        {
            cardType = @"BdbHomeRecommendCard";
        }
            break;
            
            
        case BdbCardTypeHomeProduct:
        {
            cardType = @"BdbHomeProductCard";
        }
            break;
            
        default:
            break;
    }
    
    NSAssert(cardType.length > 0, @"请配置Card");
    return  cardType;
}
@end

@implementation BdbMultiCard

-(NSMutableArray *)subcards
{
    if (_subcards == nil) {
        _subcards = [NSMutableArray array];
    }
    return _subcards;
}



@end
