
#import <UIKit/UIKit.h>
#import "BdbGoods.h"

@interface BdbBuyView : UIView
/*
 * 是否显示0
 */
@property (nonatomic, assign) BOOL zearIsShow;
/*
 * 关联的商品模型
 */
@property (nonatomic, strong) BdbGoods *goods;
/*
 * 不显示减号
 */
@property (nonatomic, assign) BOOL zearNeverShow;

@end
