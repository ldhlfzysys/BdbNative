
#import <UIKit/UIKit.h>
#import "BdbGoods.h"
typedef void(^ClikedCellback) (BdbGoods *goods);

typedef enum : NSUInteger {
    BdbHomeCellTypeVerticalScreen,
    BdbHomeCellTypeCrossScreen
} BdbHomeCellType;

@interface BdbHomeCell : UICollectionViewCell
@property (nonatomic, strong) BdbGoods *goods;
/*
 * 不显示减号
 */
@property (nonatomic, assign) BOOL zearNeverShow;
@property (nonatomic, copy) ClikedCellback cellback;
@end
