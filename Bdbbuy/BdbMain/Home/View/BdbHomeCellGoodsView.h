
#import <UIKit/UIKit.h>
#import "BdbHomeHeadData.h"
#import "BdbHomeCell.h"
@interface BdbHomeCellGoodsView : UIView
@property (nonatomic, strong) ActRow *actRow;
@property (nonatomic, copy) ClikedCellback cellback;
@end
