
#import "BdbGoods.h"

@implementation GoodsData
+ (void)loadGoodsData:(CompleteBlock)complete {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"首页新鲜热卖" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    GoodsData *goodsData = [GoodsData mj_objectWithKeyValues:json];
    complete(goodsData.data,nil);
}



+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data":NSStringFromClass([BdbGoods class])};
}

@end

@implementation BdbGoods


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"gid" : @"id"};
}
@end
