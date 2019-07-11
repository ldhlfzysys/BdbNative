
#import <Foundation/Foundation.h>
#import "BdbGoods.h"

@interface BdbUserShopCarTool : NSObject
@property (nonatomic, strong) NSMutableArray <BdbGoods *> *shopCar;

+ (instancetype)sharedInstance;
- (void)addSupermarkProductToShopCar:(BdbGoods *)goods;
- (void)removeFromProductShopCar:(BdbGoods*)goods;
- (CGFloat)getShopCarGoodsPrice ;
- (NSInteger)getShopCarGoodsNumber;
- (BOOL)isEmpty;
-(void)removeAll;

@end
