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
    flowLayout.itemSize = CGSizeMake((cellWidth - 3 * margin) * 0.5, 220);
    
    HomeProductView *view = [[HomeProductView alloc] initWithFlowLayout:flowLayout];
    _productView = view;
    [self refreshView:view WithData:data];
    return view;
}

-(void)refreshView:(UIView *)view WithData:(NSDictionary *)data
{
    if (!_productView) {
        _productView = (HomeProductView *)view;
    }
    
    CGFloat cellWidth = [data objectForKey:@"cellWidth"] ? [[data objectForKey:@"cellWidth"] floatValue] : [UIScreen mainScreen].bounds.size.width;
    view.top = 0;
    view.left = 0;
    view.width = cellWidth;
    
    NSArray *productsArr = [data objectForKey:@"data"];
    NSMutableArray *cards = [NSMutableArray arrayWithCapacity:productsArr.count ];
    for (NSDictionary *dic in productsArr) {
        BdbCard *card = [[NSClassFromString([BdbCard getCardTypeWithType:BdbCardTypeHomeProduct]) alloc] init];
        NSMutableDictionary *cardDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        [cardDic setValue:@(13) forKey:@"productFontSize"];
        [cardDic setValue:@(16) forKey:@"priceFontSize"];
        card.dataDic = [cardDic copy];
        [cards addObject:card];
    }
    ((HomeProductView *)view).headerBtnHeight = 80;
    ((HomeProductView *)view).headerButtonImageName = [data objectForKey:@"image"];
    ((HomeProductView *)view).products = [cards copy];
    ((HomeProductView *)view).scrollEnable = NO;
    
    _productView.delegate = self.delegate;
}


- (CGFloat)computeCardHeight
{
    return [_productView getViewHeight];
}

@end
