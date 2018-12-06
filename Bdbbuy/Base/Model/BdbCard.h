//
//  BdbCard.h
//  Bdbbuy
//
//  Created by liweixi on 2018/12/1.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BdbCardType) {
    BdbCardTypeHomeBanner = 1,
    BdbCardTypeHomeCatogery = 2,
    BdbCardTypeHomeProducts = 3,
    BdbCardTypeHomeRecommend = 4
};

@interface BdbCard : NSObject
@property (nonatomic, copy) NSString *cardClassID; // cell的Identifier
@property (nonatomic, assign) NSInteger cardHeight; // cell的高度
@property (nonatomic, strong) NSDictionary *dataDic; // 数据信息
@property (nonatomic, weak) id delegate;

+ (NSString *)getCardTypeWithType:(BdbCardType)type;
- (CGFloat)computeCardHeight;
@end


@interface BdbMultiCard : BdbCard
@property (nonatomic, strong) NSMutableArray<BdbCard *> *subcards;
@end

