
#import <UIKit/UIKit.h>
#import "BdbHomeHeadData.h"
#import "BdbHomeCellTitleView.h"
#import "BdbHomeCellGoodsView.h"

@interface BdbHomeCategoryCell : UICollectionViewCell
@property (nonatomic, strong) ActRow *cellInfo;
@property (nonatomic, copy) ClikedCellback cellback;

@end
