
#import "BdbUserShopCarTool.h"
#import "NSString+Extension.h"

@implementation BdbUserShopCarTool

+ (instancetype)sharedInstance{
    static dispatch_once_t one;
    static BdbUserShopCarTool *shopCarTool;
    dispatch_once(&one, ^{
        if (shopCarTool == nil) {
            shopCarTool = [[BdbUserShopCarTool alloc]init];
        }
    });
    return shopCarTool;
}


- (NSMutableArray<BdbGoods *> *)shopCar
{
    if (!_shopCar) {
        _shopCar = [NSMutableArray array];
    }
    return  _shopCar;
}

#pragma 添加商品
- (void)addSupermarkProductToShopCar:(BdbGoods *)goods {
    
    
    for (BdbGoods *obj in self.shopCar) {
        if (obj.gid == goods.gid) {
            return;
        }
    }
    [self.shopCar addObject:goods];
}

-(void)removeAll
{
    for (BdbGoods *obj in self.shopCar) {
            [self.shopCar removeObject:obj];
            [[NSNotificationCenter defaultCenter] postNotificationName:LFBShopCarDidRemoveProductNSNotification object:self userInfo:nil];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:LFBShopCarBuyNumberDidChangeNotification object:nil];
}
#pragma 删除商品
- (void)removeFromProductShopCar:(BdbGoods*)goods {
    for (BdbGoods *obj in self.shopCar) {
        if (goods.gid == obj.gid) {
            [self.shopCar removeObject:goods];
            [[NSNotificationCenter defaultCenter] postNotificationName:LFBShopCarDidRemoveProductNSNotification object:self userInfo:nil];
            return ;
        }
    }
}
#pragma 获取商品的数量
- (NSInteger)getShopCarGoodsNumber {
    __block NSInteger count = 0;
    [self.shopCar enumerateObjectsUsingBlock:^(BdbGoods * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        count += obj.userBuyNumber;
    }];
    return count;
}
#pragma 获取商品用价格
- (CGFloat)getShopCarGoodsPrice {
    __block CGFloat price = 0;
    [self.shopCar enumerateObjectsUsingBlock:^(BdbGoods *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        price += [[obj.price cleanDecimalPointZear] doubleValue] * obj.userBuyNumber;
    }];
    return price;
}
- (BOOL)isEmpty {
    return self.shopCar.count == 0;
}


@end
