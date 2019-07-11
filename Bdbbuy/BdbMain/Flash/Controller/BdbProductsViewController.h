

#import <UIKit/UIKit.h>
#import "BdbBaseViewController.h"
#import "BdbSupermarketSource.h"
#import "BdbFlashViewController.h"

@interface BdbProductsViewController : BdbBaseViewController<BdbFlashViewControllerDelegate>
@property (nonatomic, strong) SuperMarketData *supermarketSouce;
@end
