
#import <UIKit/UIKit.h>
#import "BdbSupermarketSource.h"

@interface BdbFlashCell : UITableViewCell

@property (nonatomic, strong) ProductCategory *categoryData;
+ (instancetype)cellWithTable:(UITableView *)tableView;
@end
