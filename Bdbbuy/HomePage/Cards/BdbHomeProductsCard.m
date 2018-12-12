//
//  BdbHomeProductsCard.m
//  Bdbbuy
//
//  Created by liweixi on 2018/12/6.
//  Copyright © 2018 bdbbuy. All rights reserved.
//

#import "BdbHomeProductsCard.h"
#import "HomeProductView.h"

@interface BdbHomeProductsCard ()
@property (nonatomic, weak) HomeProductView * productView;
@end

@implementation BdbHomeProductsCard

- (UIView *)viewWithCardData:(NSDictionary *)data
{
    CGFloat cellWidth = [data objectForKey:@"cellWidth"] ? [[data objectForKey:@"cellWidth"] floatValue] : [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat margin = 5;
    flowLayout.minimumLineSpacing = margin;
    flowLayout.itemSize = CGSizeMake((cellWidth - 5 * margin) / 4.5, 140);
    
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
        [cardDic setValue:@(11) forKey:@"productFontSize"];
        [cardDic setValue:@(13) forKey:@"priceFontSize"];
        card.dataDic = [cardDic copy];
        [cards addObject:card];
    }
    
    ((HomeProductView *)view).headerBtnHeight = 130;
    ((HomeProductView *)view).headerURL = [data objectForKey:@"url"];
    ((HomeProductView *)view).headerButtonImageName = [data objectForKey:@"image"];
    ((HomeProductView *)view).products = [cards copy];
    ((HomeProductView *)view).scrollEnable = YES;
    
    _productView.delegate = self.delegate;
}


- (CGFloat)computeCardHeight
{
    return [_productView getViewHeight];
}
@end
