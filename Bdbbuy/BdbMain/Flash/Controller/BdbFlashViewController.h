
#import "BdbSelectedAdressViewController.h"

@protocol BdbFlashViewControllerDelegate <NSObject>

- (void)didTableView:(UITableView *)tableView clickIndexPath:(NSIndexPath *)indexPath;

@end

@interface BdbFlashViewController : BdbSelectedAdressViewController
@property (nonatomic, weak) id<BdbFlashViewControllerDelegate>delegate;
@end
