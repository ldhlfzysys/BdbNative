//
//  BdbHomeRecommendCard.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/6.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbHomeRecommendCard.h"
#import "HomeProductView.h"

@interface BdbHomeRecommendCard ()
@property (nonatomic, weak) HomeProductView * productView;
@end


@implementation BdbHomeRecommendCard

- (UIView *)viewWithCardData:(NSDictionary *)data
{
    CGFloat cellWidth = [data objectForKey:@"cellWidth"] ? [[data objectForKey:@"cellWidth"] floatValue] : [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat margin = 10;
    flowLayout.minimumLineSpacing = margin;
    flowLayout.itemSize = CGSizeMake((cellWidth - 3 * margin) * 0.5, 150);
    
    HomeProductView *view = [[HomeProductView alloc] initWithFlowLayout:flowLayout];
    _productView = view;
    view.top = 0;
    view.left = 0;
    view.width = cellWidth;
    
    NSArray *productsArr = [data objectForKey:@"data"];
    NSMutableArray *cards = [NSMutableArray arrayWithCapacity:productsArr.count ];
    for (NSDictionary *dic in productsArr) {
        BdbCard *card = [[NSClassFromString([BdbCard getCardTypeWithType:BdbCardTypeHomeProduct]) alloc] init];
        card.dataDic = dic;
        [cards addObject:card];
    }
    view.headerBtnHeight = 80;
    view.headerButtonImageName = @"banner2";
    view.products = [cards copy];
    view.scrollEnable = NO;
    
    return view;
}


- (CGFloat)computeCardHeight
{
    return [_productView getViewHeight];
}

@end
